import 'package:dio/dio.dart';
import '../errors/failures.dart';

class ApiErrorHandler {
  static Failure handle(Object error) {
    if (error is DioException) {
      return _handleDioError(error);
    }

    return const UnknownFailure('Unexpected error occurred');
  }

  static Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.cancel:
        return const NetworkFailure('Request cancelled');

      case DioExceptionType.badCertificate:
        return const NetworkFailure('Bad certificate');

      case DioExceptionType.connectionError:
        return const NetworkFailure('Connection error');

      case DioExceptionType.unknown:
        return const NetworkFailure('No internet connection');
    }
  }

  static Failure _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    // Handle 401 Unauthorized
    if (statusCode == 401) {
      final message = _extractMessage(data) ?? 'Unauthorized';
      return UnauthorizedFailure(message);
    }

    // Handle validation errors (422 or errors field present)
    if (data is Map && data['errors'] != null) {
      return _parseValidationErrors(Map<String, dynamic>.from(data));
    }

    // Handle generic server error with message
    if (data is Map && data['message'] != null) {
      return ServerFailure(data['message']);
    }

    // Default server error
    return ServerFailure('Server error ($statusCode)');
  }

  /// Parse validation errors from API response
  static ValidationFailure _parseValidationErrors(Map<String, dynamic> data) {
    final message = _extractMessage(data) ?? 'Validation failed';
    final errors = data['errors'];

    final Map<String, List<String>> fieldErrors = {};

    if (errors is Map) {
      errors.forEach((key, value) {
        if (value is List) {
          fieldErrors[key] = value.map((e) => e.toString()).toList();
        } else if (value is String) {
          fieldErrors[key] = [value];
        }
      });
    }

    return ValidationFailure(message, fieldErrors: fieldErrors);
  }

  /// Extract message from response data
  static String? _extractMessage(dynamic data) {
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    return null;
  }
}
