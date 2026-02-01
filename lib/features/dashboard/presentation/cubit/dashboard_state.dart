part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial({@Default(false) bool isCollapsed}) =
      _DashboardInitial;
  const factory DashboardState.forecastLoading({
    @Default(false) bool isCollapsed,
  }) = _DashboardForecastLoading;
  const factory DashboardState.forecastLoaded({
    @Default(false) bool isCollapsed,
    required List<WeatherForecast> forecasts,
    City? city,
  }) = _DashboardForecastLoaded;
  const factory DashboardState.forecastError({
    @Default(false) bool isCollapsed,
    required AppException message,
  }) = _DashboardForecastError;
}
