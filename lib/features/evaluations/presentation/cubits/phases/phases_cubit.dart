import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';
import 'package:bawabatelhajj/features/evaluations/domain/usecases/get_phases_usecase.dart';

import 'phases_state.dart';

class PhasesCubit extends SafeCubit<PhasesState> {
  PhasesCubit(this._getPhasesUseCase) : super(const PhasesState.initial());

  final GetPhasesUseCase _getPhasesUseCase;

  Future<void> loadPhases() async {
    safeEmit(state.copyWith(status: PhasesStatus.loading));

    final result = await _getPhasesUseCase();

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          status: PhasesStatus.error,
          errorMessage: failure.userMessage,
        ),
      ),
      (phases) =>
          safeEmit(state.copyWith(status: PhasesStatus.loaded, phases: phases)),
    );
  }
}
