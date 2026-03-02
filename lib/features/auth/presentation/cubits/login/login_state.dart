import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isSubmitting;
  final bool isAuthenticated;
  final String errorMessage;
  final String infoMessage;

  const LoginState({
    required this.isSubmitting,
    required this.isAuthenticated,
    required this.errorMessage,
    required this.infoMessage,
  });

  const LoginState.initial()
    : isSubmitting = false,
      isAuthenticated = false,
      errorMessage = '',
      infoMessage = '';

  LoginState copyWith({
    bool? isSubmitting,
    bool? isAuthenticated,
    String? errorMessage,
    String? infoMessage,
  }) {
    return LoginState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage ?? this.errorMessage,
      infoMessage: infoMessage ?? this.infoMessage,
    );
  }

  @override
  List<Object?> get props => [
    isSubmitting,
    isAuthenticated,
    errorMessage,
    infoMessage,
  ];
}
