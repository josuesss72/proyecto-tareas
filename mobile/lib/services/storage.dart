import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Future<void> saveItemStorage(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getItemStorage(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> removeItemStorage(String key) async {
    await _storage.delete(key: key);
  }
}
