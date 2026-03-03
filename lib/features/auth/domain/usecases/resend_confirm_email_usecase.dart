import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';

class ResendConfirmEmailUseCase {
  final AuthRepository _repository;

  ResendConfirmEmailUseCase(this._repository);

  Future<Either<Failure, String>> call({required String email}) {
    return _repository.resendConfirmEmail(email: email);
  }
}
