import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:how_weather/core/exceptions/app_exceptions.dart';
import 'package:how_weather/features/login/domain/entities/user_entity.dart';
import 'package:how_weather/features/login/domain/repositories/auth_repository.dart';
import 'package:how_weather/features/login/domain/usecases/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(repository: mockRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUser = UserEntity(
    id: '1',
    email: tEmail,
    name: 'Test User',
    token: 'test_token',
  );

  group('LoginUseCase', () {
    test('should return UserEntity when login is successful', () async {
      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(tUser));

      final result = await useCase(
        LoginParams(email: tEmail, password: tPassword),
      );

      expect(result, const Right(tUser));
      verify(
        () => mockRepository.login(email: tEmail, password: tPassword),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ValidationException when email is invalid', () async {
      const tException = ValidationException('Invalid email format');
      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left(tException));

      final result = await useCase(
        LoginParams(email: 'invalid', password: tPassword),
      );

      expect(result, const Left(tException));
      verify(
        () => mockRepository.login(email: 'invalid', password: tPassword),
      ).called(1);
    });

    test(
      'should return UnauthorizedException when credentials are wrong',
      () async {
        const tException = UnauthorizedException('Invalid credentials');
        when(
          () => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => const Left(tException));

        final result = await useCase(
          LoginParams(email: tEmail, password: 'wrong_password'),
        );

        expect(result, const Left(tException));
        verify(
          () => mockRepository.login(email: tEmail, password: 'wrong_password'),
        ).called(1);
      },
    );

    test('should return NetworkException when there is no internet', () async {
      const tException = NetworkException('No internet connection');
      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left(tException));

      final result = await useCase(
        LoginParams(email: tEmail, password: tPassword),
      );

      expect(result, const Left(tException));
    });

    test('should return ServerException when server error occurs', () async {
      const tException = ServerException('Server error');
      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left(tException));

      final result = await useCase(
        LoginParams(email: tEmail, password: tPassword),
      );

      expect(result, const Left(tException));
    });
  });

  group('LoginParams', () {
    test('should create params with email and password', () {
      final params = LoginParams(email: tEmail, password: tPassword);

      expect(params.email, tEmail);
      expect(params.password, tPassword);
    });
  });
}
