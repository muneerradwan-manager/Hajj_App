import 'package:dartz/dartz.dart';

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/auth/domain/repositories/auth_repository.dart';

class ResendConfirmEmailUseCase {
  final AuthRepository _repository;

  ResendConfirmEmailUseCase(this._repository);

  Future<Either<Failure, String>> call({required String email}) {
    return _repository.resendConfirmEmail(email: email);
  }
}
