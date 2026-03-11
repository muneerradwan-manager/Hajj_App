import 'package:dio/dio.dart';
import 'package:bawabatelhajj/core/constants/app_urls.dart';
import 'package:bawabatelhajj/core/network/dio_client.dart';
import 'package:bawabatelhajj/features/auth/data/models/auth_session_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/confirm_email_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/forgot_password_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/login_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/register_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/refresh_token_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/reset_password_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/resend_confirm_email_request_model.dart';
import 'package:bawabatelhajj/features/auth/data/models/user_profile_model.dart';

class AuthRemoteDataSource {
  final DioClient _dioClient;
  static const Duration _loginRetryReceiveTimeout = Duration(seconds: 75);

  AuthRemoteDataSource(this._dioClient);

  Future<String> register(RegisterRequestModel request) async {
    final response = await _dioClient.post<dynamic>(
      AppUrls.register,
      data: request.toJson(),
    );

    return _extractMessage(response.data, fallback: 'Registration successful.');
  }

  Future<AuthSessionModel> login(LoginRequestModel request) async {
    try {
      final response = await _dioClient.post<dynamic>(
        AppUrls.login,
        data: request.toJson(),
      );

      final map = _extractMap(response.data);
      return AuthSessionModel.fromJson(map);
    } on DioException catch (error) {
      if (!_isRetryableLoginTimeout(error)) rethrow;

      // Azure App Service cold start: the server responded with 200 but Dio's
      // timer fired first. Use the response directly if it's already valid.
      final existingResponse = error.response;
      if (existingResponse?.statusCode == 200 && existingResponse?.data != null) {
        final map = _extractMap(existingResponse!.data);
        final session = AuthSessionModel.fromJson(map);
        if (session.token.isNotEmpty) return session;
      }

      // No valid response yet — retry with a longer timeout.
      final retryResponse = await _dioClient.post<dynamic>(
        AppUrls.login,
        data: request.toJson(),
        options: Options(receiveTimeout: _loginRetryReceiveTimeout),
      );

      final retryMap = _extractMap(retryResponse.data);
      return AuthSessionModel.fromJson(retryMap);
    }
  }

  Future<UserProfileModel> getMe() async {
    final response = await _dioClient.get<dynamic>(AppUrls.me);
    final map = _extractMap(response.data);
    return UserProfileModel.fromJson(map);
  }

  Future<void> updateSaudiNumber(String saudiNum) async {
    await _dioClient.put<dynamic>(
      AppUrls.saudiNum,
      data: {'saudiNum': saudiNum},
    );
  }

  Future<String> logout() async {
    final response = await _dioClient.post<dynamic>(
      AppUrls.logout,
      options: Options(validateStatus: (_) => true),
    );

    final message = _extractMessage(response.data, fallback: 'Logged out.');
    final statusCode = response.statusCode ?? 0;
    final isSuccessStatus = statusCode >= 200 && statusCode < 300;
    final normalizedMessage = message.toLowerCase();
    final indicatesLoggedOut =
        normalizedMessage.contains('logged out') ||
        normalizedMessage.contains('logout');

    if (!isSuccessStatus && !indicatesLoggedOut) {
      throw DioException.badResponse(
        statusCode: statusCode,
        requestOptions: response.requestOptions,
        response: response,
      );
    }

    return message;
  }

  Future<AuthSessionModel> refreshToken(
    RefreshTokenRequestModel request,
  ) async {
    final response = await _dioClient.post<dynamic>(
      AppUrls.refresh,
      data: request.toJson(),
      options: Options(validateStatus: (_) => true),
    );

    final map = _extractMap(response.data);
    final session = AuthSessionModel.fromJson(map);
    if (session.token.isNotEmpty && session.refreshToken.isNotEmpty) {
      return session;
    }

    throw DioException.badResponse(
      statusCode: response.statusCode ?? 400,
      requestOptions: response.requestOptions,
      response: response,
    );
  }

  Future<String> confirmEmail(ConfirmEmailRequestModel request) async {
    final response = await _dioClient.post<dynamic>(
      AppUrls.verifyOtp,
      data: request.toJson(),
    );

    return _extractMessage(
      response.data,
      fallback: 'Email confirmed successfully.',
    );
  }

  Future<String> resendConfirmEmail(
    ResendConfirmEmailRequestModel request,
  ) async {
    final response = await _dioClient.post<dynamic>(
      AppUrls.resendOtp,
      data: request.toJson(),
    );

    return _extractMessage(
      response.data,
      fallback: 'If the email exists, an OTP has been sent.',
    );
  }

  Future<String> forgotPassword(ForgotPasswordRequestModel request) async {
    final response = await _dioClient.post<dynamic>(
      AppUrls.sendResetLink,
      data: request.toJson(),
    );

    return _extractMessage(
      response.data,
      fallback: 'If the email exists, an OTP has been sent.',
    );
  }

  Future<String> resetPassword(ResetPasswordRequestModel request) async {
    final response = await _dioClient.post<dynamic>(
      AppUrls.resetPassword,
      data: request.toJson(),
    );

    return _extractMessage(
      response.data,
      fallback: 'Password reset successful.',
    );
  }

  String _extractMessage(dynamic data, {required String fallback}) {
    if (data is Map<String, dynamic>) {
      final message = data['message']?.toString().trim();
      if (message != null && message.isNotEmpty) {
        return message;
      }
    } else if (data is Map) {
      final map = data.map((key, value) => MapEntry(key.toString(), value));
      final message = map['message']?.toString().trim();
      if (message != null && message.isNotEmpty) {
        return message;
      }
    }

    return fallback;
  }

  Map<String, dynamic> _extractMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    return <String, dynamic>{};
  }

  bool _isRetryableLoginTimeout(DioException error) {
    return error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionTimeout;
  }
}
