import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../constants/string_constants.dart';
import 'shared_preferences_service.dart';

abstract class AppSettingsService {
  Future<void> saveThemeMode(ThemeMode themeMode);
  Future<ThemeMode?> getThemeMode();
  Future<void> saveLocale(Locale locale);
  Future<Locale?> getLocale();
}

@LazySingleton(as: AppSettingsService)
class AppSettingsServiceImpl implements AppSettingsService {
  final SharedPreferencesService _sharedPreferencesService;

  AppSettingsServiceImpl(this._sharedPreferencesService);

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _sharedPreferencesService.setInt(
      key: StringConstants.themeModeKey,
      value: themeMode.index,
    );
  }

  @override
  Future<ThemeMode?> getThemeMode() async {
    final themeModeIndex = await _sharedPreferencesService.getInt(
      key: StringConstants.themeModeKey,
    );
    if (themeModeIndex != null) {
      return ThemeMode.values[themeModeIndex];
    }
    return null;
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await _sharedPreferencesService.setString(
      key: StringConstants.localeKey,
      value: '${locale.languageCode}_${locale.countryCode}',
    );
  }

  @override
  Future<Locale?> getLocale() async {
    final localeString = await _sharedPreferencesService.getString(
      key: StringConstants.localeKey,
    );
    if (localeString != null) {
      final parts = localeString.split('_');
      if (parts.length == 2) {
        return Locale(parts[0], parts[1]);
      }
    }
    return null;
  }
}
