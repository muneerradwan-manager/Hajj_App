import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';

class ClearRegisterDraftUseCase {
  final AuthRepository _repository;

  ClearRegisterDraftUseCase(this._repository);

  Future<Either<Failure, void>> call() {
    return _repository.clearRegisterDraft();
  }
}
