import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:how_weather/core/exceptions/app_exceptions.dart';
import 'package:how_weather/features/login/domain/entities/user_entity.dart';
import 'package:how_weather/features/login/domain/usecases/login_usecase.dart';
import 'package:how_weather/features/login/presentation/cubit/login_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginCubit cubit;
  late MockLoginUseCase mockLoginUseCase;

  setUpAll(() {
    registerFallbackValue(LoginParams(email: '', password: ''));
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    cubit = LoginCubit(loginUseCase: mockLoginUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUser = UserEntity(
    id: '1',
    email: tEmail,
    name: 'Test User',
    token: 'test_token',
  );

  group('LoginCubit', () {
    test('initial state should be LoginState.initial()', () {
      expect(cubit.state, const LoginState.initial());
    });

    blocTest<LoginCubit, LoginState>(
      'should emit [loading, success] when login is successful',
      build: () {
        when(
          () => mockLoginUseCase(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return cubit;
      },
      act: (cubit) => cubit.login(email: tEmail, password: tPassword),
      expect: () => [
        const LoginState.loading(),
        const LoginState.success(tUser),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(any())).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'should emit [loading, failure] when validation fails',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer(
          (_) async => const Left(ValidationException('Invalid email format')),
        );
        return cubit;
      },
      act: (cubit) => cubit.login(email: 'invalid_email', password: tPassword),
      expect: () => [
        const LoginState.loading(),
        const LoginState.failure('Invalid email format'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'should emit [loading, failure] when credentials are wrong',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer(
          (_) async => const Left(UnauthorizedException('Invalid credentials')),
        );
        return cubit;
      },
      act: (cubit) => cubit.login(email: tEmail, password: 'wrong_password'),
      expect: () => [
        const LoginState.loading(),
        const LoginState.failure('Invalid credentials'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'should emit [loading, failure] when network error occurs',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer(
          (_) async => const Left(NetworkException('No internet connection')),
        );
        return cubit;
      },
      act: (cubit) => cubit.login(email: tEmail, password: tPassword),
      expect: () => [
        const LoginState.loading(),
        const LoginState.failure('No internet connection'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'should emit [loading, failure] when server error occurs',
      build: () {
        when(
          () => mockLoginUseCase(any()),
        ).thenAnswer((_) async => const Left(ServerException('Server error')));
        return cubit;
      },
      act: (cubit) => cubit.login(email: tEmail, password: tPassword),
      expect: () => [
        const LoginState.loading(),
        const LoginState.failure('Server error'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'should emit initial state when reset is called',
      build: () => cubit,
      seed: () => const LoginState.failure('Some error'),
      act: (cubit) => cubit.reset(),
      expect: () => [const LoginState.initial()],
    );

    blocTest<LoginCubit, LoginState>(
      'should handle multiple login attempts',
      build: () {
        when(
          () => mockLoginUseCase(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return cubit;
      },
      act: (cubit) async {
        await cubit.login(email: tEmail, password: tPassword);
        await cubit.login(email: tEmail, password: tPassword);
      },
      expect: () => [
        const LoginState.loading(),
        const LoginState.success(tUser),
        const LoginState.loading(),
        const LoginState.success(tUser),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(any())).called(2);
      },
    );
  });
}
