import 'package:dartz/dartz.dart';

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/auth/domain/entities/register_draft.dart';
import 'package:hajj_app/features/auth/domain/repositories/auth_repository.dart';

class SaveRegisterDraftUseCase {
  final AuthRepository _repository;

  SaveRegisterDraftUseCase(this._repository);

  Future<Either<Failure, void>> call(RegisterDraft draft) {
    return _repository.saveRegisterDraft(draft);
  }
}
