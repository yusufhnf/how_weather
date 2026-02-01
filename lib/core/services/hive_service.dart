import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveService {
  final HiveInterface _hive;
  Box? _box;

  HiveService(this._hive);

  Future<void> init(String boxName) async {
    _box = await _hive.openBox(boxName);
  }

  Future<void> put(String key, dynamic value) async {
    await _box?.put(key, value);
  }

  T? get<T>(String key, {T? defaultValue}) {
    return _box?.get(key, defaultValue: defaultValue) as T?;
  }

  bool containsKey(String key) {
    return _box?.containsKey(key) ?? false;
  }

  Future<void> delete(String key) async {
    await _box?.delete(key);
  }

  Future<void> clear() async {
    await _box?.clear();
  }

  List<dynamic> getAll() {
    return _box?.values.toList() ?? [];
  }

  Map<dynamic, dynamic> getAllAsMap() {
    return _box?.toMap() ?? {};
  }
}
