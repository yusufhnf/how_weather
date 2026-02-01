import 'package:flutter/material.dart';

abstract class I18n {
  // App Info
  String get appName;

  // Common Actions
  String get loading;
  String get error;
  String get retry;
  String get cancel;
  String get ok;
  String get yes;
  String get no;
  String get save;
  String get delete;
  String get edit;
  String get search;
  String get settings;
  String get about;

  // Auth
  String get logout;
  String get login;
  String get register;
  String get email;
  String get password;
  String get confirmPassword;
  String get forgotPassword;
  String get loginTitle;
  String get welcomeBack;
  String get signInToContinue;
  String get loginHint;

  // Messages
  String get noDataAvailable;
  String get somethingWentWrong;
  String get networkError;
  String get serverError;
  String get unknownError;
  String loginSuccess(String name);

  // Weather
  String get lastUpdated;
  String get feelsLike;
  String get humidity;
  String get wind;
  String get visibility;
  String get pressure;
  String get unknown;
  String get notAvailable;
  String errorLoadingForecast(String message);

  // Validation Messages
  String get emailRequired;
  String get emailInvalid;
  String get passwordRequired;
  String passwordMinLength(int length);
  String fieldRequired(String fieldName);
  String fieldMinLength(String fieldName, int length);
  String fieldMaxLength(String fieldName, int length);
  String get phoneNumberRequired;
  String get phoneNumberInvalid;
  String get urlRequired;
  String get urlInvalid;
  String fieldNotMatch(String fieldName);
  String fieldMustBeNumber(String fieldName);
  String fieldMustBeLetters(String fieldName);
  String fieldMustBeAlphanumeric(String fieldName);
}

class I18nEn implements I18n {
  const I18nEn();

  @override
  String get appName => 'How Weather';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get search => 'Search';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get logout => 'Logout';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get loginTitle => 'Login How Weather';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get loginHint => 'Hint: admin@meetucup.com / admin1234';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get networkError => 'Network error occurred';

  @override
  String get serverError => 'Server error occurred';

  @override
  String get unknownError => 'Unknown error occurred';

  @override
  String loginSuccess(String name) => 'Login successful! Welcome $name';

  @override
  String get lastUpdated => 'Last updated:';

  @override
  String get feelsLike => 'Feels like';

  @override
  String get humidity => 'Humidity';

  @override
  String get wind => 'Wind';

  @override
  String get visibility => 'Visibility';

  @override
  String get pressure => 'Pressure';

  @override
  String get unknown => 'Unknown';

  @override
  String get notAvailable => 'N/A';

  @override
  String errorLoadingForecast(String message) =>
      'Error loading forecast: $message';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Please enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String passwordMinLength(int length) =>
      'Password must be at least $length characters';

  @override
  String fieldRequired(String fieldName) => '$fieldName is required';

  @override
  String fieldMinLength(String fieldName, int length) =>
      '$fieldName must be at least $length characters';

  @override
  String fieldMaxLength(String fieldName, int length) =>
      '$fieldName must not exceed $length characters';

  @override
  String get phoneNumberRequired => 'Phone number is required';

  @override
  String get phoneNumberInvalid => 'Please enter a valid phone number';

  @override
  String get urlRequired => 'URL is required';

  @override
  String get urlInvalid => 'Please enter a valid URL';

  @override
  String fieldNotMatch(String fieldName) => '$fieldName does not match';

  @override
  String fieldMustBeNumber(String fieldName) => '$fieldName must be a number';

  @override
  String fieldMustBeLetters(String fieldName) =>
      '$fieldName must contain only letters';

  @override
  String fieldMustBeAlphanumeric(String fieldName) =>
      '$fieldName must contain only letters and numbers';
}

class I18nId implements I18n {
  const I18nId();

  @override
  String get appName => 'How Weather';

  @override
  String get loading => 'Memuat...';

  @override
  String get error => 'Kesalahan';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get cancel => 'Batal';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Ya';

