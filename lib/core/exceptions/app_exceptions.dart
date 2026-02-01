import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  final String message;
  final String? code;

  const AppException({required this.code, required this.message});

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

class NetworkException extends AppException {
  const NetworkException([
    String message = 'Network error occurred',
    String? code,
  ]) : super(message: message, code: code);
}

class ServerException extends AppException {
  const ServerException([
    String message = 'Server error occurred',
    String? code,
  ]) : super(message: message, code: code);
}

class CacheException extends AppException {
  const CacheException([String message = 'Cache error occurred', String? code])
    : super(message: message, code: code);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([
    String message = 'Unauthorized access',
    String? code,
  ]) : super(message: message, code: code);
}

class NotFoundException extends AppException {
  const NotFoundException([String message = 'Resource not found', String? code])
    : super(message: message, code: code);
}

class ValidationException extends AppException {
  const ValidationException([
    String message = 'Validation failed',
    String? code,
  ]) : super(message: message, code: code);
}

class TimeoutException extends AppException {
  const TimeoutException([String message = 'Request timeout', String? code])
    : super(message: message, code: code);
}

class LocationException extends AppException {
  const LocationException([
    String message = 'Location error occurred',
    String? code,
  ]) : super(message: message, code: code);
}

class UnknownException extends AppException {
  const UnknownException([
    String message = 'Unknown error occurred',
    String? code,
  ]) : super(message: message, code: code);
}

class ConnectionException extends AppException {
  const ConnectionException([
    String message = 'No internet connection',
    String? code,
  ]) : super(message: message, code: code);
}
