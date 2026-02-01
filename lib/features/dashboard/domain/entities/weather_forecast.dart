import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_forecast.freezed.dart';

@freezed
class WeatherForecast with _$WeatherForecast {
  const factory WeatherForecast({
    int? dt,
    MainData? main,
    List<WeatherData>? weather,
    Clouds? clouds,
    Wind? wind,
    int? visibility,
    double? pop,
    Rain? rain,
    Sys? sys,
    String? dtTxt,
  }) = _WeatherForecast;
}

@freezed
class MainData with _$MainData {
  const factory MainData({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? seaLevel,
    int? grndLevel,
    int? humidity,
    double? tempKf,
  }) = _MainData;
}

@freezed
class WeatherData with _$WeatherData {
  const factory WeatherData({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) = _WeatherData;
}

@freezed
class Clouds with _$Clouds {
  const factory Clouds({int? all}) = _Clouds;
}

@freezed
class Wind with _$Wind {
  const factory Wind({double? speed, int? deg, double? gust}) = _Wind;
}

@freezed
class Rain with _$Rain {
  const factory Rain({double? threeHour}) = _Rain;
}

@freezed
class Sys with _$Sys {
  const factory Sys({String? pod}) = _Sys;
}

@freezed
class WeatherForecastResponse with _$WeatherForecastResponse {
  const factory WeatherForecastResponse({
    String? cod,
    int? message,
    int? cnt,
    List<WeatherForecast>? list,
    City? city,
  }) = _WeatherForecastResponse;
}

@freezed
class City with _$City {
  const factory City({
    int? id,
    String? name,
    Coord? coord,
    String? country,
    int? population,
    int? timezone,
    int? sunrise,
    int? sunset,
  }) = _City;
}

@freezed
class Coord with _$Coord {
  const factory Coord({double? lat, double? lon}) = _Coord;
}
