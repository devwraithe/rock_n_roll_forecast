import 'package:hive/hive.dart';

abstract class LocalStorageAdapter {
  Future<Box<dynamic>> openBox(String name);
  Future<void> put(String key, dynamic value);
  Future<dynamic> get(String key);
  Future<void> delete(String key);
  Future<bool> containsKey(String key);
  Future<void> close();
}
