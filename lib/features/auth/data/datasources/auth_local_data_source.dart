import 'package:hajj_app/shared/services/storage/token_storage_service.dart';

class AuthLocalDataSource {
  final TokenStorageService _tokenStorage;

  AuthLocalDataSource(this._tokenStorage);

  Future<void> saveTokens({
    required String token,
    required String refreshToken,
  }) async {
    await _tokenStorage.saveTokens(
      accessToken: token,
      refreshToken: refreshToken,
    );
  }

  Future<void> clearTokens() async {
    await _tokenStorage.deleteTokens();
  }

  Future<String?> getRefreshToken() {
    return _tokenStorage.getRefreshToken();
  }

  Future<bool> hasTokens() {
    return _tokenStorage.hasValidTokens();
  }
}
