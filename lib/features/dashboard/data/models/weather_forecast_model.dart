import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/weather_forecast.dart';

part 'weather_forecast_model.freezed.dart';
part 'weather_forecast_model.g.dart';

@freezed
class WeatherForecastModel with _$WeatherForecastModel {
  const factory WeatherForecastModel({
    int? dt,
    MainDataModel? main,
    List<WeatherDataModel>? weather,
    CloudsModel? clouds,
    WindModel? wind,
    int? visibility,
    double? pop,
    RainModel? rain,
    SysModel? sys,
    @JsonKey(name: 'dt_txt') String? dtTxt,
  }) = _WeatherForecastModel;

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastModelFromJson(json);
}

@freezed
class MainDataModel with _$MainDataModel {
  const factory MainDataModel({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? seaLevel,
    int? grndLevel,
    int? humidity,
    double? tempKf,
  }) = _MainDataModel;

  factory MainDataModel.fromJson(Map<String, dynamic> json) =>
      _$MainDataModelFromJson(json);
}

@freezed
class WeatherDataModel with _$WeatherDataModel {
  const factory WeatherDataModel({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) = _WeatherDataModel;

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataModelFromJson(json);
}

@freezed
class CloudsModel with _$CloudsModel {
  const factory CloudsModel({int? all}) = _CloudsModel;

  factory CloudsModel.fromJson(Map<String, dynamic> json) =>
      _$CloudsModelFromJson(json);
}

@freezed
class WindModel with _$WindModel {
  const factory WindModel({double? speed, int? deg, double? gust}) = _WindModel;

  factory WindModel.fromJson(Map<String, dynamic> json) =>
      _$WindModelFromJson(json);
}

@freezed
class RainModel with _$RainModel {
  const factory RainModel({@JsonKey(name: '3h') double? threeHour}) =
      _RainModel;

  factory RainModel.fromJson(Map<String, dynamic> json) =>
      _$RainModelFromJson(json);
}

@freezed
class SysModel with _$SysModel {
  const factory SysModel({String? pod}) = _SysModel;

  factory SysModel.fromJson(Map<String, dynamic> json) =>
      _$SysModelFromJson(json);
}

@freezed
class WeatherForecastResponseModel with _$WeatherForecastResponseModel {
  const factory WeatherForecastResponseModel({
    String? cod,
    int? message,
    int? cnt,
    List<WeatherForecastModel>? list,
    CityModel? city,
  }) = _WeatherForecastResponseModel;

  factory WeatherForecastResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastResponseModelFromJson(json);
}

@freezed
class CityModel with _$CityModel {
  const factory CityModel({
    int? id,
    String? name,
    CoordModel? coord,
    String? country,
    int? population,
    int? timezone,
    int? sunrise,
    int? sunset,
  }) = _CityModel;

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
}

@freezed
class CoordModel with _$CoordModel {
  const factory CoordModel({double? lat, double? lon}) = _CoordModel;

  factory CoordModel.fromJson(Map<String, dynamic> json) =>
      _$CoordModelFromJson(json);
}

// Mappers
extension WeatherForecastModelX on WeatherForecastModel {
  WeatherForecast toEntity() {
    return WeatherForecast(
      dt: dt,
      main: main?.toEntity(),
      weather: weather?.map((e) => e.toEntity()).toList(),
      clouds: clouds?.toEntity(),
      wind: wind?.toEntity(),
      visibility: visibility,
      pop: pop,
      rain: rain?.toEntity(),
      sys: sys?.toEntity(),
      dtTxt: dtTxt,
    );
  }
}

extension MainDataModelX on MainDataModel {
  MainData toEntity() {
    return MainData(
      temp: temp,
      feelsLike: feelsLike,
      tempMin: tempMin,
      tempMax: tempMax,
      pressure: pressure,
      seaLevel: seaLevel,
      grndLevel: grndLevel,
      humidity: humidity,
      tempKf: tempKf,
    );
  }
}

extension WeatherDataModelX on WeatherDataModel {
  WeatherData toEntity() {
    return WeatherData(
      id: id,
      main: main,
      description: description,
      icon: icon,
    );
  }
}

extension CloudsModelX on CloudsModel {
  Clouds toEntity() {
    return Clouds(all: all);
  }
}

extension WindModelX on WindModel {
  Wind toEntity() {
    return Wind(speed: speed, deg: deg, gust: gust);
  }
}

extension RainModelX on RainModel {
  Rain toEntity() {
    return Rain(threeHour: threeHour);
  }
}

extension SysModelX on SysModel {
  Sys toEntity() {
    return Sys(pod: pod);
  }
}

extension WeatherForecastResponseModelX on WeatherForecastResponseModel {
  WeatherForecastResponse toEntity() {
    return WeatherForecastResponse(
      cod: cod,
      message: message,
      cnt: cnt,
      list: list?.map((e) => e.toEntity()).toList(),
      city: city?.toEntity(),
    );
  }
}

extension CityModelX on CityModel {
  City toEntity() {
    return City(
      id: id,
      name: name,
      coord: coord?.toEntity(),
      country: country,
      population: population,
      timezone: timezone,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}

extension CoordModelX on CoordModel {
  Coord toEntity() {
    return Coord(lat: lat, lon: lon);
  }
}
