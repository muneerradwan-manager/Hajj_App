import '../config/env_config.dart';

class AppUrls {
  static String get baseUrl => EnvConfig.apiBaseUrl;
  // Auth
  static const String login = '/Auth/login';
  static const String logout = '/Auth/logout';
  static const String register = '/Auth/register';
  static const String verifyOtp = '/Auth/confirm-email';
  static const String resendOtp = '/Auth/resend-confirm-email';
  static const String refresh = '/Auth/refresh-token';
  static const String sendResetLink = '/Auth/forgot-password';
  static const String resetPassword = '/Auth/reset-password';
  // Home + Profile
  static const String me = '/Auth/me';
  static const String saudiNum = '/Auth/me/saudi-num';
  // Complaints
  static const String complaints = '/Complaints';
  static const String complaintCategories = '/ComplaintCategories';
  static const String complaintKinds = '/ComplaintKinds';
  static const String complaintStatuses = '/ComplaintStatuses';
}
