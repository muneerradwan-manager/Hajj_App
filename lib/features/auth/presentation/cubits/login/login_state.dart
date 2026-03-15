import 'package:equatable/equatable.dart';

enum LoginStatus { initial, submitting, authenticated }

class LoginState extends Equatable {
  final LoginStatus status;
  final String errorMessage;
  final String infoMessage;

  const LoginState({
    required this.status,
    required this.errorMessage,
    required this.infoMessage,
  });

  const LoginState.initial()
    : status = LoginStatus.initial,
      errorMessage = '',
      infoMessage = '';

  bool get isSubmitting => status == LoginStatus.submitting;
  bool get isAuthenticated => status == LoginStatus.authenticated;

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    String? infoMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      infoMessage: infoMessage ?? this.infoMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    infoMessage,
  ];
}
