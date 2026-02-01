import 'package:flutter/material.dart';

import '../localization/localization.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  EdgeInsets get viewPadding => mediaQuery.viewPadding;

  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  double get topPadding => viewPadding.top;

  double get bottomPadding => viewPadding.bottom;

  bool get isKeyboardVisible => viewInsets.bottom > 0;

  // Getter for access to localization in the context
  I18n get loc => Localizations.of(this, I18n)!;

  void unfocus() => FocusScope.of(this).unfocus();

  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }
}
