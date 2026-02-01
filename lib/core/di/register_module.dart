import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Talker get talker => Talker();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  InternetConnection get internetConnection => InternetConnection();

  @preResolve
  Future<Box<dynamic>> get hive async => Hive.box('howWeatherBox');

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
