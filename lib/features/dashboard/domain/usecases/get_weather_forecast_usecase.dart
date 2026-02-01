import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../entities/weather_forecast.dart';
import '../repositories/weather_forecast_repository.dart';

@injectable
class GetWeatherForecastUseCase {
  final WeatherForecastRepository _repository;

  GetWeatherForecastUseCase(this._repository);

  Future<Either<AppException, WeatherForecastResponse>> call({
    required double lat,
    required double lon,
  }) {
    return _repository.getWeatherForecast(lat: lat, lon: lon);
  }
}
