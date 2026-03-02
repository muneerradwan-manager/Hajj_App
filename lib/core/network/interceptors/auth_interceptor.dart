import 'package:dio/dio.dart';
import '../../../shared/services/storage/token_storage_service.dart';
import '../../constants/app_urls.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorageService _tokenStorage;
  final Dio _dio;

  AuthInterceptor(this._tokenStorage, this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final publicEndpoints = [
      AppUrls.login,
      AppUrls.register,
      AppUrls.verifyOtp,
      AppUrls.resendOtp,
      AppUrls.refresh,
      AppUrls.sendResetLink,
      AppUrls.resetPassword,
    ];

    final isPublicEndpoint = publicEndpoints.any(
      (endpoint) => options.path.contains(endpoint),
    );

    if (!isPublicEndpoint) {
      final accessToken = await _tokenStorage.getAccessToken();
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestPath = err.requestOptions.path;
    final isRefreshRequest = requestPath.contains(AppUrls.refresh);
    final isLogoutRequest = requestPath.contains(AppUrls.logout);
    final isPublicRequest =
        requestPath.contains(AppUrls.login) ||
        requestPath.contains(AppUrls.register) ||
        requestPath.contains(AppUrls.verifyOtp) ||
        requestPath.contains(AppUrls.resendOtp) ||
        requestPath.contains(AppUrls.sendResetLink) ||
        requestPath.contains(AppUrls.resetPassword);
    final isRetryAttempt = err.requestOptions.extra['is_retry'] == true;

    if (err.response?.statusCode != 401 ||
        isRefreshRequest ||
        isLogoutRequest ||
        isPublicRequest ||
        isRetryAttempt) {
      if (isLogoutRequest) {
        await _tokenStorage.deleteTokens();
        // Token already expired/invalid — server can't use it anyway.
        // Resolve as success so the UI treats logout as completed.
        return handler.resolve(
          Response(
            requestOptions: err.requestOptions,
            statusCode: 200,
            data: {'message': 'Logged out (token was already invalid)'},
          ),
        );
      }
      return handler.next(err);
    }

    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.trim().isEmpty) {
      await _tokenStorage.deleteTokens();
      return handler.next(err);
    }

    try {
      final refreshResponse = await _dio.post<dynamic>(
        AppUrls.refresh,
        data: {'refreshToken': refreshToken.trim()},
        options: Options(
          headers: {'Authorization': null},
          validateStatus: (_) => true,
          extra: {'is_retry': true},
        ),
      );

      final data = refreshResponse.data;
      final map = data is Map
          ? data.map((key, value) => MapEntry(key.toString(), value))
          : <String, dynamic>{};

      final newAccessToken = (map['token'] ?? '').toString().trim();
      final newRefreshToken = (map['refreshToken'] ?? '').toString().trim();

      if (newAccessToken.isEmpty || newRefreshToken.isEmpty) {
        await _tokenStorage.deleteTokens();
        return handler.next(err);
      }

      await _tokenStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      final requestOptions = err.requestOptions;
      requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      requestOptions.extra['is_retry'] = true;

      final retryResponse = await _dio.fetch(requestOptions);
      return handler.resolve(retryResponse);
    } catch (_) {
      await _tokenStorage.deleteTokens();
      return handler.next(err);
    }
  }
}
