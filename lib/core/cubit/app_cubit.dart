import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../services/hive_service.dart';
import '../services/secure_storage_service.dart';
import 'app_state.dart';

@lazySingleton
class AppCubit extends Cubit<AppState> {
  final HiveService _hiveService;
  final SecureStorageService _secureStorageService;

  static const String _themeKey = 'theme_mode';
  static const String _localeKey = 'locale';
  static const String _tokenKey = 'user_token';
  static const String _userIdKey = 'user_id';

  AppCubit(this._hiveService, this._secureStorageService)
    : super(const AppState());

  Future<void> init() async {
    await _hiveService.init('app_box');
    await _loadTheme();
    await _loadLocale();
    await _loadAuthState();
  }

  Future<void> _loadTheme() async {
    final themeModeIndex = _hiveService.get<int>(_themeKey);
    if (themeModeIndex != null) {
      final themeMode = ThemeMode.values[themeModeIndex];
      emit(state.copyWith(themeMode: themeMode));
    }
  }

  Future<void> _loadLocale() async {
    final localeString = _hiveService.get<String>(_localeKey);
    if (localeString != null) {
      final parts = localeString.split('_');
      if (parts.length == 2) {
        final locale = Locale(parts[0], parts[1]);
        emit(state.copyWith(locale: locale));
      }
    }
  }

  Future<void> _loadAuthState() async {
    final token = await _secureStorageService.read(key: _tokenKey);
    final userId = await _secureStorageService.read(key: _userIdKey);

    if (token != null && userId != null) {
      emit(
        state.copyWith(isAuthenticated: true, userToken: token, userId: userId),
      );
    }
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    emit(state.copyWith(themeMode: themeMode));
    await _hiveService.put(_themeKey, themeMode.index);
  }

  Future<void> changeLocale(Locale locale) async {
    emit(state.copyWith(locale: locale));
    await _hiveService.put(
      _localeKey,
      '${locale.languageCode}_${locale.countryCode}',
    );
  }

  Future<void> login({required String token, required String userId}) async {
    await _secureStorageService.write(key: _tokenKey, value: token);
    await _secureStorageService.write(key: _userIdKey, value: userId);

    emit(
      state.copyWith(isAuthenticated: true, userToken: token, userId: userId),
    );
  }

  Future<void> logout() async {
    await _secureStorageService.delete(key: _tokenKey);
    await _secureStorageService.delete(key: _userIdKey);

    emit(state.copyWith(isAuthenticated: false, userToken: null, userId: null));
  }

  bool get isLightTheme => state.themeMode == ThemeMode.light;
  bool get isDarkTheme => state.themeMode == ThemeMode.dark;
  bool get isSystemTheme => state.themeMode == ThemeMode.system;
}
