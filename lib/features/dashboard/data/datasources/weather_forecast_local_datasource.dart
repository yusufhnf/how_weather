import 'dart:convert';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/weather_forecast.dart';
import '../models/weather_forecast_model.dart';

abstract class WeatherForecastLocalDataSource {
  Future<void> saveWeatherData(WeatherForecastResponseModel response);
  Future<WeatherForecastResponseModel?> getWeatherData();
  Future<DateTime?> getLastUpdated();
  Future<void> saveReorderedForecasts(List<WeatherForecast> forecasts);
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

  @override
  Future<void> saveReorderedForecasts(List<WeatherForecast> forecasts) async {
    final forecastsJson = forecasts.map((forecast) {
      return WeatherForecastModel(
        dt: forecast.dt,
        main: forecast.main != null
            ? MainDataModel(
                temp: forecast.main!.temp,
                feelsLike: forecast.main!.feelsLike,
                tempMin: forecast.main!.tempMin,
                tempMax: forecast.main!.tempMax,
                pressure: forecast.main!.pressure,
                seaLevel: forecast.main!.seaLevel,
                grndLevel: forecast.main!.grndLevel,
                humidity: forecast.main!.humidity,
                tempKf: forecast.main!.tempKf,
              )
            : null,
        weather: forecast.weather
            ?.map(
              (w) => WeatherDataModel(
                id: w.id,
                main: w.main,
                description: w.description,
                icon: w.icon,
              ),
            )
            .toList(),
        clouds: forecast.clouds != null
            ? CloudsModel(all: forecast.clouds!.all)
            : null,
        wind: forecast.wind != null
            ? WindModel(
                speed: forecast.wind!.speed,
                deg: forecast.wind!.deg,
                gust: forecast.wind!.gust,
              )
            : null,
        visibility: forecast.visibility,
        pop: forecast.pop,
        rain: forecast.rain != null
            ? RainModel(threeHour: forecast.rain!.threeHour)
            : null,
        sys: forecast.sys != null ? SysModel(pod: forecast.sys!.pod) : null,
        dtTxt: forecast.dtTxt,
      ).toJson();
    }).toList();

    await _sharedPreferencesService.setString(
      key: forecastsKey,
      value: jsonEncode(forecastsJson),
    );

    await _sharedPreferencesService.setInt(
      key: lastUpdatedKey,
      value: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
