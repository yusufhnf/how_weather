import 'package:flutter/material.dart';

class I18n {
  const I18n();

  static String get appName => 'How Weather';
  static String get loading => 'Loading...';
  static String get error => 'Error';
  static String get retry => 'Retry';
  static String get cancel => 'Cancel';
  static String get ok => 'OK';
  static String get yes => 'Yes';
  static String get no => 'No';
  static String get save => 'Save';
  static String get delete => 'Delete';
  static String get edit => 'Edit';
  static String get search => 'Search';
  static String get settings => 'Settings';
  static String get about => 'About';
  static String get logout => 'Logout';
  static String get login => 'Login';
  static String get register => 'Register';
  static String get email => 'Email';
  static String get password => 'Password';
  static String get confirmPassword => 'Confirm Password';
  static String get forgotPassword => 'Forgot Password?';
  static String get noDataAvailable => 'No data available';
  static String get somethingWentWrong => 'Something went wrong';
  static String get networkError => 'Network error occurred';
  static String get serverError => 'Server error occurred';
  static String get unknownError => 'Unknown error occurred';
}

class AppLocalizations {
  static I18n get loc => const I18n();
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static const List<Locale> supportedLocals = [Locale('en', 'US')];

  @override
  bool isSupported(Locale locale) => supportedLocals.contains(locale);

  @override
  Future<I18n> load(Locale locale) async => const I18n();

  @override
  bool shouldReload(I18nDelegate old) => false;
}
