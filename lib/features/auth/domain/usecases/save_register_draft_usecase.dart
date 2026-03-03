import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/auth/domain/entities/register_draft.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';

class SaveRegisterDraftUseCase {
  final AuthRepository _repository;

  SaveRegisterDraftUseCase(this._repository);

  Future<Either<Failure, void>> call(RegisterDraft draft) {
    return _repository.saveRegisterDraft(draft);
  }
}
