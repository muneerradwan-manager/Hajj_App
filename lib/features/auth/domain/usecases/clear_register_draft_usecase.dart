import 'package:dartz/dartz.dart';

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/auth/domain/repositories/auth_repository.dart';

class ClearRegisterDraftUseCase {
  final AuthRepository _repository;

  ClearRegisterDraftUseCase(this._repository);

  Future<Either<Failure, void>> call() {
    return _repository.clearRegisterDraft();
  }
}
