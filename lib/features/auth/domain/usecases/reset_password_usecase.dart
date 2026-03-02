import 'package:dartz/dartz.dart';

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) {
    return _repository.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
