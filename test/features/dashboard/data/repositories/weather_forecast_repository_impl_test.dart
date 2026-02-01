import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:how_weather/core/exceptions/app_exceptions.dart';
import 'package:how_weather/features/dashboard/data/datasources/weather_forecast_local_datasource.dart';
import 'package:how_weather/features/dashboard/data/datasources/weather_forecast_remote_datasource.dart';
import 'package:how_weather/features/dashboard/data/models/weather_forecast_model.dart';
import 'package:how_weather/features/dashboard/data/repositories/weather_forecast_repository_impl.dart';
import 'package:how_weather/features/dashboard/domain/entities/weather_forecast.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherForecastRemoteDataSource extends Mock
    implements WeatherForecastRemoteDataSource {}

class MockWeatherForecastLocalDataSource extends Mock
    implements WeatherForecastLocalDataSource {}

void main() {
  late WeatherForecastRepositoryImpl repository;
  late MockWeatherForecastRemoteDataSource mockRemoteDataSource;
  late MockWeatherForecastLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockWeatherForecastRemoteDataSource();
    mockLocalDataSource = MockWeatherForecastLocalDataSource();
    repository = WeatherForecastRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tLat = -6.2088;
  const tLon = 106.8456;

  const tWeatherForecastResponseModel = WeatherForecastResponseModel(
    cod: '200',
    message: 0,
    cnt: 40,
    list: [],
    city: null,
  );

  final tWeatherForecastResponse = tWeatherForecastResponseModel.toEntity();

  group('WeatherForecastRepositoryImpl', () {
    group('getWeatherForecast', () {
      test(
        'should return cached data when available and not forcing remote',
        () async {
          // Arrange
          when(
            () => mockLocalDataSource.getWeatherData(),
          ).thenAnswer((_) async => tWeatherForecastResponseModel);

          // Act
          final result = await repository.getWeatherForecast(
            lat: tLat,
            lon: tLon,
          );

          // Assert
          expect(result, Right(tWeatherForecastResponse));
          verify(() => mockLocalDataSource.getWeatherData()).called(1);
          verifyNever(
            () => mockRemoteDataSource.getWeatherForecast(lat: tLat, lon: tLon),
          );
          verifyNoMoreInteractions(mockLocalDataSource);
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );

      test(
        'should fetch from remote when no cached data and not forcing remote',
        () async {
          // Arrange
          when(
            () => mockLocalDataSource.getWeatherData(),
          ).thenAnswer((_) async => null);
          when(
            () => mockRemoteDataSource.getWeatherForecast(lat: tLat, lon: tLon),
          ).thenAnswer((_) async => Right(tWeatherForecastResponseModel));
          when(
            () => mockLocalDataSource.saveWeatherData(
              tWeatherForecastResponseModel,
            ),
          ).thenAnswer((_) async {});

          // Act
          final result = await repository.getWeatherForecast(
            lat: tLat,
            lon: tLon,
          );

          // Assert
          expect(result, Right(tWeatherForecastResponse));
          verify(() => mockLocalDataSource.getWeatherData()).called(1);
          verify(
            () => mockRemoteDataSource.getWeatherForecast(lat: tLat, lon: tLon),
          ).called(1);
          verify(
            () => mockLocalDataSource.saveWeatherData(
              tWeatherForecastResponseModel,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockLocalDataSource);
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );

      test(
        'should fetch from remote when forcing remote even if cached data exists',
        () async {
          // Arrange
          when(
            () => mockLocalDataSource.getWeatherData(),
          ).thenAnswer((_) async => tWeatherForecastResponseModel);
          when(
            () => mockRemoteDataSource.getWeatherForecast(lat: tLat, lon: tLon),
          ).thenAnswer((_) async => Right(tWeatherForecastResponseModel));
          when(
            () => mockLocalDataSource.saveWeatherData(
              tWeatherForecastResponseModel,
            ),
          ).thenAnswer((_) async {});

          // Act
          final result = await repository.getWeatherForecast(
            lat: tLat,
            lon: tLon,
            forceGetFromRemote: true,
          );

          // Assert
          expect(result, Right(tWeatherForecastResponse));
          verify(
            () => mockLocalDataSource.getWeatherData(),
          ).called(1); // Implementation checks local first
          verify(
            () => mockRemoteDataSource.getWeatherForecast(lat: tLat, lon: tLon),
          ).called(1);
          verify(
            () => mockLocalDataSource.saveWeatherData(
              tWeatherForecastResponseModel,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockLocalDataSource);
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );

      test('should return AppException when remote call fails', () async {
        // Arrange
        const tException = AppException(
          code: 'NETWORK_ERROR',
          message: 'Network error',
        );
        when(
          () => mockLocalDataSource.getWeatherData(),
        ).thenAnswer((_) async => null);
        when(
          () => mockRemoteDataSource.getWeatherForecast(lat: tLat, lon: tLon),
        ).thenAnswer((_) async => const Left(tException));

        // Act
        final result = await repository.getWeatherForecast(
          lat: tLat,
          lon: tLon,
        );

        // Assert
        expect(result, const Left(tException));
        verify(() => mockLocalDataSource.getWeatherData()).called(1);
        verify(
          () => mockRemoteDataSource.getWeatherForecast(lat: tLat, lon: tLon),
        ).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });

    group('getLastUpdated', () {
      test('should return DateTime from local data source', () async {
        // Arrange
        final tDateTime = DateTime.now();
        when(
          () => mockLocalDataSource.getLastUpdated(),
        ).thenAnswer((_) async => tDateTime);

        // Act
        final result = await repository.getLastUpdated();

        // Assert
        expect(result, tDateTime);
        verify(() => mockLocalDataSource.getLastUpdated()).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);
      });
    });

    group('saveReorderedForecasts', () {
      test('should return void when saving succeeds', () async {
        // Arrange
        final tForecasts = <WeatherForecast>[];
        when(
          () => mockLocalDataSource.saveReorderedForecasts(tForecasts),
        ).thenAnswer((_) async {});

        // Act
        final result = await repository.saveReorderedForecasts(tForecasts);

        // Assert
        expect(result, const Right(null));
        verify(
          () => mockLocalDataSource.saveReorderedForecasts(tForecasts),
        ).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);
      });

      test('should return AppException when saving fails', () async {
        // Arrange
        final tForecasts = <WeatherForecast>[];
        when(
          () => mockLocalDataSource.saveReorderedForecasts(tForecasts),
        ).thenThrow(Exception('Save failed'));

        // Act
        final result = await repository.saveReorderedForecasts(tForecasts);

        // Assert
        expect(result.isLeft(), true);
        result.fold((error) {
          expect(error.code, 'SAVE_REORDER_ERROR');
          expect(error.message, 'Failed to save reordered forecasts');
        }, (_) => fail('Expected Left but got Right'));
        verify(
          () => mockLocalDataSource.saveReorderedForecasts(tForecasts),
        ).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);
      });
    });
  });
}
