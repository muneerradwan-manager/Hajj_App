import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/core/network/api_error_handler.dart';
import 'package:bawabatelhajj/features/evaluations/data/datasources/evaluations_remote_data_source.dart';
import 'package:bawabatelhajj/features/evaluations/domain/entities/evaluation_question.dart';
import 'package:bawabatelhajj/features/evaluations/domain/entities/phase.dart';
import 'package:bawabatelhajj/features/evaluations/domain/entities/submit_phase_result.dart';
import 'package:bawabatelhajj/features/evaluations/domain/repositories/evaluations_repository.dart';

class EvaluationsRepositoryImpl implements EvaluationsRepository {
  const EvaluationsRepositoryImpl(this._remote);

  final EvaluationsRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<Phase>>> getPhases() async {
    try {
      final models = await _remote.getPhases();
      return right(models.map((m) => m.toEntity()).toList());
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, List<EvaluationQuestion>>> getUnansweredQuestions(
    int phaseId,
  ) async {
    try {
      final models = await _remote.getUnansweredQuestions(phaseId);
      return right(models.map((m) => m.toEntity()).toList());
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, SubmitPhaseResult>> submitPhase({
    required int phaseId,
    required List<({int questionId, int answerId})> answers,
  }) async {
    try {
      final model = await _remote.submitPhase(
        phaseId: phaseId,
        answers: answers
            .map((a) => {
                  'questionId': a.questionId,
                  'answerId': a.answerId,
                })
            .toList(),
      );
      return right(model.toEntity());
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }
}
