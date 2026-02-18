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
    if (err.response?.statusCode == 401) {
      final refreshToken = await _tokenStorage.getRefreshToken();

      if (refreshToken != null) {
        try {
          final response = await _dio.post(
            AppUrls.refresh,
            data: {'refresh': refreshToken},
            options: Options(headers: {'Authorization': null}),
          );

          if (response.statusCode == 200) {
            final data = response.data;
            final newAccessToken = data['access'];
            final newRefreshToken = data['refresh'];
            await _tokenStorage.saveTokens(
              accessToken: newAccessToken,
              refreshToken: newRefreshToken,
            );
            final requestOptions = err.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
            final retryResponse = await _dio.fetch(requestOptions);
            return handler.resolve(retryResponse);
          }
        } catch (e) {
          await _tokenStorage.deleteTokens();
          return handler.next(err);
        }
      }
    }

    return handler.next(err);
  }
}
