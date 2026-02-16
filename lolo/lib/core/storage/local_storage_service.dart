import 'package:hive_flutter/hive_flutter.dart';

/// Abstraction over Hive for simple key-value local storage.
///
/// Use this for caching API responses and storing app preferences.
/// For structured data (queries, indexes), use Isar instead.
class LocalStorageService {
  final Box<dynamic> _box;

  LocalStorageService(this._box);

  T? get<T>(String key) => _box.get(key) as T?;

  Future<void> put<T>(String key, T value) => _box.put(key, value);

  Future<void> delete(String key) => _box.delete(key);

  Future<void> clear() => _box.clear();

  bool containsKey(String key) => _box.containsKey(key);
}
