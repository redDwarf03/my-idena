import 'package:my_idena/backoffice/factory/sharedPreferencesHelper.dart';

const String DM_IDENTITY_ADDRESS = "0cxbd304e235b073637018c0430a4242d6f233bcf3";
const int DM_IDENTITY_AGE = 5;
const String DM_IDENTITY_STATE = "Human";
const int DM_IDENTITY_REQUIRED_FLIPS = 3;
const int DM_IDENTITY_MADE_FLIPS = 3;
const String DM_IDENTITY_PENALTY = "";
const bool DM_IDENTITY_ONLINE = false;
const int DM_IDENTITY_TOTAL_QUALIFIED_FLIPS = 0;
const double DM_IDENTITY_TOTAL_SHORT_FLIP_POINTS = 0;

const String DM_PORTOFOLIO_MAIN = "4.5362";
const String DM_PORTOFOLIO_STAKE = "0.000";

const String DM_EPOCH_CURRENT_PERIOD = "None";
const int DM_EPOCH_EPOCH = 45;
DateTime DM_EPOCH_NEXT_VALIDATION = new DateTime(2020, 12, 31);
const String DM_KEY_APP = "demo_api_key";

const int DM_CEREMONY_INTERVALS_FLIP_LOTTERY_DURATION = 300;
const int DM_CEREMONY_INTERVALS_LONG_SESSION_DURATION = 240;
const int DM_CEREMONY_INTERVALS_SHORT_SESSION_DURATION = 60;

const bool DM_SYNC_SYNCING = false;
const int DM_SYNC_CURRENT_BLOCK = 1;
const int DM_SYNC_HIGHEST_BLOCK = 1;

Future<bool> getDemoModeStatus(String keyApp) async {
  if (keyApp == null) {
    IdenaSharedPreferences idenaSharedPreferences =
        await SharedPreferencesHelper.getIdenaSharedPreferences();
    if (idenaSharedPreferences == null) {
      return false;
    }
    keyApp = idenaSharedPreferences.keyApp;
  }

  if (keyApp == DM_KEY_APP) {
    return true;
  } else {
    return false;
  }
}
