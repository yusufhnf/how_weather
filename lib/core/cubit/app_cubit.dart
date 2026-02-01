import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../services/app_settings_service.dart';
import '../../features/login/domain/entities/user_entity.dart';
import '../../features/login/domain/repositories/user_session_repository.dart';
import 'app_state.dart';

@singleton
class AppCubit extends Cubit<AppState> {
  final UserSessionRepository _userSessionRepository;
  final AppSettingsService _appSettingsService;

  AppCubit({
    required UserSessionRepository userSessionRepository,
    required AppSettingsService appSettingsService,
  }) : _userSessionRepository = userSessionRepository,
       _appSettingsService = appSettingsService,
       super(const AppState());

  Future<void> init() async {
    await _loadTheme();
    await _loadLocale();
    await _loadUserLogged();
  }

  Future<void> _loadTheme() async {
    final themeMode = await _appSettingsService.getThemeMode();
    if (themeMode != null) {
      emit(state.copyWith(themeMode: themeMode));
    }
  }

  Future<void> _loadLocale() async {
    final locale = await _appSettingsService.getLocale();
    if (locale != null) {
      emit(state.copyWith(locale: locale));
    }
  }

  Future<void> _loadUserLogged() async {
    final user = await _userSessionRepository.getUser();
    if (user != null) {
      emit(state.copyWith(userLogged: user));
    }
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    emit(state.copyWith(themeMode: themeMode));
    await _appSettingsService.saveThemeMode(themeMode);
  }

  Future<void> changeLocale(Locale locale) async {
    emit(state.copyWith(locale: locale));
    await _appSettingsService.saveLocale(locale);
  }

  Future<void> login(UserEntity user) async {
    await _userSessionRepository.saveUser(user);
    emit(state.copyWith(userLogged: user));
  }

  Future<void> logout() async {
    await _userSessionRepository.clearUser();
    emit(state.copyWith(userLogged: null));
  }

  bool get isLightTheme => state.themeMode == ThemeMode.light;
  bool get isDarkTheme => state.themeMode == ThemeMode.dark;
  bool get isSystemTheme => state.themeMode == ThemeMode.system;
}