  @override
  String get no => 'Tidak';

  @override
  String get save => 'Simpan';

  @override
  String get delete => 'Hapus';

  @override
  String get edit => 'Ubah';

  @override
  String get search => 'Cari';

  @override
  String get settings => 'Pengaturan';

  @override
  String get about => 'Tentang';

  @override
  String get logout => 'Keluar';

  @override
  String get login => 'Masuk';

  @override
  String get register => 'Daftar';

  @override
  String get email => 'Email';

  @override
  String get password => 'Kata Sandi';

  @override
  String get confirmPassword => 'Konfirmasi Kata Sandi';

  @override
  String get forgotPassword => 'Lupa Kata Sandi?';

  @override
  String get loginTitle => 'Masuk How Weather';

  @override
  String get welcomeBack => 'Selamat Datang Kembali';

  @override
  String get signInToContinue => 'Masuk untuk melanjutkan';

  @override
  String get loginHint => 'Petunjuk: admin@meetucup.com / admin1234';

  @override
  String get noDataAvailable => 'Tidak ada data tersedia';

  @override
  String get somethingWentWrong => 'Terjadi kesalahan';

  @override
  String get networkError => 'Terjadi kesalahan jaringan';

  @override
  String get serverError => 'Terjadi kesalahan server';

  @override
  String get unknownError => 'Terjadi kesalahan yang tidak diketahui';

  @override
  String loginSuccess(String name) => 'Login berhasil! Selamat datang $name';

  @override
  String get lastUpdated => 'Terakhir diperbarui:';

  @override
  String get feelsLike => 'Terasa seperti';

  @override
  String get humidity => 'Kelembaban';

  @override
  String get wind => 'Angin';

  @override
  String get visibility => 'Visibilitas';

  @override
  String get pressure => 'Tekanan';

  @override
  String get unknown => 'Tidak diketahui';

  @override
  String get notAvailable => 'N/A';

  @override
  String errorLoadingForecast(String message) =>
      'Kesalahan memuat prakiraan: $message';

  @override
  String get emailRequired => 'Email wajib diisi';

  @override
  String get emailInvalid => 'Masukkan email yang valid';

  @override
  String get passwordRequired => 'Kata sandi wajib diisi';

  @override
  String passwordMinLength(int length) => 'Kata sandi minimal $length karakter';

  @override
  String fieldRequired(String fieldName) => '$fieldName wajib diisi';

  @override
  String fieldMinLength(String fieldName, int length) =>
      '$fieldName minimal $length karakter';

  @override
  String fieldMaxLength(String fieldName, int length) =>
      '$fieldName maksimal $length karakter';

  @override
  String get phoneNumberRequired => 'Nomor telepon wajib diisi';

  @override
  String get phoneNumberInvalid => 'Masukkan nomor telepon yang valid';

  @override
  String get urlRequired => 'URL wajib diisi';

  @override
  String get urlInvalid => 'Masukkan URL yang valid';

  @override
  String fieldNotMatch(String fieldName) => '$fieldName tidak cocok';

  @override
  String fieldMustBeNumber(String fieldName) => '$fieldName harus berupa angka';

  @override
  String fieldMustBeLetters(String fieldName) =>
      '$fieldName hanya boleh berisi huruf';

  @override
  String fieldMustBeAlphanumeric(String fieldName) =>
      '$fieldName hanya boleh berisi huruf dan angka';
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static I18n of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'id') {
      return const I18nId();
    }
    return const I18nEn();
  }

  // For backward compatibility and global access
  static I18n get loc {
    // Default to English for global access
    return const I18nEn();
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('id', 'ID'),
  ];

  @override
  bool isSupported(Locale locale) =>
      supportedLocales.any((l) => l.languageCode == locale.languageCode);

  @override
  Future<I18n> load(Locale locale) async {
    if (locale.languageCode == 'id') {
      return const I18nId();
    }
    return const I18nEn();
  }

  @override
  bool shouldReload(I18nDelegate old) => false;
}
