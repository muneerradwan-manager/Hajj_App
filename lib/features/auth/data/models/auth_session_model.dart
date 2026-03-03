import 'package:bawabatelhajj/features/auth/domain/entities/auth_session.dart';

class AuthSessionModel {
  final String token;
  final String refreshToken;
  final DateTime? expiresAt;
  final DateTime? refreshTokenExpiresAt;

  const AuthSessionModel({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
    required this.refreshTokenExpiresAt,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      token: (json['token'] ?? '').toString().trim(),
      refreshToken: (json['refreshToken'] ?? '').toString().trim(),
      expiresAt: _parseDate(json['expiresAt']),
      refreshTokenExpiresAt: _parseDate(json['refreshTokenExpiresAt']),
    );
  }

  AuthSession toEntity() {
    return AuthSession(
      token: token,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
      refreshTokenExpiresAt: refreshTokenExpiresAt,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    final normalized = value.toString().trim();
    if (normalized.isEmpty) return null;
    return DateTime.tryParse(normalized);
  }
}
