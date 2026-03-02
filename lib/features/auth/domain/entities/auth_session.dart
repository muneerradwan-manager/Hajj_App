import 'package:equatable/equatable.dart';

class AuthSession extends Equatable {
  final String token;
  final String refreshToken;
  final DateTime? expiresAt;
  final DateTime? refreshTokenExpiresAt;

  const AuthSession({
    required this.token,
    required this.refreshToken,
    this.expiresAt,
    this.refreshTokenExpiresAt,
  });

  @override
  List<Object?> get props => [
    token,
    refreshToken,
    expiresAt,
    refreshTokenExpiresAt,
  ];
}
