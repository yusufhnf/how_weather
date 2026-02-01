import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
      child: BlocSelector<DashboardCubit, DashboardState, bool>(
        selector: (state) => state.maybeWhen(
          scrollChanged: (isCollapsed) => isCollapsed,
          orElse: () => false,
        ),
        builder: (context, isCollapsed) {
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
          return Scaffold(
            body: CustomScrollView(
              controller: _scrollController,
              slivers: [
                DashboardAppBar(isCollapsed: isCollapsed),
                SliverPadding(
                  padding: EdgeInsets.all(AppDimensions.width16),
                  sliver: BlocBuilder<DashboardCubit, DashboardState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        forecastLoading: () => SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: AppDimensions.height16,
                                crossAxisSpacing: AppDimensions.width16,
                                childAspectRatio: 3 / 2,
                              ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => Card(
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            childCount: 20,
                          ),
                        ),
                        forecastLoaded: (forecasts) => SliverGrid(
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
                        forecastError: (message) => SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(AppDimensions.width16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Error loading forecast: $message',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  SizedBox(height: AppDimensions.height16),
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<DashboardCubit>()
                                          .refreshForecast();
                                    },
                                    child: Text('Retry'),
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
                            (context, index) =>
                                Card(child: Center(child: Text('Loading...'))),
                            childCount: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
        : 'N/A';
    final description = forecast.weather?.isNotEmpty == true
        ? forecast.weather!.first.description ?? 'Unknown'
        : 'Unknown';

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
