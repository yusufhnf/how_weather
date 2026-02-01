import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/weather_forecast.dart';
import '../../domain/usecases/get_weather_forecast_usecase.dart';

part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final GetWeatherForecastUseCase _getWeatherForecastUseCase;
  final LocationService _locationService;

  DashboardCubit(this._getWeatherForecastUseCase, this._locationService)
    : super(DashboardState.initial()) {
    _loadWeatherForecast();
  }

  Future<void> _loadWeatherForecast() async {
    emit(DashboardState.forecastLoading());

    final locationResult = await _locationService.getCurrentLocation();

    await locationResult.fold(
      (error) async {
        emit(DashboardState.forecastError(message: error.message));
      },
      (position) async {
        final forecastResult = await _getWeatherForecastUseCase(
          lat: position.latitude,
          lon: position.longitude,
        );

        forecastResult.fold(
          (error) {
            emit(DashboardState.forecastError(message: error.message));
          },
          (response) {
            emit(DashboardState.forecastLoaded(forecasts: response.list ?? []));
          },
        );
      },
    );
  }

  void updateScrollPosition(
    ScrollController controller,
    double expandedHeight,
  ) {
    final isCollapsed =
        controller.hasClients &&
        controller.offset > (expandedHeight - kToolbarHeight);

    // Only emit new state if the collapsed state has changed
    final currentIsCollapsed = state.maybeWhen(
      scrollChanged: (isCollapsed) => isCollapsed,
      orElse: () => false,
    );

    if (isCollapsed != currentIsCollapsed) {
      emit(DashboardState.scrollChanged(isCollapsed: isCollapsed));
    }
  }

  void refreshForecast() {
    _loadWeatherForecast();
  }
}
