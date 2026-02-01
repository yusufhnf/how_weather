import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../models/weather_forecast_model.dart';
import '../models/weather_forecast_query_params.dart';

abstract class WeatherForecastRemoteDataSource {
  Future<Either<AppException, WeatherForecastResponseModel>>
  getWeatherForecast({required double lat, required double lon});
}

@LazySingleton(as: WeatherForecastRemoteDataSource)
class WeatherForecastRemoteDataSourceImpl
    implements WeatherForecastRemoteDataSource {
  final HttpClientService _httpClientService;

  WeatherForecastRemoteDataSourceImpl({
    @Named('openWeatherAPI') required HttpClientService httpClientService,
  }) : _httpClientService = httpClientService;

  @override
  Future<Either<AppException, WeatherForecastResponseModel>>
  getWeatherForecast({required double lat, required double lon}) async {
    try {
      // Get API key from environment
      final apiKey = Env.weatherApiKey;

      final queryParams = WeatherForecastQueryParams(
        lat: lat,
        lon: lon,
        appid: apiKey,
      );

      final response = await _httpClientService.get(
        path: '/data/2.5/forecast',
        queryParameters: queryParams.toMap(),
      );

      final data = json.decode(response.data as String) as Map<String, dynamic>;
      final forecastResponse = WeatherForecastResponseModel.fromJson(data);

      return Right(forecastResponse);
    } catch (e) {
      return Left(ServerException('Failed to fetch weather forecast: $e'));
    }
  }
}
