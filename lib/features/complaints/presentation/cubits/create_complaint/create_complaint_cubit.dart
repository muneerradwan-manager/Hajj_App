import 'dart:io';

import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';
import 'package:bawabatelhajj/features/complaints/domain/usecases/create_complaint_usecase.dart';

import 'create_complaint_state.dart';

class CreateComplaintCubit extends SafeCubit<CreateComplaintState> {
  CreateComplaintCubit(this._createComplaintUseCase)
      : super(const CreateComplaintState.initial());

  final CreateComplaintUseCase _createComplaintUseCase;

  void updateCategory(int? id) {
    safeEmit(state.copyWith(categoryId: id));
  }

  void updateKind(int? id) {
    safeEmit(state.copyWith(kindId: id));
  }

  void updateTitle(String title) {
    safeEmit(state.copyWith(title: title));
  }

  void updateDetails(String details) {
    safeEmit(state.copyWith(details: details));
  }

  void updateAttachments(List<File> files) {
    safeEmit(state.copyWith(attachments: files));
  }

  Future<void> submit() async {
    if (!state.isFormValid || state.isSubmitting) return;

    safeEmit(state.copyWith(status: CreateComplaintStatus.submitting));

    final result = await _createComplaintUseCase(
      categoryId: state.categoryId!,
      kindId: state.kindId!,
      subject: state.title.trim(),
      message: state.details.trim(),
      attachments: state.attachments,
    );

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          status: CreateComplaintStatus.error,
          errorMessage: failure.userMessage,
        ),
      ),
      (message) => safeEmit(
        state.copyWith(
          status: CreateComplaintStatus.success,
          successMessage: message,
        ),
      ),
    );
  }

  void reset() {
    safeEmit(const CreateComplaintState.initial());
  }
}
