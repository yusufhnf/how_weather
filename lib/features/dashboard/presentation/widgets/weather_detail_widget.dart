import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class WeatherDetailWidget extends StatelessWidget {
  const WeatherDetailWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: AppDimensions.style20),
        SizedBox(height: AppDimensions.height5),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: AppDimensions.style12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: AppDimensions.style10,
          ),
        ),
      ],
    );
  }
}
