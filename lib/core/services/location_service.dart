import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../exceptions/app_exceptions.dart';

@lazySingleton
class LocationService {
  Future<Either<AppException, Position>> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Left(LocationException('Location services are disabled'));
      }

      // Check permission status
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Left(LocationException('Location permission denied'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permission is permanently denied, open app settings
        await openAppSettings();
        return Left(
          LocationException(
            'Location permission permanently denied. Please enable in settings.',
          ),
        );
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      return Right(position);
    } catch (e) {
      return Left(LocationException('Failed to get location: ${e.toString()}'));
    }
  }
}
