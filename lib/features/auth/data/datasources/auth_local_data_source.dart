import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:bawabatelhajj/shared/services/storage/token_storage_service.dart';
import 'package:bawabatelhajj/features/auth/data/models/user_profile_model.dart';

class AuthLocalDataSource {
  final TokenStorageService _tokenStorage;
  static const String _meCacheKey = 'auth_me_cache';

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
    await Future.wait([_tokenStorage.deleteTokens(), clearCachedProfile()]);
  }

  Future<String?> getRefreshToken() {
    return _tokenStorage.getRefreshToken();
  }

  Future<bool> hasTokens() {
    return _tokenStorage.hasValidTokens();
  }

  Future<void> saveCachedProfile(UserProfileModel model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_meCacheKey, jsonEncode(model.toJson()));
  }

  Future<UserProfileModel?> getCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_meCacheKey);
    if (raw == null || raw.trim().isEmpty) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      final map = decoded.map((key, value) => MapEntry(key.toString(), value));
      return UserProfileModel.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  Future<void> clearCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_meCacheKey);
  }
}
