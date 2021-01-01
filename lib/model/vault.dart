import 'package:flutter/services.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/encrypt.dart';
import 'package:my_idena/util/sharedprefsutil.dart';

// Singleton for keystore access methods in android/iOS
class Vault {
  static const String pinKey = 'fidena_pin';
  final FlutterSecureStorage secureStorage = new FlutterSecureStorage();

  Future<bool> legacy() async {
    return await sl.get<SharedPrefsUtil>().useLegacyStorage();
  }

  // Re-usable
  Future<String> _write(String key, String value) async {
    if (await legacy()) {
      await setEncrypted(key, value);
    } else {
      await secureStorage.write(key: key, value: value);
    }
    return value;
  }

  Future<String> _read(String key, {String defaultValue}) async {
    if (await legacy()) {
      return await getEncrypted(key);
    }
    return await secureStorage.read(key: key) ?? defaultValue;
  }

  Future<void> deleteAll() async {
    if (await legacy()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(pinKey);
      return;
    }
    return await secureStorage.deleteAll();
  }

  Future<String> getPin() async {
    return await _read(pinKey);
  }

  Future<String> writePin(String pin) async {
    return await _write(pinKey, pin);
  }

  Future<void> deletePin() async {
    if (await legacy()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(pinKey);
    }
    return await secureStorage.delete(key: pinKey);
  }

  // For encrypted data
  Future<void> setEncrypted(String key, String value) async {
    String secret = await getSecret();
    if (secret == null) return null;
    // Decrypt and return
    Salsa20Encryptor encrypter = new Salsa20Encryptor(
        secret.substring(0, secret.length - 8),
        secret.substring(secret.length - 8));
    // Encrypt and save
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, encrypter.encrypt(value));
  }

  Future<String> getEncrypted(String key) async {
    String secret = await getSecret();
    if (secret == null) return null;
    // Decrypt and return
    Salsa20Encryptor encrypter = new Salsa20Encryptor(
        secret.substring(0, secret.length - 8),
        secret.substring(secret.length - 8));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encrypted = prefs.get(key);
    if (encrypted == null) return null;
    return encrypter.decrypt(encrypted);
  }

  static const _channel = const MethodChannel('fappchannel');

  Future<String> getSecret() async {
    return await _channel.invokeMethod('getSecret');
  }
}
