import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/phase.dart';
import '../repositories/evaluations_repository.dart';

class GetPhasesUseCase {
  const GetPhasesUseCase(this._repository);

  final EvaluationsRepository _repository;

  Future<Either<Failure, List<Phase>>> call() => _repository.getPhases();
}
