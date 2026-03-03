import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/auth/domain/entities/register_draft.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';

class SubmitRegisterUseCase {
  final AuthRepository _repository;

  SubmitRegisterUseCase(this._repository);

  Future<Either<Failure, String>> call(RegisterDraft draft) {
    return _repository.register(draft);
  }
}
