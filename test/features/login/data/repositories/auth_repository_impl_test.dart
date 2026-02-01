import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:how_weather/core/exceptions/app_exceptions.dart';
import 'package:how_weather/features/login/data/datasources/auth_remote_datasource.dart';
import 'package:how_weather/features/login/data/mappers/user_mapper.dart';
import 'package:how_weather/features/login/data/models/user_model.dart';
import 'package:how_weather/features/login/data/repositories/auth_repository_impl.dart';
import 'package:how_weather/features/login/domain/entities/user_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockUserMapper extends Mock implements UserMapper {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockDataSource;
  late MockUserMapper mockMapper;

  setUpAll(() {
    registerFallbackValue(
      const UserModel(id: '', email: '', name: '', token: ''),
    );
  });

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    mockMapper = MockUserMapper();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockDataSource,
      mapper: mockMapper,
    );
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUserModel = UserModel(
    id: '1',
    email: tEmail,
    name: 'Test User',
    token: 'test_token',
  );
  const tUserEntity = UserEntity(
    id: '1',
    email: tEmail,
    name: 'Test User',
    token: 'test_token',
  );

  group('AuthRepositoryImpl', () {
    group('login', () {
      test('should return UserEntity when remote call is successful', () async {
        when(
          () => mockDataSource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tUserModel);
        when(() => mockMapper.toEntity(any())).thenReturn(tUserEntity);

        final result = await repository.login(
          email: tEmail,
          password: tPassword,
        );

        expect(result, const Right(tUserEntity));
        verify(
          () => mockDataSource.login(email: tEmail, password: tPassword),
        ).called(1);
        verify(() => mockMapper.toEntity(tUserModel)).called(1);
      });

      test('should return ValidationException when validation fails', () async {
        const tException = ValidationException('Email is invalid');
        when(
          () => mockDataSource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tException);

        final result = await repository.login(
          email: 'invalid_email',
          password: tPassword,
        );

        expect(result, const Left(tException));
        verify(
          () =>
              mockDataSource.login(email: 'invalid_email', password: tPassword),
        ).called(1);
        verifyNever(() => mockMapper.toEntity(any()));
      });

      test(
        'should return UnauthorizedException when credentials are wrong',
        () async {
          const tException = UnauthorizedException('Invalid credentials');
          when(
            () =>
                mockDataSource.login(email: tEmail, password: 'wrong_password'),
          ).thenThrow(tException);

          final result = await repository.login(
            email: tEmail,
            password: 'wrong_password',
          );

          expect(result, const Left(tException));
          verify(
            () =>
                mockDataSource.login(email: tEmail, password: 'wrong_password'),
          ).called(1);
        },
      );

      test(
        'should return NetworkException when network error occurs',
        () async {
          const tException = NetworkException('No internet connection');
          when(
            () => mockDataSource.login(email: tEmail, password: tPassword),
          ).thenThrow(tException);

          final result = await repository.login(
            email: tEmail,
            password: tPassword,
          );

          expect(result, const Left(tException));
        },
      );

      test('should return ServerException when server error occurs', () async {
        const tException = ServerException('Internal server error');
        when(
          () => mockDataSource.login(email: tEmail, password: tPassword),
        ).thenThrow(tException);

        final result = await repository.login(
          email: tEmail,
          password: tPassword,
        );

        expect(result, const Left(tException));
      });

      test('should return UnknownException for unexpected errors', () async {
        when(
          () => mockDataSource.login(email: tEmail, password: tPassword),
        ).thenThrow(Exception('Unexpected error'));

        final result = await repository.login(
          email: tEmail,
          password: tPassword,
        );

        expect(result.isLeft(), true);
        result.fold((exception) {
          expect(exception, isA<UnknownException>());
          expect(exception.message, contains('Unexpected error'));
        }, (user) => fail('Should return exception'));
      });
    });
  });
}
