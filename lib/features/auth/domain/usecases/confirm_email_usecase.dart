import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';

class ConfirmEmailUseCase {
  final AuthRepository _repository;

  ConfirmEmailUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required String email,
    required String otp,
  }) {
    return _repository.confirmEmail(email: email, otp: otp);
  }
}
