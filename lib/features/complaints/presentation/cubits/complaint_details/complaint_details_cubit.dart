import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';
import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/complaints/domain/usecases/delete_complaint_usecase.dart';
import 'package:bawabatelhajj/features/complaints/domain/usecases/get_cached_complaint_details_usecase.dart';
import 'package:bawabatelhajj/features/complaints/domain/usecases/get_complaint_details_usecase.dart';
import 'package:dartz/dartz.dart';

import 'complaint_details_state.dart';

class ComplaintDetailsCubit extends SafeCubit<ComplaintDetailsState> {
  ComplaintDetailsCubit(
    this._getComplaintDetailsUseCase,
    this._getCachedComplaintDetailsUseCase,
    this._deleteComplaintUseCase,
  ) : super(const ComplaintDetailsState.initial());

  final GetComplaintDetailsUseCase _getComplaintDetailsUseCase;
  final GetCachedComplaintDetailsUseCase _getCachedComplaintDetailsUseCase;
  final DeleteComplaintUseCase _deleteComplaintUseCase;

  Future<void> loadComplaint(int id) async {
    final cached = await _getCachedComplaintDetailsUseCase(id);
    if (cached != null) {
      safeEmit(state.copyWith(
        status: ComplaintDetailsStatus.loaded,
        complaint: cached,
        isRefreshing: true,
      ));
    } else {
      safeEmit(state.copyWith(
        status: ComplaintDetailsStatus.loading,
        isRefreshing: false,
      ));
    }

    final result = await _getComplaintDetailsUseCase(id);

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          status: state.complaint != null
              ? ComplaintDetailsStatus.loaded
              : ComplaintDetailsStatus.error,
          errorMessage: failure.userMessage,
          isRefreshing: false,
        ),
      ),
      (complaint) => safeEmit(
        state.copyWith(
          status: ComplaintDetailsStatus.loaded,
          complaint: complaint,
          errorMessage: '',
          isRefreshing: false,
        ),
      ),
    );
  }

  Future<Either<Failure, void>> deleteComplaint(int id) async {
    safeEmit(state.copyWith(isDeleting: true));
    final result = await _deleteComplaintUseCase(id);
    safeEmit(state.copyWith(isDeleting: false));
    return result;
  }
}
