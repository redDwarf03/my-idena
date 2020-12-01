import 'package:my_idena/backoffice/factory/sharedPreferencesHelper.dart';

const String PN_URL = "https://node.idena.io";
const String PN_URL_SLASH = "https://node.idena.io/";

Future<bool> getPublicNode(String apiUrl) async {
  if (apiUrl == null) {
    IdenaSharedPreferences idenaSharedPreferences =
        await SharedPreferencesHelper.getIdenaSharedPreferences();
    if (idenaSharedPreferences == null) {
      return false;
    }
    apiUrl = idenaSharedPreferences.apiUrl;
  }

  if (apiUrl == PN_URL || apiUrl == PN_URL_SLASH) {
    return true;
  } else {
    return false;
  }

}
