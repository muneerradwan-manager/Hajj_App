import 'package:equatable/equatable.dart';

import 'package:hajj_app/features/auth/domain/entities/register_draft.dart';

class RegisterState extends Equatable {
  final RegisterDraft draft;
  final int stepNumber;
  final bool isHydrated;
  final bool isSubmitting;
  final bool isConfirmingEmail;
  final bool isResendingCode;
  final String errorMessage;
  final String infoMessage;

  const RegisterState({
    required this.draft,
    required this.stepNumber,
    required this.isHydrated,
    required this.isSubmitting,
    required this.isConfirmingEmail,
    required this.isResendingCode,
    required this.errorMessage,
    required this.infoMessage,
  });

  const RegisterState.initial()
    : draft = const RegisterDraft(),
      stepNumber = 1,
      isHydrated = false,
      isSubmitting = false,
      isConfirmingEmail = false,
      isResendingCode = false,
      errorMessage = '',
      infoMessage = '';

  RegisterState copyWith({
    RegisterDraft? draft,
    int? stepNumber,
    bool? isHydrated,
    bool? isSubmitting,
    bool? isConfirmingEmail,
    bool? isResendingCode,
    String? errorMessage,
    String? infoMessage,
  }) {
    return RegisterState(
      draft: draft ?? this.draft,
      stepNumber: stepNumber ?? this.stepNumber,
      isHydrated: isHydrated ?? this.isHydrated,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isConfirmingEmail: isConfirmingEmail ?? this.isConfirmingEmail,
      isResendingCode: isResendingCode ?? this.isResendingCode,
      errorMessage: errorMessage ?? this.errorMessage,
      infoMessage: infoMessage ?? this.infoMessage,
    );
  }

  @override
  List<Object?> get props => [
    draft,
    stepNumber,
    isHydrated,
    isSubmitting,
    isConfirmingEmail,
    isResendingCode,
    errorMessage,
    infoMessage,
  ];
}
