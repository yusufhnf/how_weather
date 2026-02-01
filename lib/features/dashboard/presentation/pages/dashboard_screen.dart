import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/core.dart';
import '../../domain/entities/weather_forecast.dart';
import '../cubit/dashboard_cubit.dart';
import '../widgets/dashboard_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  late VoidCallback _onScrollCallback;
  bool _listenerAdded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_listenerAdded) {
      _scrollController.removeListener(_onScrollCallback);
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final isCollapsed = state.isCollapsed;
          if (!_listenerAdded) {
            _onScrollCallback = () {
              context.read<DashboardCubit>().updateScrollPosition(
                _scrollController,
                AppDimensions.height300,
              );
            };
            _scrollController.addListener(_onScrollCallback);
            _listenerAdded = true;
          }
          final city = state.maybeWhen(
            forecastLoaded: (_, __, city, ___) => city,
            orElse: () => null,
          );
          final currentForecast = state.maybeWhen(
            forecastLoaded: (_, forecasts, __, ___) =>
                forecasts.isNotEmpty ? forecasts[0] : null,
            orElse: () => null,
          );
          final lastUpdated = state.maybeWhen(
            forecastLoaded: (_, __, ___, lastUpdated) => lastUpdated,
            orElse: () => null,
          );
          return Scaffold(
            body: CustomRefreshIndicator(
              onRefresh: () async {
                context.read<DashboardCubit>().refreshForecast();
              },
              builder: (context, child, controller) {
                return Stack(
                  children: [
                    AnimatedBuilder(
                      animation: controller,
                      builder: (context, _) {
                        return Transform.translate(
                          offset: Offset(
                            0,
                            controller.value * AppDimensions.height100,
                          ),
                          child: child,
                        );
                      },
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, _) {
                          return Container(
                            height: controller.value * AppDimensions.height100,
                            alignment: Alignment.center,
                            color: AppColors.primary,
                            child: controller.value > 0
                                ? Opacity(
                                    opacity: controller.value.clamp(0.0, 1.0),
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.white,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  DashboardAppBar(
                    isCollapsed: isCollapsed,
                    city: city,
                    currentForecast: currentForecast,
                    lastUpdated: lastUpdated,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(AppDimensions.width16),
                    sliver: BlocBuilder<DashboardCubit, DashboardState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          forecastLoading: (_) => SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                    padding: EdgeInsets.all(
                                      AppDimensions.width8,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          ),
                          forecastLoaded: (_, forecasts, __, ___) => SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: AppDimensions.height16,
                                  crossAxisSpacing: AppDimensions.width16,
                                  childAspectRatio: 3 / 2,
                                ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index >= forecasts.length) {
                                  return SizedBox.shrink();
                                }
                                final forecast = forecasts[index];
                                return _buildForecastCard(forecast);
                              },
                              childCount: forecasts.length > 20
                                  ? 20
                                  : forecasts.length,
                            ),
                          ),
                          forecastError: (_, message) => SliverToBoxAdapter(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(AppDimensions.width16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context.loc.errorLoadingForecast(
                                        message.message,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: AppColors.error),
                                    ),
                                    SizedBox(height: AppDimensions.height16),
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<DashboardCubit>()
                                            .refreshForecast();
                                      },
                                      child: Text(context.loc.retry),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          orElse: () => SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                    padding: EdgeInsets.all(
                                      AppDimensions.width8,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForecastCard(WeatherForecast forecast) {
    final dateTime = forecast.dt != null
        ? DateTime.fromMillisecondsSinceEpoch(forecast.dt! * 1000)
        : DateTime.now();
    final time = DateFormat('HH:mm').format(dateTime);
    final temp = forecast.main?.temp != null
        ? '${forecast.main!.temp!.toStringAsFixed(1)}°C'
        : context.loc.notAvailable;
    final description = forecast.weather?.isNotEmpty == true
        ? forecast.weather!.first.description?.toTitleCase() ??
              context.loc.unknown
        : context.loc.unknown;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.width8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: AppDimensions.style14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.height5),
            // You can add weather icon here if you have assets
            // Image.asset('assets/weather/$icon.png', height: 32),
            Text(
              temp,
              style: TextStyle(
                fontSize: AppDimensions.style18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.height5),
            Text(
              description,
              style: TextStyle(fontSize: AppDimensions.style12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
