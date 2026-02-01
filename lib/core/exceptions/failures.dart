import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure(this.message, [this.code]);

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure([
    String message = 'Server failure occurred',
    String? code,
  ]) : super(message, code);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    String message = 'Network failure occurred',
    String? code,
  ]) : super(message, code);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache failure occurred', String? code])
    : super(message, code);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    String message = 'Unauthorized access',
    String? code,
  ]) : super(message, code);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Resource not found', String? code])
    : super(message, code);
}

class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Validation failed', String? code])
    : super(message, code);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([String message = 'Request timeout', String? code])
    : super(message, code);
}

class UnknownFailure extends Failure {
  const UnknownFailure([
    String message = 'Unknown error occurred',
    String? code,
  ]) : super(message, code);
}
