import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/weather_forecast.dart';
import '../../domain/repositories/weather_forecast_repository.dart';
import '../../domain/usecases/get_weather_forecast_usecase.dart';

part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final GetWeatherForecastUseCase _getWeatherForecastUseCase;
  final WeatherForecastRepository _repository;
  final LocationService _locationService;

  DashboardCubit({
    required GetWeatherForecastUseCase getWeatherForecastUseCase,
    required WeatherForecastRepository repository,
    required LocationService locationService,
  }) : _getWeatherForecastUseCase = getWeatherForecastUseCase,
       _repository = repository,
       _locationService = locationService,
       super(const DashboardState.initial()) {
    _loadWeatherForecast();
  }

  Future<void> _loadWeatherForecast({bool forceGetFromRemote = false}) async {
    emit(DashboardState.forecastLoading(isCollapsed: state.isCollapsed));

    final locationResult = await _locationService.getCurrentLocation();

    await locationResult.fold(
      (error) async {
        emit(
          DashboardState.forecastError(
            message: error,
            isCollapsed: state.isCollapsed,
          ),
        );
      },
      (position) async {
        final forecastResult = await _getWeatherForecastUseCase(
          lat: position.latitude,
          lon: position.longitude,
          forceGetFromRemote: forceGetFromRemote,
        );

        forecastResult.fold(
          (error) {
            emit(
              DashboardState.forecastError(
                message: error,
                isCollapsed: state.isCollapsed,
              ),
            );
          },
          (response) async {
            final lastUpdated = await _repository.getLastUpdated();
            emit(
              DashboardState.forecastLoaded(
                forecasts: response.list ?? [],
                city: response.city,
                lastUpdated: lastUpdated,
                isCollapsed: state.isCollapsed,
              ),
            );
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
    final currentIsCollapsed = state.isCollapsed;

    if (isCollapsed != currentIsCollapsed) {
      emit(state.copyWith(isCollapsed: isCollapsed));
    }
  }

  void refreshForecast() {
    _loadWeatherForecast(forceGetFromRemote: true);
  }
}
