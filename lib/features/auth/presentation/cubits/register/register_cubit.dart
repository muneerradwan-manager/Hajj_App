import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';
import 'package:bawabatelhajj/features/auth/domain/entities/register_draft.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/clear_register_draft_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/confirm_email_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/load_register_draft_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/resend_confirm_email_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/save_register_draft_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/submit_register_usecase.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/register/register_state.dart';

class RegisterCubit extends SafeCubit<RegisterState> {
  RegisterCubit(
    this._submitRegisterUseCase,
    this._confirmEmailUseCase,
    this._resendConfirmEmailUseCase,
    this._saveRegisterDraftUseCase,
    this._loadRegisterDraftUseCase,
    this._clearRegisterDraftUseCase,
  ) : super(const RegisterState.initial());

  final SubmitRegisterUseCase _submitRegisterUseCase;
  final ConfirmEmailUseCase _confirmEmailUseCase;
  final ResendConfirmEmailUseCase _resendConfirmEmailUseCase;
  final SaveRegisterDraftUseCase _saveRegisterDraftUseCase;
  final LoadRegisterDraftUseCase _loadRegisterDraftUseCase;
  final ClearRegisterDraftUseCase _clearRegisterDraftUseCase;

  static const int _firstStep = 1;
  static const int _verifyStep = 4;
  static const int _successStep = 5;

