import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/weather_forecast.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({
    super.key,
    required this.forecast,
  });

  final WeatherForecast forecast;

  @override
  Widget build(BuildContext context) {
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