import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:talker/talker.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Talker get talker => Talker();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  InternetConnection get internetConnection => InternetConnection();

  @preResolve
  @lazySingleton
  Future<HiveInterface> get hive async {
    return Hive;
  }

  @Named('openWeatherAPI')
  Dio dio() => Dio(
    BaseOptions(
      baseUrl: 'https://api.openweathermap.org',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );
}
