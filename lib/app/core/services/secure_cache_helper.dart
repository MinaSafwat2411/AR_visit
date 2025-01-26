import 'dart:convert';

import 'package:ar_visiting_app/app/core/models/enums/enums.dart';
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

  static Future<void> saveEnumsToStorage(EnumsModel enums) async {
  try {
    final jsonString = jsonEncode(enums.toMap());
    await _secureStorage.write(key: 'enums', value: jsonString);
  // ignore: empty_catches
  } catch (e) {
  }
}
static Future<EnumsModel?> getEnumsFromStorage() async {
  try {
    final jsonString = await _secureStorage.read(key: 'enum');
    if (jsonString != null) {
      final ennumMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return EnumsModel.fromJson(ennumMap);
    }
  // ignore: empty_catches
  } catch (e) {
  }
  return null; 
}
}