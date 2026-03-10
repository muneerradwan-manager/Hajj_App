import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';

import '../../../domain/usecases/get_complaint_kinds_usecase.dart';
import 'complaints_kinds_state.dart';

class ComplaintsKindsCubit extends SafeCubit<ComplaintsKindsState> {
  ComplaintsKindsCubit(this._getComplaintsKindsUseCase)
    : super(const ComplaintsKindsState.initial());

  final GetComplaintKindsUseCase _getComplaintsKindsUseCase;

  Future<void> loadComplaintsKinds() async {
    safeEmit(state.copyWith(status: ComplaintKindStatus.loading));

    final result = await _getComplaintsKindsUseCase();

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          status: ComplaintKindStatus.error,
          errorMessage: failure.userMessage,
        ),
      ),
      (complaints) => safeEmit(
        state.copyWith(
          status: ComplaintKindStatus.loaded,
          complaints: complaints,
        ),
      ),
    );
  }
}
