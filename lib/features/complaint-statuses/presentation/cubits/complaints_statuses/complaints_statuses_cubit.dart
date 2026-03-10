import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';

import '../../../domain/usecases/get_complaint_statuses_usecase.dart';
import 'complaints_statuses_state.dart';

class ComplaintStatusesCubit extends SafeCubit<ComplaintStatusesState> {
  ComplaintStatusesCubit(this._getComplaintStatusUseCase)
    : super(const ComplaintStatusesState.initial());

  final GetComplaintStatusesUseCase _getComplaintStatusUseCase;

  Future<void> loadComplaints() async {
    safeEmit(state.copyWith(status: ComplaintStatusesStatus.loading));

    final result = await _getComplaintStatusUseCase();

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          status: ComplaintStatusesStatus.error,
          errorMessage: failure.userMessage,
        ),
      ),
      (complaints) => safeEmit(
        state.copyWith(
          status: ComplaintStatusesStatus.loaded,
          complaints: complaints,
        ),
      ),
    );
  }
}