  Future<void> initialize() async {
    final result = await _loadRegisterDraftUseCase();

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          isHydrated: true,
          errorMessage: failure.userMessage,
          infoMessage: '',
        ),
      ),
      (draft) {
        final hydratedDraft = _sanitizeDraftForCache(
          draft ?? const RegisterDraft(),
        );
        safeEmit(
          state.copyWith(
            draft: hydratedDraft,
            stepNumber: hydratedDraft.stepNumber,
            isHydrated: true,
            isSubmitting: false,
            isConfirmingEmail: false,
            isResendingCode: false,
            errorMessage: '',
            infoMessage: '',
          ),
        );
      },
    );
  }

  Future<void> saveMainInfo({
    required String email,
    required String phone,
    required String nationalityNumber,
  }) async {
    final updated = state.draft.copyWith(
      email: email.trim(),
      phone: phone.trim(),
      nationalityNumber: nationalityNumber.trim(),
      stepNumber: 2,
    );

    safeEmit(
      state.copyWith(
        draft: updated,
        stepNumber: 2,
        isConfirmingEmail: false,
        isResendingCode: false,
        errorMessage: '',
        infoMessage: '',
      ),
    );

    await _persistDraft(updated);
  }

  Future<void> saveSecurityInfo({
    required String password,
    required String confirmPassword,
    required String barcode,
  }) async {
    final updated = state.draft.copyWith(
      password: password.trim(),
      confirmPassword: confirmPassword.trim(),
      barcode: barcode.trim(),
      stepNumber: 3,
    );

    safeEmit(
      state.copyWith(
        draft: updated,
        stepNumber: 3,
        isConfirmingEmail: false,
        isResendingCode: false,
        errorMessage: '',
        infoMessage: '',
      ),
    );

    await _persistDraft(updated);
  }

  Future<void> goBackStep() async {
    if (state.stepNumber <= _firstStep) return;

    final previousStep = state.stepNumber - 1;
    final updated = state.draft.copyWith(stepNumber: previousStep);

    safeEmit(
      state.copyWith(
        draft: updated,
        stepNumber: previousStep,
        isConfirmingEmail: false,
        isResendingCode: false,
        errorMessage: '',
        infoMessage: '',
      ),
    );

    await _persistDraft(updated);
  }

  Future<void> submitRegister() async {
    if (state.isSubmitting) return;

    final requestDraft = _sanitizeDraftForCache(state.draft);
    safeEmit(
      state.copyWith(
        draft: requestDraft,
        stepNumber: 3,
        isSubmitting: true,
        isConfirmingEmail: false,
        isResendingCode: false,
        errorMessage: '',
        infoMessage: '',
      ),
    );

    final result = await _submitRegisterUseCase(requestDraft);

    await result.fold(
      (failure) async {
        safeEmit(
          state.copyWith(
            isSubmitting: false,
            isConfirmingEmail: false,
            isResendingCode: false,
            errorMessage: failure.userMessage,
            infoMessage: '',
          ),
        );
      },
      (message) async {
        final updated = requestDraft.copyWith(stepNumber: _verifyStep);
        safeEmit(
          state.copyWith(
            draft: updated,
            stepNumber: _verifyStep,
            isSubmitting: false,
            isConfirmingEmail: false,
            isResendingCode: false,
            errorMessage: '',
            infoMessage: message,
          ),
        );

        await _persistDraft(updated);
      },
    );
  }

  Future<void> confirmEmail(String otp) async {
    if (state.isConfirmingEmail) return;

    final email = state.draft.email.trim();
    final normalizedOtp = otp.trim();

    safeEmit(
      state.copyWith(
        isConfirmingEmail: true,
        isResendingCode: false,
        errorMessage: '',
        infoMessage: '',
      ),
    );

    final result = await _confirmEmailUseCase(email: email, otp: normalizedOtp);

    await result.fold(
      (failure) async {
        safeEmit(
          state.copyWith(
            isConfirmingEmail: false,
            isResendingCode: false,
            errorMessage: failure.userMessage,
            infoMessage: '',
          ),
        );
      },
      (message) async {
        final updated = state.draft.copyWith(stepNumber: _successStep);
        await _clearCacheSilently();

        safeEmit(
          state.copyWith(
            draft: updated,
            stepNumber: _successStep,
            isSubmitting: false,
            isConfirmingEmail: false,
            isResendingCode: false,
            errorMessage: '',
            infoMessage: message,
          ),
        );
      },
    );
  }

  Future<void> resendConfirmEmail() async {
    if (state.isResendingCode || state.isConfirmingEmail) return;

    final email = state.draft.email.trim();
    safeEmit(
      state.copyWith(isResendingCode: true, errorMessage: '', infoMessage: ''),
    );

    final result = await _resendConfirmEmailUseCase(email: email);

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          isResendingCode: false,
          errorMessage: failure.userMessage,
          infoMessage: '',
        ),
      ),
      (message) => safeEmit(
        state.copyWith(
          isResendingCode: false,
          errorMessage: '',
          infoMessage: message,
        ),
      ),
    );
  }

  Future<void> clearRegisterFlow() async {
    await _clearCacheSilently();

    safeEmit(
      const RegisterState.initial().copyWith(
        isHydrated: true,
        isSubmitting: false,
        isConfirmingEmail: false,
        isResendingCode: false,
      ),
    );
  }

  void clearMessages() {
    if (state.errorMessage.isEmpty && state.infoMessage.isEmpty) return;

    safeEmit(state.copyWith(errorMessage: '', infoMessage: ''));
  }

  RegisterDraft _sanitizeDraftForCache(RegisterDraft draft) {
    final clampedStep = draft.stepNumber.clamp(_firstStep, _verifyStep);

    return draft.copyWith(
      stepNumber: clampedStep,
      email: draft.email.trim(),
      phone: draft.phone.trim(),
      nationalityNumber: draft.nationalityNumber.trim(),
      barcode: draft.barcode.trim(),
      password: draft.password.trim(),
      confirmPassword: draft.confirmPassword.trim(),
    );
  }

  Future<void> _persistDraft(RegisterDraft draft) async {
    final result = await _saveRegisterDraftUseCase(
      _sanitizeDraftForCache(draft),
    );

    result.fold(
      (failure) => safeEmit(
        state.copyWith(errorMessage: failure.userMessage, infoMessage: ''),
      ),
      (_) {},
    );
  }

  Future<void> _clearCacheSilently() async {
    final result = await _clearRegisterDraftUseCase();

    result.fold(
      (failure) => safeEmit(
        state.copyWith(errorMessage: failure.userMessage, infoMessage: ''),
      ),
      (_) {},
    );
  }
}
