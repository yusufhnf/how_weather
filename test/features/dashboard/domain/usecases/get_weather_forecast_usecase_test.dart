import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:how_weather/core/exceptions/app_exceptions.dart';
import 'package:how_weather/features/dashboard/domain/entities/weather_forecast.dart';
import 'package:how_weather/features/dashboard/domain/repositories/weather_forecast_repository.dart';
import 'package:how_weather/features/dashboard/domain/usecases/get_weather_forecast_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherForecastRepository extends Mock
    implements WeatherForecastRepository {}

void main() {
  late GetWeatherForecastUseCase useCase;
  late MockWeatherForecastRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherForecastRepository();
    useCase = GetWeatherForecastUseCase(repository: mockRepository);
  });

  const tLat = -6.2088;
  const tLon = 106.8456;
  const tWeatherForecastResponse = WeatherForecastResponse(
    cod: '200',
    message: 0,
    cnt: 40,
    list: [],
    city: null,
  );

  group('GetWeatherForecastUseCase', () {
    test(
      'should return WeatherForecastResponse when repository call is successful',
      () async {
        // Arrange
        when(
          () => mockRepository.getWeatherForecast(
            lat: tLat,
            lon: tLon,
            forceGetFromRemote: false,
          ),
        ).thenAnswer((_) async => const Right(tWeatherForecastResponse));

        // Act
        final result = await useCase.call(lat: tLat, lon: tLon);

        // Assert
        expect(result, const Right(tWeatherForecastResponse));
        verify(
          () => mockRepository.getWeatherForecast(
            lat: tLat,
            lon: tLon,
            forceGetFromRemote: false,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return AppException when repository call fails', () async {
      // Arrange
      const tException = AppException(
        code: 'NETWORK_ERROR',
        message: 'Network error',
      );
      when(
        () => mockRepository.getWeatherForecast(
          lat: tLat,
          lon: tLon,
          forceGetFromRemote: false,
        ),
      ).thenAnswer((_) async => const Left(tException));

      // Act
      final result = await useCase.call(lat: tLat, lon: tLon);

      // Assert
      expect(result, const Left(tException));
      verify(
        () => mockRepository.getWeatherForecast(
          lat: tLat,
          lon: tLon,
          forceGetFromRemote: false,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should pass forceGetFromRemote parameter correctly', () async {
      // Arrange
      when(
        () => mockRepository.getWeatherForecast(
          lat: tLat,
          lon: tLon,
          forceGetFromRemote: true,
        ),
      ).thenAnswer((_) async => const Right(tWeatherForecastResponse));

      // Act
      final result = await useCase.call(
        lat: tLat,
        lon: tLon,
        forceGetFromRemote: true,
      );

      // Assert
      expect(result, const Right(tWeatherForecastResponse));
      verify(
        () => mockRepository.getWeatherForecast(
          lat: tLat,
          lon: tLon,
          forceGetFromRemote: true,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
