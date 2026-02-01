class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, [this.code]);

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

class NetworkException extends AppException {
  NetworkException([String message = 'Network error occurred', String? code])
    : super(message, code);
}

class ServerException extends AppException {
  ServerException([String message = 'Server error occurred', String? code])
    : super(message, code);
}

class CacheException extends AppException {
  CacheException([String message = 'Cache error occurred', String? code])
    : super(message, code);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Unauthorized access', String? code])
    : super(message, code);
}

class NotFoundException extends AppException {
  NotFoundException([String message = 'Resource not found', String? code])
    : super(message, code);
}

class ValidationException extends AppException {
  ValidationException([String message = 'Validation failed', String? code])
    : super(message, code);
}

class TimeoutException extends AppException {
  TimeoutException([String message = 'Request timeout', String? code])
    : super(message, code);
}
