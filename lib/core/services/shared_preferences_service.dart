/// -----------------------------------------------------------------------------
/// shared_preferences_service.dart
/// -----------------------------------------------------------------------------
/// Service for local data persistence using SharedPreferences.
///
/// - Provides a simple key-value storage interface for primitive types
/// - Supports String, int, double, bool, and List<String> types
/// - Handles serialization/deserialization of data
/// - Used for simple caching and offline-first features
/// -----------------------------------------------------------------------------
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesService {
  Future<void> setString({required String key, required String value});
  Future<String?> getString({required String key});
  Future<void> setInt({required String key, required int value});
  Future<int?> getInt({required String key});
  Future<void> setDouble({required String key, required double value});
  Future<double?> getDouble({required String key});
  Future<void> setBool({required String key, required bool value});
  Future<bool?> getBool({required String key});
  Future<void> setStringList({
    required String key,
    required List<String> value,
  });
  Future<List<String>?> getStringList({required String key});
  Future<void> remove({required String key});
  Future<bool> containsKey({required String key});
  Future<Set<String>> getKeys();
  Future<void> clear();
}

@LazySingleton(as: SharedPreferencesService)
class SharedPreferencesServiceImpl implements SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesServiceImpl({required SharedPreferences prefs})
    : _prefs = prefs;

  @override
  Future<void> setString({required String key, required String value}) async {
    try {
      await _prefs.setString(key, value);
    } catch (e) {
      throw SharedPreferencesException(
        'Failed to set string for key "$key": $e',
      );
    }
  }

  @override
  Future<String?> getString({required String key}) async {
    try {
      return _prefs.getString(key);
    } catch (e) {
      throw SharedPreferencesException(
        'Failed to get string for key "$key": $e',
      );
    }
  }

  @override
  Future<void> setInt({required String key, required int value}) async {
    try {
      await _prefs.setInt(key, value);
    } catch (e) {
      throw SharedPreferencesException('Failed to set int for key "$key": $e');
    }
  }

  @override
  Future<int?> getInt({required String key}) async {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      throw SharedPreferencesException('Failed to get int for key "$key": $e');
    }
  }

  @override
  Future<void> setDouble({required String key, required double value}) async {
    try {
      await _prefs.setDouble(key, value);
    } catch (e) {
      throw SharedPreferencesException(
        'Failed to set double for key "$key": $e',
      );
    }
  }

  @override
  Future<double?> getDouble({required String key}) async {
    try {
      return _prefs.getDouble(key);
    } catch (e) {
      throw SharedPreferencesException(
        'Failed to get double for key "$key": $e',
      );
    }
  }

  @override
  Future<void> setBool({required String key, required bool value}) async {
    try {
      await _prefs.setBool(key, value);
    } catch (e) {
      throw SharedPreferencesException('Failed to set bool for key "$key": $e');
    }
  }

  @override
  Future<bool?> getBool({required String key}) async {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      throw SharedPreferencesException('Failed to get bool for key "$key": $e');
    }
  }

  @override
  Future<void> setStringList({
    required String key,
    required List<String> value,
  }) async {
    try {
      await _prefs.setStringList(key, value);
    } catch (e) {
      throw SharedPreferencesException(
        'Failed to set string list for key "$key": $e',
      );
    }
  }

  @override
  Future<List<String>?> getStringList({required String key}) async {
    try {
      return _prefs.getStringList(key);
    } catch (e) {
      throw SharedPreferencesException(
        'Failed to get string list for key "$key": $e',
      );
    }
  }

  @override
  Future<void> remove({required String key}) async {
    try {
      await _prefs.remove(key);
    } catch (e) {
      throw SharedPreferencesException('Failed to remove key "$key": $e');
    }
  }

  @override
  Future<bool> containsKey({required String key}) async {
    try {
      return _prefs.containsKey(key);
    } catch (e) {
      throw SharedPreferencesException(
        'Failed to check if key "$key" exists: $e',
      );
    }
  }

  @override
  Future<Set<String>> getKeys() async {
    try {
      return _prefs.getKeys();
    } catch (e) {
      throw SharedPreferencesException('Failed to get keys: $e');
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _prefs.clear();
    } catch (e) {
      throw SharedPreferencesException(
        'Failed to clear shared preferences: $e',
      );
    }
  }
}

class SharedPreferencesException implements Exception {
  final String message;
  SharedPreferencesException(this.message);

  @override
  String toString() => 'SharedPreferencesException: $message';
}
