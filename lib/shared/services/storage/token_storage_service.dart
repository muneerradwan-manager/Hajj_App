import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageService {
  final FlutterSecureStorage _secureStorage;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  TokenStorageService(this._secureStorage);

  /// Check if we should use SharedPreferences as fallback
  /// Use it for web (always) and Windows in debug mode due to flutter_secure_storage issues
  bool get _useSharedPreferences =>
      kIsWeb || (kDebugMode && Platform.isWindows);

  Future<void> saveAccessToken(String token) async {
    if (_useSharedPreferences) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_accessTokenKey, token);
    } else {
      await _secureStorage.write(key: _accessTokenKey, value: token);
    }
  }

  Future<void> saveRefreshToken(String token) async {
    if (_useSharedPreferences) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_refreshTokenKey, token);
    } else {
      await _secureStorage.write(key: _refreshTokenKey, value: token);
    }
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
    ]);
  }

  Future<String?> getAccessToken() async {
    if (_useSharedPreferences) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_accessTokenKey);
    } else {
      return await _secureStorage.read(key: _accessTokenKey);
    }
  }

  Future<String?> getRefreshToken() async {
    if (_useSharedPreferences) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_refreshTokenKey);
    } else {
      return await _secureStorage.read(key: _refreshTokenKey);
    }
  }

  Future<void> deleteTokens() async {
    if (_useSharedPreferences) {
      final prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.remove(_accessTokenKey),
        prefs.remove(_refreshTokenKey),
      ]);
    } else {
      await Future.wait([
        _secureStorage.delete(key: _accessTokenKey),
        _secureStorage.delete(key: _refreshTokenKey),
      ]);
    }
  }

  Future<bool> hasValidTokens() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    return accessToken != null && refreshToken != null;
  }
}
