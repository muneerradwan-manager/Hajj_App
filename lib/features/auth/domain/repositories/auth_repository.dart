import 'package:dartz/dartz.dart';

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/auth/domain/entities/auth_session.dart';
import 'package:hajj_app/features/auth/domain/entities/register_draft.dart';
import 'package:hajj_app/features/auth/domain/entities/user_profile.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthSession>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserProfile>> getMe();
  Future<Either<Failure, String>> logout();
  Future<Either<Failure, AuthSession>> refreshSession();

  Future<Either<Failure, String>> register(RegisterDraft draft);
  Future<Either<Failure, String>> confirmEmail({
    required String email,
    required String otp,
  });
  Future<Either<Failure, String>> resendConfirmEmail({required String email});
  Future<Either<Failure, String>> forgotPassword({required String email});
  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  });

  Future<Either<Failure, RegisterDraft?>> loadRegisterDraft();

  Future<Either<Failure, void>> saveRegisterDraft(RegisterDraft draft);

  Future<Either<Failure, void>> clearRegisterDraft();
}
