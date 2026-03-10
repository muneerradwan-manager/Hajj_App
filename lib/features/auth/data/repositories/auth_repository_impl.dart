import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/core/network/api_error_handler.dart';
import 'package:bawabatelhajj/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:bawabatelhajj/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bawabatelhajj/features/auth/data/datasources/register_local_data_source.dart';
import 'package:bawabatelhajj/features/auth/data/models/auth_session_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/confirm_email_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/forgot_password_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/login_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/register_draft_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/register_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/refresh_token_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/reset_password_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/resend_confirm_email_request_model.dart';
import 'package:bawabatelhajj/features/auth/domain/entities/user_profile.dart';
import 'package:bawabatelhajj/features/auth/domain/entities/auth_session.dart';
import 'package:bawabatelhajj/features/auth/domain/entities/register_draft.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final RegisterLocalDataSource _registerLocalDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._registerLocalDataSource,
    this._authLocalDataSource,
  );

  @override
  Future<Either<Failure, AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequestModel(
        email: email.trim(),
        password: password.trim(),
      );
      final model = await _remoteDataSource.login(request);
      await _saveSessionTokens(model);
      return right(model.toEntity());
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> getMe() async {
    try {
      final model = await _remoteDataSource.getMe();
      await _authLocalDataSource.saveCachedProfile(model);
      return right(model.toEntity());
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<UserProfile?> getCachedMe() async {
    final model = await _authLocalDataSource.getCachedProfile();
    return model?.toEntity();
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final message = await _remoteDataSource.logout();
      await _authLocalDataSource.clearTokens();
      return right(message);
    } on Exception catch (error) {
      final failure = ApiErrorHandler.handle(error);
      if (failure is UnauthorizedFailure &&
          failure.userMessage.toLowerCase().contains('logged out')) {
        await _authLocalDataSource.clearTokens();
        return right(failure.userMessage);
      }
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, AuthSession>> refreshSession() async {
    try {
      final refreshToken = await _authLocalDataSource.getRefreshToken();
      if (refreshToken == null || refreshToken.trim().isEmpty) {
        return left(
          const UnauthorizedFailure('Invalid or expired refresh token.'),
        );
      }

      final request = RefreshTokenRequestModel(
        refreshToken: refreshToken.trim(),
      );
      final model = await _remoteDataSource.refreshToken(request);
      await _saveSessionTokens(model);
      return right(model.toEntity());
    } on Exception catch (error) {
      await _authLocalDataSource.clearTokens();
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, String>> register(RegisterDraft draft) async {
    try {
      final request = RegisterRequestModel.fromDraft(draft);
      final message = await _remoteDataSource.register(request);
      return right(message);
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, String>> confirmEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final request = ConfirmEmailRequestModel(
        email: email.trim(),
        otp: otp.trim(),
      );
      final message = await _remoteDataSource.confirmEmail(request);
      return right(message);
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, String>> resendConfirmEmail({
    required String email,
  }) async {
    try {
      final request = ResendConfirmEmailRequestModel(email: email.trim());
      final message = await _remoteDataSource.resendConfirmEmail(request);
      return right(message);
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  }) async {
    try {
      final request = ForgotPasswordRequestModel(email: email.trim());
      final message = await _remoteDataSource.forgotPassword(request);
      return right(message);
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final request = ResetPasswordRequestModel(
        email: email.trim(),
        otp: otp.trim(),
        newPassword: newPassword.trim(),
        confirmPassword: confirmPassword.trim(),
      );
      final message = await _remoteDataSource.resetPassword(request);
      return right(message);
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, RegisterDraft?>> loadRegisterDraft() async {
    try {
      final model = await _registerLocalDataSource.loadDraft();
      return right(model?.toEntity());
    } on Exception catch (_) {
      return left(const UnknownFailure('Failed to load register draft.'));
    }
  }

  @override
  Future<Either<Failure, void>> saveRegisterDraft(RegisterDraft draft) async {
    try {
      final model = RegisterDraftModel.fromEntity(draft);
      await _registerLocalDataSource.saveDraft(model);
      return right(null);
    } on Exception catch (_) {
      return left(const UnknownFailure('Failed to save register draft.'));
    }
  }

  @override
  Future<Either<Failure, void>> clearRegisterDraft() async {
    try {
      await _registerLocalDataSource.clearDraft();
      return right(null);
    } on Exception catch (_) {
      return left(const UnknownFailure('Failed to clear register draft.'));
    }
  }

  @override
  Future<Either<Failure, void>> updateSaudiNumber(String saudiNum) async {
    try {
      await _remoteDataSource.updateSaudiNumber(saudiNum);
      return right(null);
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  Future<void> _saveSessionTokens(AuthSessionModel model) async {
    if (model.token.isEmpty || model.refreshToken.isEmpty) {
      throw Exception('Invalid login response.');
    }
    await _authLocalDataSource.saveTokens(
      token: model.token,
      refreshToken: model.refreshToken,
    );
  }
}
