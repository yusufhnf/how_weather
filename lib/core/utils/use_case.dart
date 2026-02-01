import 'package:dartz/dartz.dart';

import '../exceptions/app_exceptions.dart';

abstract class UseCase<T, Params> {
  Future<Either<AppException, T>> call(Params params);
}

class NoParams {}
