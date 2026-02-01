import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/weather_forecast.dart';
import '../../domain/repositories/weather_forecast_repository.dart';
import '../datasources/weather_forecast_local_datasource.dart';
import '../datasources/weather_forecast_remote_datasource.dart';
import '../models/weather_forecast_model.dart';

@LazySingleton(as: WeatherForecastRepository)
class WeatherForecastRepositoryImpl implements WeatherForecastRepository {
  final WeatherForecastRemoteDataSource _remoteDataSource;
  final WeatherForecastLocalDataSource _localDataSource;

  WeatherForecastRepositoryImpl({
    required WeatherForecastRemoteDataSource remoteDataSource,
    required WeatherForecastLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Either<AppException, WeatherForecastResponse>> getWeatherForecast({
    required double lat,
    required double lon,
    forceGetFromRemote = false,
  }) async {
    // Try to get from local first
    final localData = await _localDataSource.getWeatherData();
    if (localData != null && !forceGetFromRemote) {
      return Right(localData.toEntity());
    }

    // If no local data, fetch from remote
    final result = await _remoteDataSource.getWeatherForecast(
      lat: lat,
      lon: lon,
    );
    return result.map((response) {
      // Save to local
      _localDataSource.saveWeatherData(response);
      return response.toEntity();
    });
  }

  @override
  Future<DateTime?> getLastUpdated() async {
    return _localDataSource.getLastUpdated();
  }
}
