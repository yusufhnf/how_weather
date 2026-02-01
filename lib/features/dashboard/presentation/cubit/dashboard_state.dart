part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _DashboardInitial;
  const factory DashboardState.scrollChanged({required bool isCollapsed}) =
      _DashboardScrollChanged;
  const factory DashboardState.forecastLoading() = _DashboardForecastLoading;
  const factory DashboardState.forecastLoaded({
    required List<WeatherForecast> forecasts,
  }) = _DashboardForecastLoaded;
  const factory DashboardState.forecastError({required String message}) =
      _DashboardForecastError;
}
