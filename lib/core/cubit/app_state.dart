import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(ThemeMode.light) ThemeMode themeMode,
    @Default(Locale('en', 'US')) Locale locale,
    @Default(false) bool isAuthenticated,
    String? userToken,
    String? userId,
  }) = _AppState;
}
