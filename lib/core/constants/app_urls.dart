import '../config/env_config.dart';

class AppUrls {
  static String get baseUrl => EnvConfig.apiBaseUrl;
  static const String login = '/Auth/login';
  static const String logout = '/Auth/logout';
  static const String register = '/Auth/register';
  static const String verifyOtp = '/Auth/confirm-email';
  static const String resendOtp = '/Auth/resend-confirm-email';
  static const String refresh = '/Auth/refresh-token';
  static const String sendResetLink = '/Auth/forgot-password';
  static const String resetPassword = '/Auth/reset-password';
}
