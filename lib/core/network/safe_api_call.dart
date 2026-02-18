import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../errors/failures.dart';
import 'api_error_handler.dart';

/// Helper to parse response body - handles both Map and String (when server returns text/html)
Map<String, dynamic>? _parseResponseBody(dynamic body) {
  if (body is Map<String, dynamic>) {
    return body;
  }
  if (body is String) {
    try {
      final parsed = jsonDecode(body.trim());
      if (parsed is Map<String, dynamic>) {
        return parsed;
      }
    } catch (_) {}
  }
  return null;
}

Future<Either<Failure, T>> safeApiCall<T>({
  required Future<Response> Function() apiCall,
  required T Function(Map<String, dynamic> json) mapper,
}) async {
  try {
    final response = await apiCall();
    final body = _parseResponseBody(response.data);

    if (body == null) {
      return left(const ServerFailure('Invalid response format'));
    }

    if (body['status']?.toString().toLowerCase() != 'success') {
      return left(ServerFailure(body['message'] ?? 'Unknown error'));
    }

    return right(mapper(body));
  } on Exception catch (error) {
    return left(ApiErrorHandler.handle(error));
  }
}

/// Safe API call without status check - used for APIs that return data directly
/// without a 'status' wrapper field (like the search API)
Future<Either<Failure, T>> safeApiCallRaw<T>({
  required Future<Response> Function() apiCall,
  required T Function(Map<String, dynamic> json) mapper,
}) async {
  try {
    final response = await apiCall();
    final body = _parseResponseBody(response.data);

    if (body == null) {
      return left(const ServerFailure('Invalid response format'));
    }

    // Check for error responses
    if (body.containsKey('error') || body.containsKey('errors')) {
      final message = body['error'] ?? body['message'] ?? 'Unknown error';
      return left(ServerFailure(message.toString()));
    }

    return right(mapper(body));
  } on Exception catch (error) {
    return left(ApiErrorHandler.handle(error));
  }
}

