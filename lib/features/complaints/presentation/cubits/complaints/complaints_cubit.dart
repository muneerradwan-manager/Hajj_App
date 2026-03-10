import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';
import 'package:bawabatelhajj/features/complaints/domain/usecases/get_complaints_usecase.dart';

import 'complaints_state.dart';

class ComplaintsCubit extends SafeCubit<ComplaintsState> {
  ComplaintsCubit(this._getComplaintsUseCase)
    : super(const ComplaintsState.initial());

  final GetComplaintsUseCase _getComplaintsUseCase;

  Future<void> loadComplaints() async {
    safeEmit(state.copyWith(status: ComplaintsStatus.loading));

    final result = await _getComplaintsUseCase();

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          status: ComplaintsStatus.error,
          errorMessage: failure.userMessage,
        ),
      ),
      (complaints) => safeEmit(
        state.copyWith(status: ComplaintsStatus.loaded, complaints: complaints),
      ),
    );
  }
}
