abstract class Failure {
  final String message;
  const Failure(this.message);

  /// Get user-friendly error message
  String get userMessage => message;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

/// Validation failure with field-specific errors
class ValidationFailure extends Failure {
  final Map<String, List<String>> fieldErrors;

  const ValidationFailure(
    super.message, {
    required this.fieldErrors,
  });

  /// Get all validation errors as a formatted string
  String get formattedErrors {
    final buffer = StringBuffer();
    fieldErrors.forEach((field, errors) {
      for (final error in errors) {
        buffer.writeln('• $error');
      }
    });
    return buffer.toString().trim();
  }

  /// Get errors for a specific field
  List<String>? getFieldErrors(String field) {
    return fieldErrors[field];
  }

  /// Get first error for a specific field
  String? getFirstFieldError(String field) {
    final errors = fieldErrors[field];
    return errors != null && errors.isNotEmpty ? errors.first : null;
  }

  /// Check if a specific field has errors
  bool hasFieldError(String field) {
    return fieldErrors.containsKey(field) && fieldErrors[field]!.isNotEmpty;
  }

  /// Get total number of errors
  int get errorCount {
    return fieldErrors.values.fold(0, (sum, errors) => sum + errors.length);
  }

  @override
  String get userMessage {
    // Return formatted errors instead of generic message
    return formattedErrors.isNotEmpty ? formattedErrors : message;
  }
}
