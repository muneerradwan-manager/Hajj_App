/// Base exception class for the application
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException(super.message, [super.statusCode]);
}

/// Server-related exceptions
class ServerException extends AppException {
  const ServerException(super.message, [super.statusCode]);
}

/// Unauthorized access exception
class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, [super.statusCode]);
}

/// Validation exception
class ValidationException extends AppException {
  final Map<String, List<String>> fieldErrors;

  const ValidationException(
    super.message,
    this.fieldErrors, [
    super.statusCode,
  ]);
}

/// Cache exception
class CacheException extends AppException {
  const CacheException(super.message);
}

/// Storage exception
class StorageException extends AppException {
  const StorageException(super.message);
}
