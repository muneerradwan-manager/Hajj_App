import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/submit_phase_result.dart';
import '../repositories/evaluations_repository.dart';

class SubmitPhaseUseCase {
  const SubmitPhaseUseCase(this._repository);

  final EvaluationsRepository _repository;

  Future<Either<Failure, SubmitPhaseResult>> call({
    required int phaseId,
    required List<({int questionId, int answerId})> answers,
  }) =>
      _repository.submitPhase(phaseId: phaseId, answers: answers);
}
