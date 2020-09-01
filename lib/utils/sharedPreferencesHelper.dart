import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

var logger = Logger();

class IdenaSharedPreferences {
  String apiUrl;
  String keyApp;
  IdenaSharedPreferences(this.apiUrl, this.keyApp);
}

class SharedPreferencesHelper {
  static final String _kApiUrl = "api_url";
  static final String _kKeyApp = "key_app";

  static Future<IdenaSharedPreferences> getIdenaSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return IdenaSharedPreferences(
        prefs.getString(_kApiUrl) == null ? '' : prefs.getString(_kApiUrl),
        prefs.getString(_kKeyApp) == null ? '' : prefs.getString(_kKeyApp));
  }

  static Future<bool> setIdenaSharedPreferences(
      IdenaSharedPreferences idenaSharedPreferences) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if(idenaSharedPreferences.apiUrl != null)
      {
        if(idenaSharedPreferences.apiUrl != '')
        {
          prefs.setString(_kApiUrl, idenaSharedPreferences.apiUrl);

        }
        else
        {
          prefs.setString(_kApiUrl, prefs.getString(_kApiUrl));
        }
      }
      if(idenaSharedPreferences.keyApp != null)
      {
        if(idenaSharedPreferences.keyApp != '')
        {
          prefs.setString(_kKeyApp, idenaSharedPreferences.keyApp);
        }
        else
        {
          prefs.setString(_kKeyApp, prefs.getString(_kKeyApp));
        }
      }
      return true;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }
}
