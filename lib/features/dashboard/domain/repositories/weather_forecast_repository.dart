import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/weather_forecast.dart';

abstract class WeatherForecastRepository {
  Future<Either<AppException, WeatherForecastResponse>> getWeatherForecast({
    required double lat,
    required double lon,
  });
}
