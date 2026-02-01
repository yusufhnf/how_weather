import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../mappers/user_mapper.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final UserMapper _mapper;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required UserMapper mapper,
  }) : _remoteDataSource = remoteDataSource,
       _mapper = mapper;

  @override
  Future<Either<AppException, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(_mapper.toEntity(result));
    } on ValidationException catch (e) {
      return Left(e);
    } on UnauthorizedException catch (e) {
      return Left(e);
    } on NetworkException catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownException(e.toString()));
    }
  }
}
