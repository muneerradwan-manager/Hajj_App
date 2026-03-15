import 'package:equatable/equatable.dart';

import 'package:bawabatelhajj/features/evaluations/domain/entities/evaluation_question.dart';
import 'package:bawabatelhajj/features/evaluations/domain/entities/submit_phase_result.dart';

enum EvaluationStatus { initial, loading, loaded, error }

enum SubmitStatus { initial, submitting, success, error }

class EvaluationState extends Equatable {
  final EvaluationStatus status;
  final List<EvaluationQuestion> questions;
  final String errorMessage;
  final SubmitStatus submitStatus;
  final SubmitPhaseResult? submitResult;
  final String submitErrorMessage;

  const EvaluationState({
    required this.status,
    required this.questions,
    required this.errorMessage,
    required this.submitStatus,
    required this.submitResult,
    required this.submitErrorMessage,
  });

  const EvaluationState.initial()
    : status = EvaluationStatus.initial,
      questions = const [],
      errorMessage = '',
      submitStatus = SubmitStatus.initial,
      submitResult = null,
      submitErrorMessage = '';

  EvaluationState copyWith({
    EvaluationStatus? status,
    List<EvaluationQuestion>? questions,
    String? errorMessage,
    SubmitStatus? submitStatus,
    SubmitPhaseResult? submitResult,
    String? submitErrorMessage,
    bool clearSubmitResult = false,
  }) {
    return EvaluationState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      errorMessage: errorMessage ?? this.errorMessage,
      submitStatus: submitStatus ?? this.submitStatus,
      submitResult: clearSubmitResult ? null : (submitResult ?? this.submitResult),
      submitErrorMessage: submitErrorMessage ?? this.submitErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    questions,
    errorMessage,
    submitStatus,
    submitResult,
    submitErrorMessage,
  ];
}
