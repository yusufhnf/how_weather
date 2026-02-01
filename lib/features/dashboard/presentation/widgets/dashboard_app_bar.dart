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
  });

  final bool isCollapsed;
  final City? city;
  final WeatherForecast? currentForecast;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: AppDimensions.height300,
      floating: false,
      pinned: true,
      title: isCollapsed
          ? Row(
              children: [
                Icon(
                  Icons.wb_sunny,
                  color: const Color.fromARGB(255, 37, 36, 21),
                  size: AppDimensions.style24,
                ),
                SizedBox(width: AppDimensions.width8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${city?.name ?? 'Unknown'}, ${city?.country ?? ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppDimensions.style16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${currentForecast?.weather?.firstOrNull?.description ?? 'Unknown'} • ${currentForecast?.main?.temp != null ? '${currentForecast!.main!.temp!.toStringAsFixed(1)}°C' : 'N/A'}',
                      style: TextStyle(
                        color: Colors.white70,
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
              colors: [Colors.blue.shade400, Colors.blue.shade600],
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        size: AppDimensions.style60,
                        color: Colors.yellow.shade300,
                      ),
                      SizedBox(width: AppDimensions.width16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${city?.name ?? 'Unknown'}, ${city?.country ?? ''}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppDimensions.style20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currentForecast?.weather?.firstOrNull?.description
                                      ?.toTitleCase() ??
                                  'Unknown',
                              style: TextStyle(
                                color: Colors.white70,
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
                                : 'N/A',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppDimensions.style48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            currentForecast?.main?.feelsLike != null
                                ? 'Feels like ${currentForecast!.main!.feelsLike!.toStringAsFixed(1)}°C'
                                : 'N/A',
                            style: TextStyle(
                              color: Colors.white70,
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
                        label: 'Humidity',
                        value: currentForecast?.main?.humidity != null
                            ? '${currentForecast!.main!.humidity}%'
                            : 'N/A',
                      ),
                      WeatherDetailWidget(
                        icon: Icons.air,
                        label: 'Wind',
                        value: currentForecast?.wind?.speed != null
                            ? '${currentForecast!.wind!.speed} km/h'
                            : 'N/A',
                      ),
                      WeatherDetailWidget(
                        icon: Icons.visibility,
                        label: 'Visibility',
                        value: currentForecast?.visibility != null
                            ? '${currentForecast!.visibility} km'
                            : 'N/A',
                      ),
                      WeatherDetailWidget(
                        icon: Icons.compress,
                        label: 'Pressure',
                        value: currentForecast?.main?.pressure != null
                            ? '${currentForecast!.main!.pressure} hPa'
                            : 'N/A',
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
