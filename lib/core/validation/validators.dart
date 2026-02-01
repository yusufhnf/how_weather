import 'package:flutter/material.dart';

import '../localization/localization.dart';

/// Validation utilities for form fields
class Validators {
  Validators._();

  /// Validates email field
  /// Returns error message if invalid, null if valid
  static String? email(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return loc.emailRequired;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return loc.emailInvalid;
    }

    return null;
  }

  /// Validates password field
  /// Returns error message if invalid, null if valid
  /// [minLength] defaults to 8 characters
  static String? password(
    String? value,
    BuildContext context, {
    int minLength = 8,
  }) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return loc.passwordRequired;
    }

    if (value.length < minLength) {
      return loc.passwordMinLength(minLength);
    }

    return null;
  }

  /// Validates required field
  /// Returns error message if empty, null if valid
  static String? required(
    String? value,
    BuildContext context, {
    String fieldName = 'Field',
  }) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return loc.fieldRequired(fieldName);
    }
    return null;
  }

  /// Validates minimum length
  /// Returns error message if too short, null if valid
  static String? minLength(
    String? value,
    int min,
    BuildContext context, {
    String fieldName = 'Field',
  }) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length < min) {
      return loc.fieldMinLength(fieldName, min);
    }

    return null;
  }

  /// Validates maximum length
  /// Returns error message if too long, null if valid
  static String? maxLength(
    String? value,
    int max,
    BuildContext context, {
    String fieldName = 'Field',
  }) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length > max) {
      return loc.fieldMaxLength(fieldName, max);
    }

    return null;
  }

  /// Validates phone number (basic format)
  /// Returns error message if invalid, null if valid
  static String? phoneNumber(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return loc.phoneNumberRequired;
    }

    final phoneRegex = RegExp(r'^\+?[\d\s-()]+$');

    if (!phoneRegex.hasMatch(value)) {
      return loc.phoneNumberInvalid;
    }

    return null;
  }

  /// Validates URL format
  /// Returns error message if invalid, null if valid
  static String? url(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return loc.urlRequired;
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return loc.urlInvalid;
    }

    return null;
  }

  /// Validates that two fields match (e.g., password confirmation)
  /// Returns error message if don't match, null if valid
  static String? match(
    String? value,
    String? compareValue,
    BuildContext context, {
    String fieldName = 'Field',
  }) {
    final loc = AppLocalizations.of(context);

    if (value != compareValue) {
      return loc.fieldNotMatch(fieldName);
    }
    return null;
  }

  /// Validates numeric input
  /// Returns error message if not numeric, null if valid
  static String? numeric(
    String? value,
    BuildContext context, {
    String fieldName = 'Field',
  }) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return null;
    }

    if (double.tryParse(value) == null) {
      return loc.fieldMustBeNumber(fieldName);
    }

    return null;
  }

  /// Validates alphabetic characters only
  /// Returns error message if contains non-alphabetic, null if valid
  static String? alphabetic(
    String? value,
    BuildContext context, {
    String fieldName = 'Field',
  }) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return null;
    }

    final alphaRegex = RegExp(r'^[a-zA-Z\s]+$');

    if (!alphaRegex.hasMatch(value)) {
      return loc.fieldMustBeLetters(fieldName);
    }

    return null;
  }

  /// Validates alphanumeric characters only
  /// Returns error message if contains special characters, null if valid
  static String? alphanumeric(
    String? value,
    BuildContext context, {
    String fieldName = 'Field',
  }) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return null;
    }

    final alphanumRegex = RegExp(r'^[a-zA-Z0-9\s]+$');

    if (!alphanumRegex.hasMatch(value)) {
      return loc.fieldMustBeAlphanumeric(fieldName);
    }

    return null;
  }
}
