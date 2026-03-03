import 'package:hajj_app/core/cubits/safe_cubit.dart';
import 'package:hajj_app/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:hajj_app/features/auth/presentation/cubits/me/me_state.dart';

class MeCubit extends SafeCubit<MeState> {
  final GetMeUseCase _getMeUseCase;

  MeCubit(this._getMeUseCase) : super(const MeState.initial());

  Future<void> loadMe({bool forceRefresh = false}) async {
    if (state.status == MeStatus.loading) return;
    if (!forceRefresh &&
        state.status == MeStatus.loaded &&
        state.profile != null) {
      return;
    }

    safeEmit(state.copyWith(status: MeStatus.loading, errorMessage: ''));

    final result = await _getMeUseCase();
    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          status: MeStatus.error,
          errorMessage: failure.userMessage,
        ),
      ),
      (profile) => safeEmit(
        state.copyWith(
          status: MeStatus.loaded,
          profile: profile,
          errorMessage: '',
        ),
      ),
    );
  }

  void clearState() {
    safeEmit(
      state.copyWith(
        status: MeStatus.initial,
        errorMessage: '',
        clearProfile: true,
      ),
    );
  }
}
