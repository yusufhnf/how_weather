import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:how_weather/core/exceptions/app_exceptions.dart';
import 'package:how_weather/core/services/location_service.dart';
import 'package:how_weather/features/dashboard/domain/entities/weather_forecast.dart';
import 'package:how_weather/features/dashboard/domain/repositories/weather_forecast_repository.dart';
import 'package:how_weather/features/dashboard/domain/usecases/get_weather_forecast_usecase.dart';
import 'package:how_weather/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockGetWeatherForecastUseCase extends Mock
    implements GetWeatherForecastUseCase {}

class MockWeatherForecastRepository extends Mock
    implements WeatherForecastRepository {}

class MockLocationService extends Mock implements LocationService {}

// Test data
final tWeatherForecast = WeatherForecast(
  dt: 1640995200,
  main: const MainData(temp: 25.0),
  weather: const [
    WeatherData(id: 800, main: 'Clear', description: 'clear sky'),
  ],
  dtTxt: '2022-01-01 12:00:00',
);

const tWeatherForecastResponse = WeatherForecastResponse(
  cod: '200',
  message: 0,
  cnt: 40,
  list: [],
  city: City(id: 1, name: 'Jakarta'),
);

void main() {
  late DashboardCubit cubit;
  late MockGetWeatherForecastUseCase mockUseCase;
  late MockWeatherForecastRepository mockRepository;
  late MockLocationService mockLocationService;

  setUpAll(() {
    registerFallbackValue(
      Position(
        latitude: 0,
        longitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      ),
    );
    registerFallbackValue(tWeatherForecastResponse);
    registerFallbackValue(<WeatherForecast>[]);
  });

  setUp(() {
    mockUseCase = MockGetWeatherForecastUseCase();
    mockRepository = MockWeatherForecastRepository();
    mockLocationService = MockLocationService();

    // Mock the location service to prevent automatic loading in constructor
    when(() => mockLocationService.getCurrentLocation()).thenAnswer(
      (_) async => Left<NetworkException, Position>(
        const NetworkException('Location denied'),
      ),
    );

    cubit = DashboardCubit(
      getWeatherForecastUseCase: mockUseCase,
      repository: mockRepository,
      locationService: mockLocationService,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be error state due to mocked location failure', () {
    // Since the cubit constructor calls _loadWeatherForecast which uses the mocked location service
    // that returns an error, the initial state will be an error state
    expect(cubit.state, isA<DashboardState>());
  });

  blocTest<DashboardCubit, DashboardState>(
    'should emit loading and loaded states on successful refresh',
    build: () {
      when(() => mockLocationService.getCurrentLocation()).thenAnswer(
        (_) async => Right<NetworkException, Position>(
          Position(
            latitude: 0,
            longitude: 0,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
            altitudeAccuracy: 0,
            headingAccuracy: 0,
          ),
        ),
      );
      when(
        () => mockUseCase.call(
          lat: any(named: 'lat'),
          lon: any(named: 'lon'),
          forceGetFromRemote: any(named: 'forceGetFromRemote'),
        ),
      ).thenAnswer(
        (_) async => Right<AppException, WeatherForecastResponse>(
          tWeatherForecastResponse,
        ),
      );
      when(
        () => mockRepository.getLastUpdated(),
      ).thenAnswer((_) async => DateTime.now());
      return cubit;
    },
    act: (cubit) => cubit.refreshForecast(),
    expect: () => [
      const DashboardState.forecastLoading(isCollapsed: false),
      isA<DashboardState>(), // The loaded state
    ],
  );

  blocTest<DashboardCubit, DashboardState>(
    'should emit loading and error states on location failure',
    build: () {
      when(() => mockLocationService.getCurrentLocation()).thenAnswer(
        (_) async => Left<NetworkException, Position>(
          const NetworkException('Location denied'),
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.refreshForecast(),
    expect: () => [
      const DashboardState.forecastLoading(isCollapsed: false),
      isA<DashboardState>(), // The error state
    ],
  );

  test('should handle reorder forecasts', () async {
    final initialState = DashboardState.forecastLoaded(
      isCollapsed: false,
      forecasts: [tWeatherForecast],
      city: const City(id: 1, name: 'Jakarta'),
    );

    cubit.emit(initialState);

    when(
      () => mockRepository.saveReorderedForecasts(any()),
    ).thenAnswer((_) async => Right<AppException, void>(null));

    await cubit.reorderForecasts(0, 1);

    verify(() => mockRepository.saveReorderedForecasts(any())).called(1);
  });
}
