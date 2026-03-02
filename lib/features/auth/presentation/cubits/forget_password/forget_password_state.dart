import 'package:equatable/equatable.dart';

class ForgetPasswordState extends Equatable {
  final int stepNumber;
  final String email;
  final bool isSendingOtp;
  final bool isResendingOtp;
  final bool isResettingPassword;
  final String errorMessage;
  final String infoMessage;

  const ForgetPasswordState({
    required this.stepNumber,
    required this.email,
    required this.isSendingOtp,
    required this.isResendingOtp,
    required this.isResettingPassword,
    required this.errorMessage,
    required this.infoMessage,
  });

  const ForgetPasswordState.initial()
    : stepNumber = 1,
      email = '',
      isSendingOtp = false,
      isResendingOtp = false,
      isResettingPassword = false,
      errorMessage = '',
      infoMessage = '';

  ForgetPasswordState copyWith({
    int? stepNumber,
    String? email,
    bool? isSendingOtp,
    bool? isResendingOtp,
    bool? isResettingPassword,
    String? errorMessage,
    String? infoMessage,
  }) {
    return ForgetPasswordState(
      stepNumber: stepNumber ?? this.stepNumber,
      email: email ?? this.email,
      isSendingOtp: isSendingOtp ?? this.isSendingOtp,
      isResendingOtp: isResendingOtp ?? this.isResendingOtp,
      isResettingPassword: isResettingPassword ?? this.isResettingPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      infoMessage: infoMessage ?? this.infoMessage,
    );
  }

  @override
  List<Object?> get props => [
    stepNumber,
    email,
    isSendingOtp,
    isResendingOtp,
    isResettingPassword,
    errorMessage,
    infoMessage,
  ];
}
