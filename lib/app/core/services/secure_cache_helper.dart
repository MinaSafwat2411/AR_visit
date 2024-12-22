import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacheHelper {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  static Future<String?> getData({
    required String key,
  }) async {
    return await _secureStorage.read(key: key);
  }

  static Future<void> removeData({
    required String key,
  }) async {
    await _secureStorage.delete(key: key);
  }

  static Future<bool> containsKey(String key) async {
    return await _secureStorage.containsKey(key: key);
  }

  static Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}