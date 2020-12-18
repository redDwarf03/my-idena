import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

var logger = Logger();

class IdenaSharedPreferences {
  String apiUrl;
  String keyApp;
  String encryptedPk;
  String passwordPk;
  IdenaSharedPreferences(
      this.apiUrl, this.keyApp, this.encryptedPk, this.passwordPk);
}

class SharedPreferencesHelper {
  static final String _kApiUrl = "api_url";
  static final String _kKeyApp = "key_app";
  static final String _kEncryptedPk = "encrypted_pk";
  static final String _kpasswordPk = "password_pk";

  static Future<IdenaSharedPreferences> getIdenaSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return IdenaSharedPreferences(
        prefs.getString(_kApiUrl) == null ? '' : prefs.getString(_kApiUrl),
        prefs.getString(_kKeyApp) == null ? '' : prefs.getString(_kKeyApp),
        prefs.getString(_kEncryptedPk) == null
            ? ''
            : prefs.getString(_kEncryptedPk),
        prefs.getString(_kpasswordPk) == null
            ? ''
            : prefs.getString(_kpasswordPk));
  }

  static Future<bool> setIdenaSharedPreferences(
      IdenaSharedPreferences idenaSharedPreferences) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (idenaSharedPreferences.apiUrl != null) {
        if (idenaSharedPreferences.apiUrl != '') {
          prefs.setString(_kApiUrl, idenaSharedPreferences.apiUrl);
        } else {
          prefs.setString(_kApiUrl, prefs.getString(_kApiUrl));
        }
      }
      if (idenaSharedPreferences.keyApp != null) {
        if (idenaSharedPreferences.keyApp != '') {
          prefs.setString(_kKeyApp, idenaSharedPreferences.keyApp);
        } else {
          prefs.setString(_kKeyApp, prefs.getString(_kKeyApp));
        }
      }
      if (idenaSharedPreferences.encryptedPk != null) {
        if (idenaSharedPreferences.encryptedPk != '') {
          prefs.setString(_kEncryptedPk, idenaSharedPreferences.encryptedPk);
        } else {
          prefs.setString(_kEncryptedPk, prefs.getString(_kEncryptedPk));
        }
      }
      if (idenaSharedPreferences.passwordPk != null) {
        if (idenaSharedPreferences.passwordPk != '') {
          prefs.setString(_kpasswordPk, idenaSharedPreferences.passwordPk);
        } else {
          prefs.setString(_kpasswordPk, prefs.getString(_kpasswordPk));
        }
      }
      return true;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }
}
