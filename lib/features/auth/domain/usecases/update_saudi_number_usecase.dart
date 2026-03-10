import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';

class UpdateSaudiNumberUseCase {
  const UpdateSaudiNumberUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, void>> call(String saudiNum) =>
      _repository.updateSaudiNumber(saudiNum);
}
