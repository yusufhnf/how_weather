/// hive_service.dart
/// -----------------------------------------------------------------------------
/// Service for local data persistence using Hive.
///
/// - Provides a simple key-value storage interface
/// - Supports typed data retrieval and lists
/// - Handles serialization/deserialization of data
/// - Used for caching and offline-first features
/// -----------------------------------------------------------------------------
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class HiveService {
  Future<void> put({required String key, required dynamic value});
  Future<dynamic> get({required String key});
  Future<T?> getTyped<T>({required String key});
  Future<List<T>> getList<T>({required String key});
  Future<void> delete({required String key});
  Future<int> clear();
  Future<bool> containsKey({required String key});
  Future<List<String>> getKeys();
}

@LazySingleton(as: HiveService)
class HiveServiceImpl implements HiveService {
  final Box<dynamic> _hive;

  HiveServiceImpl({required Box<dynamic> hive}) : _hive = hive;

  @override
  Future<int> clear() async {
    try {
      return await _hive.clear();
    } catch (e) {
      throw HiveStorageException('Failed to clear hive storage: $e');
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      return await _hive.delete(key);
    } catch (e) {
      throw HiveStorageException('Failed to delete key "$key": $e');
    }
  }

  @override
  Future<dynamic> get({required String key}) async {
    try {
      return _hive.get(key);
    } catch (e) {
      throw HiveStorageException('Failed to get value for key "$key": $e');
    }
  }

  @override
  Future<T?> getTyped<T>({required String key}) async {
    try {
      final value = _hive.get(key);
      if (value == null) return null;
      if (value is T) return value;
      throw HiveStorageException('Value for key "$key" is not of type $T');
    } catch (e) {
      if (e is HiveStorageException) rethrow;
      throw HiveStorageException(
        'Failed to get typed value for key "$key": $e',
      );
    }
  }

  @override
  Future<List<T>> getList<T>({required String key}) async {
    try {
      final value = _hive.get(key);
      if (value == null) return <T>[];
      if (value is List) {
        return value.cast<T>();
      }
      throw HiveStorageException('Value for key "$key" is not a List');
    } catch (e) {
      if (e is HiveStorageException) rethrow;
      throw HiveStorageException('Failed to get list for key "$key": $e');
    }
  }

  @override
  Future<void> put({required String key, required dynamic value}) async {
    try {
      await _hive.put(key, value);
    } catch (e) {
      throw HiveStorageException('Failed to put value for key "$key": $e');
    }
  }

  @override
  Future<bool> containsKey({required String key}) async {
    try {
      return _hive.containsKey(key);
    } catch (e) {
      throw HiveStorageException('Failed to check if key "$key" exists: $e');
    }
  }

  @override
  Future<List<String>> getKeys() async {
    try {
      return _hive.keys.cast<String>().toList();
    } catch (e) {
      throw HiveStorageException('Failed to get keys: $e');
    }
  }
}

class HiveStorageException implements Exception {
  final String message;
  HiveStorageException(this.message);

  @override
  String toString() => 'HiveStorageException: $message';
}
