import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageUtils {
  final storage = const FlutterSecureStorage();

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value, aOptions: getAndroidOptions());
  }

  Future<String?> read(String key) async {
    var readData = await storage.read(key: key, aOptions: getAndroidOptions());
    return readData;
  }

  Future<void> delete(String key) async {
    await storage.delete(key: key, aOptions: getAndroidOptions());
  }
}
