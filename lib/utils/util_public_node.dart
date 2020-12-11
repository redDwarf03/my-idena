import 'package:my_idena/main.dart';

const String PN_URL = "https://node.idena.io";
const String PN_URL_SLASH = "https://node.idena.io/";

bool getPublicNode() {
  if (idenaSharedPreferences.apiUrl == PN_URL ||
      idenaSharedPreferences.apiUrl == PN_URL_SLASH) {
    return true;
  } else {
    return false;
  }
}
