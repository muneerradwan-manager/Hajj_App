import 'package:dartz/dartz.dart';

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/auth/domain/entities/auth_session.dart';
import 'package:hajj_app/features/auth/domain/repositories/auth_repository.dart';

class RefreshSessionUseCase {
  final AuthRepository _repository;

  RefreshSessionUseCase(this._repository);

  Future<Either<Failure, AuthSession>> call() {
    return _repository.refreshSession();
  }
}
