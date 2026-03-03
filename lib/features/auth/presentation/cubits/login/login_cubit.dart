import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/login_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/login/login_state.dart';

class LoginCubit extends SafeCubit<LoginState> {
  LoginCubit(this._loginUseCase, this._logoutUseCase)
    : super(const LoginState.initial());

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> login({required String email, required String password}) async {
    if (state.isSubmitting) return;

    safeEmit(
      state.copyWith(
        isSubmitting: true,
        isAuthenticated: false,
        errorMessage: '',
        infoMessage: '',
      ),
    );

    final result = await _loginUseCase(
      email: email.trim(),
      password: password.trim(),
    );

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          isSubmitting: false,
          isAuthenticated: false,
          errorMessage: failure.userMessage,
          infoMessage: '',
        ),
      ),
      (_) => safeEmit(
        state.copyWith(
          isSubmitting: false,
          isAuthenticated: true,
          errorMessage: '',
          infoMessage: '',
        ),
      ),
    );
  }

  Future<void> logout() async {
    if (state.isSubmitting) return;

    safeEmit(
      state.copyWith(isSubmitting: true, errorMessage: '', infoMessage: ''),
    );

    final result = await _logoutUseCase();
    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          isSubmitting: false,
          isAuthenticated: false,
          errorMessage: failure.userMessage,
          infoMessage: '',
        ),
      ),
      (message) => safeEmit(
        state.copyWith(
          isSubmitting: false,
          isAuthenticated: false,
          errorMessage: '',
          infoMessage: message,
        ),
      ),
    );
  }

  void clearMessages() {
    if (state.errorMessage.isEmpty && state.infoMessage.isEmpty) return;
    safeEmit(state.copyWith(errorMessage: '', infoMessage: ''));
  }

  void resetAuthState() {
    if (!state.isAuthenticated) return;
    safeEmit(state.copyWith(isAuthenticated: false));
  }
}
