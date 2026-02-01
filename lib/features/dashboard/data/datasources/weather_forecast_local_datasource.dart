import 'dart:convert';
import 'package:injectable/injectable.dart';

import '../../../../core/services/shared_preferences_service.dart';
import '../models/weather_forecast_model.dart';

abstract class WeatherForecastLocalDataSource {
  Future<void> saveWeatherData(WeatherForecastResponseModel response);
  Future<WeatherForecastResponseModel?> getWeatherData();
  Future<DateTime?> getLastUpdated();
}

@Injectable(as: WeatherForecastLocalDataSource)
class WeatherForecastLocalDataSourceImpl
    implements WeatherForecastLocalDataSource {
  static const String forecastsKey = 'weather_forecasts';
  static const String cityKey = 'weather_city';
  static const String lastUpdatedKey = 'weather_last_updated';

  final SharedPreferencesService _sharedPreferencesService;

  WeatherForecastLocalDataSourceImpl({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  @override
  Future<void> saveWeatherData(WeatherForecastResponseModel response) async {
    final forecastsJson = response.list?.map((e) => e.toJson()).toList();
    final cityJson = response.city?.toJson();

    await _sharedPreferencesService.setString(
      key: forecastsKey,
      value: forecastsJson != null ? jsonEncode(forecastsJson) : '',
    );

    if (cityJson != null) {
      await _sharedPreferencesService.setString(
        key: cityKey,
        value: jsonEncode(cityJson),
      );
    }

    await _sharedPreferencesService.setInt(
      key: lastUpdatedKey,
      value: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<WeatherForecastResponseModel?> getWeatherData() async {
    final forecastsJsonString = await _sharedPreferencesService.getString(
      key: forecastsKey,
    );
    if (forecastsJsonString == null || forecastsJsonString.isEmpty) return null;

    final cityJsonString = await _sharedPreferencesService.getString(
      key: cityKey,
    );

    final forecastsJson = jsonDecode(forecastsJsonString) as List;
    final forecasts = forecastsJson
        .map((json) => WeatherForecastModel.fromJson(json))
        .toList();
    final city = cityJsonString != null
        ? CityModel.fromJson(jsonDecode(cityJsonString))
        : null;

    return WeatherForecastResponseModel(
      cod: '200',
      message: 0,
      cnt: forecasts.length,
      list: forecasts,
      city: city,
    );
  }

  @override
  Future<DateTime?> getLastUpdated() async {
    final lastUpdatedMillis = await _sharedPreferencesService.getInt(
      key: lastUpdatedKey,
    );
    return lastUpdatedMillis != null
        ? DateTime.fromMillisecondsSinceEpoch(lastUpdatedMillis)
        : null;
  }
}
