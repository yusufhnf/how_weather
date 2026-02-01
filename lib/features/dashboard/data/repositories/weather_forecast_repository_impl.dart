import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/weather_forecast.dart';
import '../../domain/repositories/weather_forecast_repository.dart';
import '../datasources/weather_forecast_remote_datasource.dart';
import '../models/weather_forecast_model.dart';

@LazySingleton(as: WeatherForecastRepository)
class WeatherForecastRepositoryImpl implements WeatherForecastRepository {
  final WeatherForecastRemoteDataSource _remoteDataSource;

  WeatherForecastRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<AppException, WeatherForecastResponse>> getWeatherForecast({
    required double lat,
    required double lon,
  }) async {
    final result = await _remoteDataSource.getWeatherForecast(
      lat: lat,
      lon: lon,
    );
    return result.map((response) => response.toEntity());
  }
}
