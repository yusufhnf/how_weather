import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/weather_forecast.dart';
import '../cubit/dashboard_cubit.dart';
import 'forecast_card.dart';

class ForecastGrid extends StatelessWidget {
  const ForecastGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(AppDimensions.width16),
      sliver: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return state.maybeWhen(
            forecastLoading: (_) => _buildLoadingGrid(),
            forecastLoaded: (_, forecasts, __, ___) =>
                _buildLoadedGrid(context, forecasts),
            forecastError: (_, message) => _buildErrorView(message, context),
            orElse: () => _buildLoadingGrid(),
          );
        },
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppDimensions.height16,
        crossAxisSpacing: AppDimensions.width16,
        childAspectRatio: 3 / 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => Shimmer.fromColors(
          baseColor: AppColors.grey300,
          highlightColor: AppColors.grey100,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.width8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: AppDimensions.style14,
                    color: AppColors.white,
                  ),
                  SizedBox(height: AppDimensions.height5),
                  Container(
                    height: AppDimensions.style18,
                    color: AppColors.white,
                  ),
                  SizedBox(height: AppDimensions.height5),
                  Container(
                    height: AppDimensions.style12,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        childCount: 6,
      ),
    );
  }

  Widget _buildLoadedGrid(BuildContext context, List<WeatherForecast> forecasts) {
    final displayForecasts = forecasts.length > 20 ? forecasts.sublist(0, 20) : forecasts;

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.width16),
        child: ReorderableGridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppDimensions.height16,
          crossAxisSpacing: AppDimensions.width16,
          childAspectRatio: 3 / 2,
          children: displayForecasts.map((forecast) {
            return ForecastCard(
              key: ValueKey(forecast.dt),
              forecast: forecast,
            );
          }).toList(),
          onReorder: (oldIndex, newIndex) {
            context.read<DashboardCubit>().reorderForecasts(oldIndex, newIndex);
          },
        ),
      ),
    );
  }

  Widget _buildErrorView(AppException message, BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.width16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.loc.errorLoadingForecast(message.message),
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.error),
              ),
              SizedBox(height: AppDimensions.height16),
              ElevatedButton(
                onPressed: () {
                  context.read<DashboardCubit>().refreshForecast();
                },
                child: Text(context.loc.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
