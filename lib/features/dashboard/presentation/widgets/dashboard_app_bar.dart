import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/weather_forecast.dart';
import 'weather_detail_widget.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({
    super.key,
    required this.isCollapsed,
    this.city,
    this.currentForecast,
    this.lastUpdated,
  });

  final bool isCollapsed;
  final City? city;
  final WeatherForecast? currentForecast;
  final DateTime? lastUpdated;

  IconData _getWeatherIcon(String? main) {
    switch (main) {
      case 'Clear':
        return Icons.wb_sunny;
      case 'Clouds':
        return Icons.cloud;
      case 'Rain':
        return Icons.grain;
      case 'Snow':
        return Icons.ac_unit;
      case 'Thunderstorm':
        return Icons.flash_on;
      case 'Drizzle':
        return Icons.grain;
      case 'Mist':
      case 'Fog':
      case 'Haze':
        return Icons.blur_on;
      default:
        return Icons.wb_sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherMain = currentForecast?.weather?.firstOrNull?.main;
    final weatherIcon = _getWeatherIcon(weatherMain);
    return SliverAppBar(
      expandedHeight: AppDimensions.height367,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: Icon(Icons.menu, color: AppColors.white),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: isCollapsed
          ? Row(
              children: [
                Icon(
                  weatherIcon,
                  color: AppColors.secondary,
                  size: AppDimensions.style24,
                ),
                SizedBox(width: AppDimensions.width8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${city?.name ?? context.loc.unknown}, ${city?.country ?? ''}',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppDimensions.style16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${currentForecast?.weather?.firstOrNull?.description ?? context.loc.unknown} • ${currentForecast?.main?.temp != null ? '${currentForecast!.main!.temp!.toStringAsFixed(1)}°C' : context.loc.notAvailable}',
                      style: TextStyle(
                        color: AppColors.grey200,
                        fontSize: AppDimensions.style12,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: AppDimensions.width16,
                right: AppDimensions.width16,
                top: AppDimensions.height16,
                bottom: AppDimensions.height80,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (lastUpdated != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: AppDimensions.height8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sync,
                            size: AppDimensions.style14,
                            color: AppColors.white,
                          ),
                          SizedBox(width: AppDimensions.width5),
                          Text(
                            '${context.loc.lastUpdated} ${lastUpdated!.toSyncTime()}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: AppDimensions.style12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Icon(
                    weatherIcon,
                    size: AppDimensions.style60,
                    color: AppColors.secondary,
                  ),
                  SizedBox(width: AppDimensions.height16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${city?.name ?? context.loc.unknown}, ${city?.country ?? ''}',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: AppDimensions.style20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currentForecast?.weather?.firstOrNull?.description
                                      ?.toTitleCase() ??
                                  context.loc.unknown,
                              style: TextStyle(
                                color: AppColors.grey200,
                                fontSize: AppDimensions.style16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            currentForecast?.main?.temp != null
                                ? '${currentForecast!.main!.temp!.toStringAsFixed(1)}°C'
                                : context.loc.notAvailable,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: AppDimensions.style48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            currentForecast?.main?.feelsLike != null
                                ? '${context.loc.feelsLike} ${currentForecast!.main!.feelsLike!.toStringAsFixed(1)}°C'
                                : context.loc.notAvailable,
                            style: TextStyle(
                              color: AppColors.grey200,
                              fontSize: AppDimensions.style12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.height10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WeatherDetailWidget(
                        icon: Icons.water_drop,
                        label: context.loc.humidity,
                        value: currentForecast?.main?.humidity != null
                            ? '${currentForecast!.main!.humidity}%'
                            : context.loc.notAvailable,
                      ),
                      WeatherDetailWidget(
                        icon: Icons.air,
                        label: context.loc.wind,
                        value: currentForecast?.wind?.speed != null
                            ? '${currentForecast!.wind!.speed} km/h'
                            : context.loc.notAvailable,
                      ),
                      WeatherDetailWidget(
                        icon: Icons.visibility,
                        label: context.loc.visibility,
                        value: currentForecast?.visibility != null
                            ? '${currentForecast!.visibility} km'
                            : context.loc.notAvailable,
                      ),
                      WeatherDetailWidget(
                        icon: Icons.compress,
                        label: context.loc.pressure,
                        value: currentForecast?.main?.pressure != null
                            ? '${currentForecast!.main!.pressure} hPa'
                            : context.loc.notAvailable,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
