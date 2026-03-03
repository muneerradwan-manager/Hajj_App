import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, String>> call() {
    return _repository.logout();
  }
}
