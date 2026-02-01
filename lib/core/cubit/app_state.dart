import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../features/login/domain/entities/user_entity.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(ThemeMode.light) ThemeMode themeMode,
    @Default(Locale('en', 'US')) Locale locale,
    UserEntity? userLogged,
  }) = _AppState;
}
