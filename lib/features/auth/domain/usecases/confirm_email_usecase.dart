import 'package:dartz/dartz.dart';

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/auth/domain/repositories/auth_repository.dart';

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
