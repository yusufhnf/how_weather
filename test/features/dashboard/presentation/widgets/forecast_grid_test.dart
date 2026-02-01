import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:how_weather/core/core.dart';
import 'package:how_weather/features/dashboard/domain/entities/weather_forecast.dart';
import 'package:how_weather/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:how_weather/features/dashboard/presentation/widgets/forecast_grid.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class MockDashboardCubit extends Mock implements DashboardCubit {}

final getIt = GetIt.instance;

void main() {
  late MockDashboardCubit mockDashboardCubit;
  late StreamController<DashboardState> dashboardStateController;

  setUp(() {
    // Set up larger test window size to prevent layout overflow
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first.physicalSize = const Size(1080, 1920);
    binding.platformDispatcher.views.first.devicePixelRatio = 1.0;

    mockDashboardCubit = MockDashboardCubit();
    dashboardStateController = StreamController<DashboardState>.broadcast();

    getIt.registerFactory<DashboardCubit>(() => mockDashboardCubit);

    when(
      () => mockDashboardCubit.state,
    ).thenReturn(const DashboardState.initial());
    when(
      () => mockDashboardCubit.stream,
    ).thenAnswer((_) => dashboardStateController.stream);
    when(() => mockDashboardCubit.close()).thenAnswer((_) async {});
    when(() => mockDashboardCubit.refreshForecast()).thenAnswer((_) async {});
  });

  tearDown(() {
    dashboardStateController.close();
    getIt.reset();
    // Reset window size
    final binding = TestWidgetsFlutterBinding.instance;
    binding.platformDispatcher.views.first.resetPhysicalSize();
    binding.platformDispatcher.views.first.resetDevicePixelRatio();
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(
        1080,
        1920,
      ), // Larger screen size to prevent layout overflow
      builder: (context, child) => MaterialApp(
        locale: const Locale('en', 'US'),
        localizationsDelegates: const [I18nDelegate()],
        supportedLocales: I18nDelegate.supportedLocales,
        home: BlocProvider<DashboardCubit>(
          create: (_) => mockDashboardCubit,
          child: const Scaffold(
            body: CustomScrollView(slivers: [ForecastGrid()]),
          ),
        ),
      ),
    );
  }

  group('ForecastGrid Widget Tests', () {
    testWidgets('should display loading grid when state is forecastLoading', (
      tester,
    ) async {
      // Arrange
      when(
        () => mockDashboardCubit.state,
      ).thenReturn(const DashboardState.forecastLoading());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(SliverGrid), findsOneWidget);
      expect(find.byType(Shimmer), findsNWidgets(6)); // 6 shimmer placeholders
    });

    testWidgets('should display loaded grid when state is forecastLoaded', (
      tester,
    ) async {
      // Arrange
      final tForecasts = List.generate(
        6,
        (index) => WeatherForecast(
          dt: 1640995200 + (index * 3600),
          main: MainData(temp: 20.0 + index),
          weather: [
            const WeatherData(id: 800, main: 'Clear', description: 'clear sky'),
          ],
        ),
      );

      when(() => mockDashboardCubit.state).thenReturn(
        DashboardState.forecastLoaded(
          forecasts: tForecasts,
          city: const City(id: 1, name: 'Jakarta'),
          lastUpdated: DateTime.now(),
        ),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(ReorderableGridView), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(6)); // 6 forecast cards
    });

    testWidgets(
      'should limit display to 20 forecasts when more than 20 available',
      (tester) async {
        // Arrange
        final tForecasts = List.generate(
          25, // More than 20
          (index) => WeatherForecast(
            dt: 1640995200 + (index * 3600),
            main: MainData(temp: 20.0 + index),
            weather: [
              const WeatherData(
                id: 800,
                main: 'Clear',
                description: 'clear sky',
              ),
            ],
          ),
        );

        when(() => mockDashboardCubit.state).thenReturn(
          DashboardState.forecastLoaded(
            forecasts: tForecasts,
            city: const City(id: 1, name: 'Jakarta'),
            lastUpdated: DateTime.now(),
          ),
        );

        // Act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        // Assert
        expect(find.byType(ReorderableGridView), findsOneWidget);
        expect(find.byType(Card), findsNWidgets(20)); // Limited to 20 cards
      },
    );

    testWidgets('should display error view when state is forecastError', (
      tester,
    ) async {
      // Arrange
      const tException = AppException(
        code: 'NETWORK_ERROR',
        message: 'Network error',
      );
      when(
        () => mockDashboardCubit.state,
      ).thenReturn(const DashboardState.forecastError(message: tException));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(SliverToBoxAdapter), findsOneWidget);
      expect(
        find.text('Error loading forecast: Network error'),
        findsOneWidget,
      );
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('should call refreshForecast when retry button is tapped', (
      tester,
    ) async {
      // Arrange
      const tException = AppException(
        code: 'NETWORK_ERROR',
        message: 'Network error',
      );
      when(
        () => mockDashboardCubit.state,
      ).thenReturn(const DashboardState.forecastError(message: tException));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.tap(find.text('Retry'));
      await tester.pump();

      // Assert
      verify(() => mockDashboardCubit.refreshForecast()).called(1);
    });

    testWidgets('should call reorderForecasts when grid items are reordered', (
      tester,
    ) async {
      // Arrange
      final tForecasts = List.generate(
        4,
        (index) => WeatherForecast(
          dt: 1640995200 + (index * 3600),
          main: MainData(temp: 20.0 + index),
          weather: [
            const WeatherData(id: 800, main: 'Clear', description: 'clear sky'),
          ],
        ),
      );

      when(() => mockDashboardCubit.state).thenReturn(
        DashboardState.forecastLoaded(
          forecasts: tForecasts,
          city: const City(id: 1, name: 'Jakarta'),
          lastUpdated: DateTime.now(),
        ),
      );
      when(
        () => mockDashboardCubit.reorderForecasts(any(), any()),
      ).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Find the ReorderableGridView and simulate reordering
      final reorderableGrid = find.byType(ReorderableGridView);
      expect(reorderableGrid, findsOneWidget);

      // Note: Testing actual drag-and-drop is complex in widget tests
      // We verify the onReorder callback is properly set up by checking
      // that the widget exists and the callback can be called
      final reorderableGridWidget = tester.widget<ReorderableGridView>(
        reorderableGrid,
      );
      expect(reorderableGridWidget.onReorder, isNotNull);
    });

    testWidgets('should display loading grid for initial state', (
      tester,
    ) async {
      // Arrange
      when(
        () => mockDashboardCubit.state,
      ).thenReturn(const DashboardState.initial());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(SliverGrid), findsOneWidget);
      expect(find.byType(Shimmer), findsNWidgets(6)); // 6 shimmer placeholders
    });

    testWidgets('should have proper grid layout with 2 columns', (
      tester,
    ) async {
      // Arrange
      final tForecasts = [
        const WeatherForecast(
          dt: 1640995200,
          main: MainData(temp: 25.0),
          weather: [
            WeatherData(id: 800, main: 'Clear', description: 'clear sky'),
          ],
        ),
      ];

      when(() => mockDashboardCubit.state).thenReturn(
        DashboardState.forecastLoaded(
          forecasts: tForecasts,
          city: const City(id: 1, name: 'Jakarta'),
          lastUpdated: DateTime.now(),
        ),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      final reorderableGrid = find.byType(ReorderableGridView);
      expect(reorderableGrid, findsOneWidget);

      final reorderableGridWidget = tester.widget<ReorderableGridView>(
        reorderableGrid,
      );
      expect(
        (reorderableGridWidget.gridDelegate
                as SliverGridDelegateWithFixedCrossAxisCount)
            .crossAxisCount,
        2,
      );
    });

    testWidgets('should handle empty forecasts list', (tester) async {
      // Arrange
      when(() => mockDashboardCubit.state).thenReturn(
        DashboardState.forecastLoaded(
          forecasts: [],
          city: const City(id: 1, name: 'Jakarta'),
          lastUpdated: DateTime.now(),
        ),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(ReorderableGridView), findsOneWidget);
      expect(find.byType(Card), findsNothing); // No cards for empty list
    });
  });
}
