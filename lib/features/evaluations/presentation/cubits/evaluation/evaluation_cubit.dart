import 'package:bawabatelhajj/core/cubits/safe_cubit.dart';
import 'package:bawabatelhajj/features/evaluations/domain/usecases/get_unanswered_questions_usecase.dart';
import 'package:bawabatelhajj/features/evaluations/domain/usecases/submit_phase_usecase.dart';

import 'evaluation_state.dart';

class EvaluationCubit extends SafeCubit<EvaluationState> {
  EvaluationCubit(
    this._getUnansweredQuestionsUseCase,
    this._submitPhaseUseCase,
  ) : super(const EvaluationState.initial());

  final GetUnansweredQuestionsUseCase _getUnansweredQuestionsUseCase;
  final SubmitPhaseUseCase _submitPhaseUseCase;

  Future<void> loadQuestions(int phaseId) async {
    safeEmit(state.copyWith(status: EvaluationStatus.loading));

    final result = await _getUnansweredQuestionsUseCase(phaseId);

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          status: EvaluationStatus.error,
          errorMessage: failure.userMessage,
        ),
      ),
      (questions) => safeEmit(
        state.copyWith(
          status: EvaluationStatus.loaded,
          questions: questions,
        ),
      ),
    );
  }

  Future<void> submitPhase({
    required int phaseId,
    required List<({int questionId, int answerId})> answers,
  }) async {
    if (state.submitStatus == SubmitStatus.submitting) return;

    safeEmit(state.copyWith(
      submitStatus: SubmitStatus.submitting,
      submitErrorMessage: '',
    ));

    final result = await _submitPhaseUseCase(
      phaseId: phaseId,
      answers: answers,
    );

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          submitStatus: SubmitStatus.error,
          submitErrorMessage: failure.userMessage,
        ),
      ),
      (submitResult) => safeEmit(
        state.copyWith(
          submitStatus: SubmitStatus.success,
          submitResult: submitResult,
        ),
      ),
    );
  }
}
