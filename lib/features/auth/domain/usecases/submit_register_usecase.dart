import 'package:dartz/dartz.dart';

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/auth/domain/entities/register_draft.dart';
import 'package:hajj_app/features/auth/domain/repositories/auth_repository.dart';

class SubmitRegisterUseCase {
  final AuthRepository _repository;

  SubmitRegisterUseCase(this._repository);

  Future<Either<Failure, String>> call(RegisterDraft draft) {
    return _repository.register(draft);
  }
}
