import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/auth/domain/entities/register_draft.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';

class LoadRegisterDraftUseCase {
  final AuthRepository _repository;

  LoadRegisterDraftUseCase(this._repository);

  Future<Either<Failure, RegisterDraft?>> call() {
    return _repository.loadRegisterDraft();
  }
}
