import 'package:bawabatelhajj/features/auth/domain/entities/user_profile.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';

class GetCachedMeUseCase {
  final AuthRepository _repository;

  GetCachedMeUseCase(this._repository);

  Future<UserProfile?> call() {
    return _repository.getCachedMe();
  }
}
