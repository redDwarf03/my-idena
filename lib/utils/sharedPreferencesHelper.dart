import 'package:shared_preferences/shared_preferences.dart';

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
    return IdenaSharedPreferences(prefs.getString(_kApiUrl) == null ? '' : prefs.getString(_kApiUrl), prefs.getString(_kKeyApp) == null ? '' : prefs.getString(_kKeyApp));

  }


  static Future<bool> setIdenaSharedPreferences(
      IdenaSharedPreferences idenaSharedPreferences) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString(_kApiUrl, idenaSharedPreferences.apiUrl);
      prefs.setString(_kKeyApp, idenaSharedPreferences.keyApp);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
