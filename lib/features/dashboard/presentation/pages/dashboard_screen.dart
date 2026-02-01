import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

import '../../../../core/core.dart';
import '../cubit/dashboard_cubit.dart';
import '../widgets/dashboard_app_bar.dart';
import '../widgets/forecast_grid.dart';

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
                  ForecastGrid(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
