import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';

import '../../../domain/usecases/get_complaint_categories_usecase.dart';
import 'complaints_categories_state.dart';

class ComplaintsCategoriesCubit extends SafeCubit<ComplaintsCategoriesState> {
  ComplaintsCategoriesCubit(this._getComplaintsCategoriesUseCase)
    : super(const ComplaintsCategoriesState.initial());

  final GetComplaintCategoriesUseCase _getComplaintsCategoriesUseCase;

  Future<void> loadComplaintsCategories() async {
    safeEmit(state.copyWith(status: ComplaintCategoryStatus.loading));

    final result = await _getComplaintsCategoriesUseCase();

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          status: ComplaintCategoryStatus.error,
          errorMessage: failure.userMessage,
        ),
      ),
      (complaints) => safeEmit(
        state.copyWith(
          status: ComplaintCategoryStatus.loaded,
          complaints: complaints,
        ),
      ),
    );
  }
}
