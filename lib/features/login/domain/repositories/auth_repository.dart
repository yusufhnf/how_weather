import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<AppException, UserEntity>> login({
    required String email,
    required String password,
  });
}
