import 'package:dartz/dartz.dart';

import '../exceptions/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
