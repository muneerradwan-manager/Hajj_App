import 'package:dartz/dartz.dart';

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/auth/domain/entities/register_draft.dart';
import 'package:hajj_app/features/auth/domain/repositories/auth_repository.dart';

class LoadRegisterDraftUseCase {
  final AuthRepository _repository;

  LoadRegisterDraftUseCase(this._repository);

  Future<Either<Failure, RegisterDraft?>> call() {
    return _repository.loadRegisterDraft();
  }
}
