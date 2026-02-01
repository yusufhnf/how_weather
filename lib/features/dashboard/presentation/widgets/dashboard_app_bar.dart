import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import 'weather_detail_widget.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key, required this.isCollapsed});

  final bool isCollapsed;

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
                  color: Colors.yellow.shade300,
                  size: AppDimensions.style24,
                ),
                SizedBox(width: AppDimensions.width8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jakarta, Indonesia',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppDimensions.style16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Clear Sky • 28°C',
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
                    children: [
                      Icon(
                        Icons.push_pin,
                        color: Colors.white,
                        size: AppDimensions.style24,
                      ),
                      SizedBox(width: AppDimensions.width8),
                      Text(
                        'Pinned Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppDimensions.style14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.height8),
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
                              'Jakarta, Indonesia',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppDimensions.style20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Clear Sky',
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
                            '28°C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppDimensions.style48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Feels like 32°C',
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
                        value: '65%',
                      ),
                      WeatherDetailWidget(
                        icon: Icons.air,
                        label: 'Wind',
                        value: '12 km/h',
                      ),
                      WeatherDetailWidget(
                        icon: Icons.visibility,
                        label: 'Visibility',
                        value: '10 km',
                      ),
                      WeatherDetailWidget(
                        icon: Icons.compress,
                        label: 'Pressure',
                        value: '1013 hPa',
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
