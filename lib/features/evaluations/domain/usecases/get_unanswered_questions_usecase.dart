import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/evaluation_question.dart';
import '../repositories/evaluations_repository.dart';

class GetUnansweredQuestionsUseCase {
  const GetUnansweredQuestionsUseCase(this._repository);

  final EvaluationsRepository _repository;

  Future<Either<Failure, List<EvaluationQuestion>>> call(int phaseId) =>
      _repository.getUnansweredQuestions(phaseId);
}
