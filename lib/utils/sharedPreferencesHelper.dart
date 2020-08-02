import 'package:shared_preferences/shared_preferences.dart';

class IdenaSharedPreferences {
  String apiUrl;
  String keyApp;
  bool simulationMode;
  IdenaSharedPreferences(this.apiUrl, this.keyApp, this.simulationMode);
}

class SharedPreferencesHelper {
  static final String _kApiUrl = "api_url";
  static final String _kKeyApp = "key_app";
  static final String _kSimulationMode = "simulation_mode";

  static Future<IdenaSharedPreferences> getIdenaSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return IdenaSharedPreferences(
        prefs.getString(_kApiUrl) == null ? '' : prefs.getString(_kApiUrl),
        prefs.getString(_kKeyApp) == null ? '' : prefs.getString(_kKeyApp),
        prefs.getBool(_kSimulationMode) == null
            ? true
            : prefs.getBool(_kSimulationMode));
  }

  static Future<bool> setIdenaSharedPreferences(
      IdenaSharedPreferences idenaSharedPreferences) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if(idenaSharedPreferences.apiUrl != null)
      {
          prefs.setString(_kApiUrl, idenaSharedPreferences.apiUrl);
      }
      if(idenaSharedPreferences.keyApp != null)
      {
          prefs.setString(_kKeyApp, idenaSharedPreferences.keyApp);
      }
      if(idenaSharedPreferences.simulationMode != null)
      {
          prefs.setBool(_kSimulationMode, idenaSharedPreferences.simulationMode);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> setIdenaSharedPreferencesSimulationMode(
      bool simulationMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setBool(_kSimulationMode, simulationMode);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
