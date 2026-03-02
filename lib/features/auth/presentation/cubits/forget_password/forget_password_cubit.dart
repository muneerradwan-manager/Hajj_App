import 'package:hajj_app/core/cubits/safe_cubit.dart';
import 'package:hajj_app/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:hajj_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:hajj_app/features/auth/presentation/cubits/forget_password/forget_password_state.dart';

class ForgetPasswordCubit extends SafeCubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._forgotPasswordUseCase, this._resetPasswordUseCase)
    : super(const ForgetPasswordState.initial());

  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  static const int _emailStep = 1;
  static const int _resetStep = 2;
  static const int _successStep = 3;

  Future<void> sendResetOtp(String email, {bool isResend = false}) async {
    if (state.isSendingOtp ||
        state.isResendingOtp ||
        state.isResettingPassword) {
      return;
    }

    final normalizedEmail = email.trim();
    safeEmit(
      state.copyWith(
        email: normalizedEmail,
        isSendingOtp: !isResend,
        isResendingOtp: isResend,
        isResettingPassword: false,
        errorMessage: '',
        infoMessage: '',
      ),
    );

    final result = await _forgotPasswordUseCase(email: normalizedEmail);
    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          isSendingOtp: false,
          isResendingOtp: false,
          errorMessage: failure.userMessage,
          infoMessage: '',
        ),
      ),
      (message) => safeEmit(
        state.copyWith(
          email: normalizedEmail,
          stepNumber: _resetStep,
          isSendingOtp: false,
          isResendingOtp: false,
          isResettingPassword: false,
          errorMessage: '',
          infoMessage: message,
        ),
      ),
    );
  }

  Future<void> submitResetPassword({
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (state.isResettingPassword || state.email.trim().isEmpty) return;

    safeEmit(
      state.copyWith(
        isResettingPassword: true,
        isSendingOtp: false,
        isResendingOtp: false,
        errorMessage: '',
        infoMessage: '',
      ),
    );

    final result = await _resetPasswordUseCase(
      email: state.email,
      otp: otp.trim(),
      newPassword: newPassword.trim(),
      confirmPassword: confirmPassword.trim(),
    );

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          isResettingPassword: false,
          errorMessage: failure.userMessage,
          infoMessage: '',
        ),
      ),
      (message) => safeEmit(
        state.copyWith(
          stepNumber: _successStep,
          isResettingPassword: false,
          errorMessage: '',
          infoMessage: message,
        ),
      ),
    );
  }

  void backStep() {
    if (state.isSendingOtp ||
        state.isResendingOtp ||
        state.isResettingPassword) {
      return;
    }
    if (state.stepNumber <= _emailStep) return;

    final previousStep = state.stepNumber - 1;
    safeEmit(
      state.copyWith(
        stepNumber: previousStep,
        errorMessage: '',
        infoMessage: '',
      ),
    );
  }

  void clearMessages() {
    if (state.errorMessage.isEmpty && state.infoMessage.isEmpty) return;

    safeEmit(state.copyWith(errorMessage: '', infoMessage: ''));
  }

  void restartFlow() {
    safeEmit(
      state.copyWith(
        stepNumber: _emailStep,
        isSendingOtp: false,
        isResendingOtp: false,
        isResettingPassword: false,
        errorMessage: '',
        infoMessage: '',
      ),
    );
  }
}
