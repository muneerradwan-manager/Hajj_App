import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/network/interceptors/auth_interceptor.dart';
import '../../shared/services/storage/token_storage_service.dart';

class DioClient {
  late final Dio dio;
  final TokenStorageService? _tokenStorage;

  DioClient({TokenStorageService? tokenStorage})
    : _tokenStorage = tokenStorage {
    dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? 'http://example.com/api',
        connectTimeout: Duration(
          seconds: int.parse(dotenv.env['CONNECT_TIMEOUT'] ?? '5'),
        ),
        receiveTimeout: Duration(
          seconds: int.parse(dotenv.env['RECEIVE_TIMEOUT'] ?? '3'),
        ),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        // Use multiCompatible format for Laravel: key[]=value1&key[]=value2
        listFormat: ListFormat.multiCompatible,
      ),
    );

    _addInterceptors();
  }

  void _addInterceptors() async {
    // Add auth interceptor first if token storage is available
    if (_tokenStorage != null) {
      debugPrint(await _tokenStorage.getAccessToken());
      dio.interceptors.add(AuthInterceptor(_tokenStorage, dio));
    }

    // Add log interceptor
    _addLogInterceptors();
  }

  void _addLogInterceptors() {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
        request: true,
        logPrint: (object) => _prettyPrintLog(object.toString()),
      ),
    );
  }

  void _prettyPrintLog(String message) {
    if (!kDebugMode) return;

    // Try to detect and format JSON in the message
    try {
      // Check if the message looks like JSON (starts with { or [)
      final trimmed = message.trim();
      if (trimmed.startsWith('{') || trimmed.startsWith('[')) {
        final jsonData = jsonDecode(trimmed);
        const encoder = JsonEncoder.withIndent('  ');
        final prettyJson = encoder.convert(jsonData);
        developer.log('\n$prettyJson', name: 'DIO');
      } else {
        developer.log(message, name: 'DIO');
      }
    } catch (_) {
      // If JSON parsing fails, log as-is
      developer.log(message, name: 'DIO');
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.get<T>(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(String path, {Object? data, Options? options}) {
    return dio.delete<T>(path, data: data, options: options);
  }

  Future<Response<T>> update<T>(
    String path, {
    required String method,
    Object? data,
    Options? options,
  }) {
    assert(method == 'PUT' || method == 'PATCH');

    final FormData formData;
    if (data is FormData) {
      formData = data;
      formData.fields.add(MapEntry('_method', method));
    } else if (data is Map<String, dynamic>) {
      formData = FormData.fromMap({
        ...data,
        '_method': method,
      });
    } else {
      formData = FormData.fromMap({'_method': method});
    }

    return dio.post<T>(path, data: formData, options: options);
  }
}
