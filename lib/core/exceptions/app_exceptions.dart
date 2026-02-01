import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

class NetworkException extends AppException {
  const NetworkException([
    super.message = 'Network error occurred',
    super.code,
  ]);
}

class ServerException extends AppException {
  const ServerException([super.message = 'Server error occurred', super.code]);
}

class CacheException extends AppException {
  const CacheException([super.message = 'Cache error occurred', super.code]);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Unauthorized access',
    super.code,
  ]);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Resource not found', super.code]);
}

class ValidationException extends AppException {
  const ValidationException([super.message = 'Validation failed', super.code]);
}

class TimeoutException extends AppException {
  const TimeoutException([super.message = 'Request timeout', super.code]);
}

class UnknownException extends AppException {
  const UnknownException([
    super.message = 'Unknown error occurred',
    super.code,
  ]);
}
