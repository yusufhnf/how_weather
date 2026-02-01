import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:how_weather/core/services/shared_preferences_service.dart';
import 'package:how_weather/features/dashboard/data/datasources/weather_forecast_local_datasource.dart';
import 'package:how_weather/features/dashboard/data/models/weather_forecast_model.dart';
import 'package:how_weather/features/dashboard/domain/entities/weather_forecast.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

void main() {
  late WeatherForecastLocalDataSourceImpl dataSource;
  late MockSharedPreferencesService mockSharedPreferencesService;

  setUp(() {
    mockSharedPreferencesService = MockSharedPreferencesService();
    dataSource = WeatherForecastLocalDataSourceImpl(
      sharedPreferencesService: mockSharedPreferencesService,
    );
  });

  const tWeatherForecastResponseModel = WeatherForecastResponseModel(
    cod: '200',
    message: 0,
    cnt: 40,
    list: [
      WeatherForecastModel(
        dt: 1640995200,
        main: MainDataModel(temp: 25.0),
        weather: [
          WeatherDataModel(id: 800, main: 'Clear', description: 'clear sky'),
        ],
      ),
    ],
    city: CityModel(id: 1, name: 'Jakarta'),
  );

  group('WeatherForecastLocalDataSourceImpl', () {
    group('saveWeatherData', () {
      test('should save weather data to shared preferences', () async {
        // Arrange
        when(
          () => mockSharedPreferencesService.setString(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockSharedPreferencesService.setInt(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await dataSource.saveWeatherData(tWeatherForecastResponseModel);

        // Assert
        verify(
          () => mockSharedPreferencesService.setString(
            key: 'weather_forecasts',
            value: jsonEncode(
              tWeatherForecastResponseModel.list
                  ?.map((e) => e.toJson())
                  .toList(),
            ),
          ),
        ).called(1);
        verify(
          () => mockSharedPreferencesService.setString(
            key: 'weather_city',
            value: jsonEncode(tWeatherForecastResponseModel.city?.toJson()),
          ),
        ).called(1);
        verify(
          () => mockSharedPreferencesService.setInt(
            key: 'weather_last_updated',
            value: any(named: 'value'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockSharedPreferencesService);
      });
    });

    group('getWeatherData', () {
      test(
        'should return WeatherForecastResponseModel when data exists',
        () async {
          // Arrange
          final forecastsJson = tWeatherForecastResponseModel.list
              ?.map((e) => e.toJson())
              .toList();
          final cityJson = tWeatherForecastResponseModel.city?.toJson();

          when(
            () => mockSharedPreferencesService.getString(
              key: 'weather_forecasts',
            ),
          ).thenAnswer((_) async => jsonEncode(forecastsJson));
          when(
            () => mockSharedPreferencesService.getString(key: 'weather_city'),
          ).thenAnswer((_) async => jsonEncode(cityJson));

          // Act
          final result = await dataSource.getWeatherData();

          // Assert
          expect(result, isNotNull);
          expect(result?.cod, tWeatherForecastResponseModel.cod);
          expect(
            result?.list?.length,
            tWeatherForecastResponseModel.list?.length,
          );
          verify(
            () => mockSharedPreferencesService.getString(
              key: 'weather_forecasts',
            ),
          ).called(1);
          verify(
            () => mockSharedPreferencesService.getString(key: 'weather_city'),
          ).called(1);
          verifyNoMoreInteractions(mockSharedPreferencesService);
        },
      );

      test('should return null when no forecasts data exists', () async {
        // Arrange
        when(
          () =>
              mockSharedPreferencesService.getString(key: 'weather_forecasts'),
        ).thenAnswer((_) async => null);

        // Act
        final result = await dataSource.getWeatherData();

        // Assert
        expect(result, isNull);
        verify(
          () =>
              mockSharedPreferencesService.getString(key: 'weather_forecasts'),
        ).called(1);
        verifyNoMoreInteractions(mockSharedPreferencesService);
      });

      test('should return null when forecasts data is empty', () async {
        // Arrange
        when(
          () =>
              mockSharedPreferencesService.getString(key: 'weather_forecasts'),
        ).thenAnswer((_) async => '');

        // Act
        final result = await dataSource.getWeatherData();

        // Assert
        expect(result, isNull);
        verify(
          () =>
              mockSharedPreferencesService.getString(key: 'weather_forecasts'),
        ).called(1);
        verifyNoMoreInteractions(mockSharedPreferencesService);
      });
    });

    group('getLastUpdated', () {
      test('should return DateTime when timestamp exists', () async {
        // Arrange
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        when(
          () =>
              mockSharedPreferencesService.getInt(key: 'weather_last_updated'),
        ).thenAnswer((_) async => timestamp);

        // Act
        final result = await dataSource.getLastUpdated();

        // Assert
        expect(result, isNotNull);
        expect(result?.millisecondsSinceEpoch, timestamp);
        verify(
          () =>
              mockSharedPreferencesService.getInt(key: 'weather_last_updated'),
        ).called(1);
        verifyNoMoreInteractions(mockSharedPreferencesService);
      });

      test('should return null when no timestamp exists', () async {
        // Arrange
        when(
          () =>
              mockSharedPreferencesService.getInt(key: 'weather_last_updated'),
        ).thenAnswer((_) async => null);

        // Act
        final result = await dataSource.getLastUpdated();

        // Assert
        expect(result, isNull);
        verify(
          () =>
              mockSharedPreferencesService.getInt(key: 'weather_last_updated'),
        ).called(1);
        verifyNoMoreInteractions(mockSharedPreferencesService);
      });
    });

    group('saveReorderedForecasts', () {
      test('should save reordered forecasts to shared preferences', () async {
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

        when(
          () => mockSharedPreferencesService.setString(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockSharedPreferencesService.setInt(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await dataSource.saveReorderedForecasts(tForecasts);

        // Assert
        verify(
          () => mockSharedPreferencesService.setString(
            key: 'weather_forecasts',
            value: any(named: 'value'),
          ),
        ).called(1);
        verify(
          () => mockSharedPreferencesService.setInt(
            key: 'weather_last_updated',
            value: any(named: 'value'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockSharedPreferencesService);
      });
    });
  });
}
