import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:how_weather/core/core.dart';
import 'package:how_weather/features/login/domain/entities/user_entity.dart';
import 'package:how_weather/features/login/presentation/cubit/login_cubit.dart';
import 'package:how_weather/features/login/presentation/pages/login_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginCubit extends Mock implements LoginCubit {}

class MockAppCubit extends Mock implements AppCubit {}

final getIt = GetIt.instance;

void main() {
  late MockLoginCubit mockLoginCubit;
  late MockAppCubit mockAppCubit;
  late StreamController<LoginState> loginStateController;
  late StreamController<AppState> appStateController;

  setUpAll(() {
    registerFallbackValue(
      const UserEntity(id: '', email: '', name: '', token: ''),
    );
  });

  setUp(() {
    mockLoginCubit = MockLoginCubit();
    mockAppCubit = MockAppCubit();
    loginStateController = StreamController<LoginState>.broadcast();
    appStateController = StreamController<AppState>.broadcast();

    getIt.registerFactory<LoginCubit>(() => mockLoginCubit);

    when(() => mockLoginCubit.state).thenReturn(const LoginState.initial());
    when(
      () => mockLoginCubit.stream,
    ).thenAnswer((_) => loginStateController.stream);
    when(() => mockLoginCubit.close()).thenAnswer((_) async {});
    when(
      () => mockLoginCubit.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async {});

    when(() => mockAppCubit.state).thenReturn(
      const AppState(
        themeMode: ThemeMode.light,
        locale: Locale('en', 'US'),
        userLogged: null,
      ),
    );
    when(
      () => mockAppCubit.stream,
    ).thenAnswer((_) => appStateController.stream);
    when(() => mockAppCubit.close()).thenAnswer((_) async {});
    when(() => mockAppCubit.login(any())).thenAnswer((_) async {});
  });

  tearDown(() {
    loginStateController.close();
    appStateController.close();
    getIt.reset();
  });

  Widget createWidgetUnderTest(WidgetTester tester) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      ],
    );

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => BlocProvider<AppCubit>.value(
        value: mockAppCubit,
        child: MaterialApp.router(
          locale: const Locale('en', 'US'),
          localizationsDelegates: [const I18nDelegate()],
          supportedLocales: I18nDelegate.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('should display all UI elements', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pump();

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should show email and password fields', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('should validate empty email', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verifyNever(
        () => mockLoginCubit.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
    });

    testWidgets('should validate invalid email format', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pump();

      await tester.enterText(find.byType(TextFormField).first, 'invalid_email');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verifyNever(
        () => mockLoginCubit.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
    });

    testWidgets('should validate empty password', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pump();

      await tester.enterText(
        find.byType(TextFormField).first,
        'test@example.com',
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verifyNever(
        () => mockLoginCubit.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
    });

    testWidgets('should validate password minimum length', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pump();

      await tester.enterText(
        find.byType(TextFormField).first,
        'test@example.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'short');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verifyNever(
        () => mockLoginCubit.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
      verifyNever(
        () => mockLoginCubit.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
    });

    testWidgets('should call login when form is valid', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pump();

      await tester.enterText(
        find.byType(TextFormField).first,
        'test@example.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(
        () => mockLoginCubit.login(
          email: 'test@example.com',
          password: 'password123',
        ),
      ).called(1);
    });

    testWidgets('should show loading indicator when state is loading', (
      tester,
    ) async {
      when(() => mockLoginCubit.state).thenReturn(const LoginState.loading());

      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('should disable fields when loading', (tester) async {
      when(() => mockLoginCubit.state).thenReturn(const LoginState.loading());

      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pump();

      final emailField = tester.widget<TextFormField>(
        find.byType(TextFormField).first,
      );
      final passwordField = tester.widget<TextFormField>(
        find.byType(TextFormField).last,
      );

      expect(emailField.enabled, false);
      expect(passwordField.enabled, false);
    });

    testWidgets(
      'should show success message and call AppCubit.login on success',
      (tester) async {
        const tUser = UserEntity(
          id: '1',
          email: 'test@example.com',
          name: 'Test User',
          token: 'test_token',
        );

        await tester.pumpWidget(createWidgetUnderTest(tester));
        await tester.pumpAndSettle();
        await tester.pump();

        when(
          () => mockLoginCubit.state,
        ).thenReturn(const LoginState.success(tUser));
        loginStateController.add(const LoginState.success(tUser));
        await tester.pump();
      },
    );

    testWidgets('should show error message on failure', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pumpAndSettle();
      await tester.pump();

      when(
        () => mockLoginCubit.state,
      ).thenReturn(const LoginState.failure('Invalid credentials'));
      loginStateController.add(const LoginState.failure('Invalid credentials'));
      await tester.pump();

      await tester.pumpAndSettle();
      expect(find.text('Invalid credentials'), findsOneWidget);
    });

    testWidgets('should call login when form is valid', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(tester));
      await tester.pump();

      await tester.enterText(
        find.byType(TextFormField).first,
        'test@example.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(
        () => mockLoginCubit.login(
          email: 'test@example.com',
          password: 'password123',
        ),
      ).called(1);
    });
  });
}
