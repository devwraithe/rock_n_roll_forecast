import 'package:hive/hive.dart';

import 'local_storage_adapter.dart';

class HiveLocalStorageAdapter implements LocalStorageAdapter {
  @override
  Future<Box<dynamic>> openBox(String name) async {
    return await Hive.openBox(name);
  }

  @override
  Future<void> put(String key, dynamic value) async {
    final box = await openBox(key);
    try {
      await box.put(key, value);
    } finally {
      await box.close();
    }
  }

  @override
  Future<dynamic> get(String key) async {
    final box = await openBox(key);
    try {
      return await box.get(key);
    } finally {
      await box.close();
    }
  }

  @override
  Future<void> delete(String key) async {
    final box = await openBox(key);
    try {
      await box.delete(key);
    } finally {
      await box.close();
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    final box = await openBox(key);
    try {
      return box.containsKey(key);
    } finally {
      await box.close();
    }
  }

  @override
  Future<void> close() async {
    await Hive.close();
  }
}
