import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/evaluation_question.dart';
import '../entities/phase.dart';
import '../entities/submit_phase_result.dart';

abstract class EvaluationsRepository {
  Future<Either<Failure, List<Phase>>> getPhases();

  Future<Either<Failure, List<EvaluationQuestion>>> getUnansweredQuestions(
    int phaseId,
  );

  Future<Either<Failure, SubmitPhaseResult>> submitPhase({
    required int phaseId,
    required List<({int questionId, int answerId})> answers,
  });
}
