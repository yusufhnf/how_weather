import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_forecast_query_params.freezed.dart';

@freezed
class WeatherForecastQueryParams with _$WeatherForecastQueryParams {
  const factory WeatherForecastQueryParams({
    required double lat,
    required double lon,
    required String appid,
    @Default('metric') String? units,
    int? cnt,
  }) = _WeatherForecastQueryParams;

  const WeatherForecastQueryParams._();

  factory WeatherForecastQueryParams.fromMap(Map<String, dynamic> map) {
    return WeatherForecastQueryParams(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      appid: map['appid'] as String,
      units: map['units'] as String? ?? 'metric',
      cnt: map['cnt'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': appid,
      'units': units,
      if (cnt != null) 'cnt': cnt.toString(),
    };
  }
}
