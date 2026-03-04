import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';
import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/get_cached_me_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_state.dart';

class MeCubit extends SafeCubit<MeState> {
  final GetMeUseCase _getMeUseCase;
  final GetCachedMeUseCase _getCachedMeUseCase;

  MeCubit(this._getMeUseCase, this._getCachedMeUseCase)
    : super(const MeState.initial());

  Future<void> loadMe({bool forceRefresh = false}) async {
    if (state.status == MeStatus.loading) return;
    if (!forceRefresh &&
        state.status == MeStatus.loaded &&
        state.profile != null) {
      return;
    }

    final cachedProfile = state.profile ?? await _getCachedMeUseCase();
    if (cachedProfile != null) {
      safeEmit(
        state.copyWith(
          status: MeStatus.loaded,
          profile: cachedProfile,
          errorMessage: '',
          isNetworkError: false,
        ),
      );
    } else {
      safeEmit(
        state.copyWith(
          status: MeStatus.loading,
          errorMessage: '',
          isNetworkError: false,
        ),
      );
    }

    final result = await _getMeUseCase();
    await result.fold<Future<void>>(
      (failure) async {
        final isNetworkFailure = failure is NetworkFailure;
        final fallbackProfile = state.profile ?? await _getCachedMeUseCase();
        final hasCachedProfile = fallbackProfile != null;

        safeEmit(
          state.copyWith(
            status: isNetworkFailure && hasCachedProfile
                ? MeStatus.loaded
                : MeStatus.error,
            profile: fallbackProfile,
            errorMessage: failure.userMessage,
            isNetworkError: isNetworkFailure,
          ),
        );
      },
      (profile) async {
        safeEmit(
          state.copyWith(
            status: MeStatus.loaded,
            profile: profile,
            errorMessage: '',
            isNetworkError: false,
          ),
        );
      },
    );
  }

  void clearState() {
    safeEmit(
      state.copyWith(
        status: MeStatus.initial,
        errorMessage: '',
        isNetworkError: false,
        clearProfile: true,
      ),
    );
  }
}
