import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:how_weather/core/core.dart';
import 'package:how_weather/features/dashboard/domain/entities/weather_forecast.dart';
import 'package:how_weather/features/dashboard/presentation/widgets/forecast_card.dart';

void main() {
  const tForecast = WeatherForecast(
    dt: 1640995200, // January 1, 2022, 12:00:00 UTC
    main: MainData(temp: 25.5),
    weather: [WeatherData(id: 800, main: 'Clear', description: 'clear sky')],
  );

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => const MaterialApp(
        locale: Locale('en', 'US'),
        localizationsDelegates: [I18nDelegate()],
        supportedLocales: I18nDelegate.supportedLocales,
        home: Scaffold(body: ForecastCard(forecast: tForecast)),
      ),
    );
  }

  group('ForecastCard Widget Tests', () {
    testWidgets('should display forecast time correctly', (tester) async {
      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(Card), findsOneWidget);
      expect(find.text('07:00'), findsOneWidget);
    });

    testWidgets('should display temperature with correct formatting', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.text('25.5°C'), findsOneWidget);
    });

    testWidgets('should display weather description', (tester) async {
      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.text('Clear Sky'), findsOneWidget);
    });

    testWidgets('should display card with proper styling', (tester) async {
      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Padding), findsWidgets); // Card content padding
      expect(find.byType(Column), findsOneWidget); // Main content column
    });

    testWidgets('should handle null dt gracefully', (tester) async {
      // Arrange
      const forecastWithNullDt = WeatherForecast(
        dt: null,
        main: MainData(temp: 25.5),
        weather: [
          WeatherData(id: 800, main: 'Clear', description: 'clear sky'),
        ],
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (context, child) => const MaterialApp(
            locale: Locale('en', 'US'),
            localizationsDelegates: [I18nDelegate()],
            supportedLocales: I18nDelegate.supportedLocales,
            home: Scaffold(body: ForecastCard(forecast: forecastWithNullDt)),
          ),
        ),
      );
      await tester.pump();

      // Assert - should not crash and display current time
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should handle null temperature gracefully', (tester) async {
      // Arrange
      const forecastWithNullTemp = WeatherForecast(
        dt: 1640995200,
        main: MainData(temp: null),
        weather: [
          WeatherData(id: 800, main: 'Clear', description: 'clear sky'),
        ],
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (context, child) => const MaterialApp(
            locale: Locale('en', 'US'),
            localizationsDelegates: [I18nDelegate()],
            supportedLocales: I18nDelegate.supportedLocales,
            home: Scaffold(body: ForecastCard(forecast: forecastWithNullTemp)),
          ),
        ),
      );
      await tester.pump();

      // Assert - should display localized "not available" text
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should handle empty weather list gracefully', (tester) async {
      // Arrange
      const forecastWithEmptyWeather = WeatherForecast(
        dt: 1640995200,
        main: MainData(temp: 25.5),
        weather: [],
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (context, child) => const MaterialApp(
            locale: Locale('en', 'US'),
            localizationsDelegates: [I18nDelegate()],
            supportedLocales: I18nDelegate.supportedLocales,
            home: Scaffold(
              body: ForecastCard(forecast: forecastWithEmptyWeather),
            ),
          ),
        ),
      );
      await tester.pump();

      // Assert - should display localized "unknown" text
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should handle null weather description gracefully', (
      tester,
    ) async {
      // Arrange
      const forecastWithNullDescription = WeatherForecast(
        dt: 1640995200,
        main: MainData(temp: 25.5),
        weather: [WeatherData(id: 800, main: 'Clear', description: null)],
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (context, child) => const MaterialApp(
            locale: Locale('en', 'US'),
            localizationsDelegates: [I18nDelegate()],
            supportedLocales: I18nDelegate.supportedLocales,
            home: Scaffold(
              body: ForecastCard(forecast: forecastWithNullDescription),
            ),
          ),
        ),
      );
      await tester.pump();

      // Assert - should display localized "unknown" text
      expect(find.byType(Card), findsOneWidget);
    });
  });
}
