import 'dart:ui';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_idena/model/authentication_method.dart';
import 'package:my_idena/model/available_currency.dart';
import 'package:my_idena/model/available_language.dart';
import 'package:my_idena/model/device_lock_timeout.dart';
import 'package:my_idena/model/wallet.dart';

/// Price conversion preference values
enum PriceConversion { BTC, NONE, HIDDEN }

/// Singleton wrapper for shared preferences
class SharedPrefsUtil {
  // Keys
  static const String first_launch_key = 'fidena_first_launch';
  static const String seed_backed_up_key = 'fidena_seed_backup';
  static const String app_uuid_key = 'fidena_app_uuid';
  static const String price_conversion = 'fidena_price_conversion_pref';
  static const String auth_method = 'fidena_auth_method';
  static const String cur_currency = 'fidena_currency_pref';
  static const String cur_language = 'fidena_language_pref';
  static const String cur_theme = 'fidena_theme_pref';
  static const String user_representative =
      'fidena_user_rep'; // For when non-opened accounts have set a representative
  static const String firstcontact_added = 'fidena_first_c_added';
  static const String lock_kalium = 'fidena_lock_dev';
  static const String kalium_lock_timeout = 'fidena_lock_timeout';
  static const String has_shown_root_warning =
      'fidena_root_warn'; // If user has seen the root/jailbreak warning yet
  // For maximum pin attempts
  static const String pin_attempts = 'fidena_pin_attempts';
  static const String pin_lock_until = 'fidena_lock_duraton';
  // For certain keystore incompatible androids
  static const String use_legacy_storage = 'fidena_legacy_storage';

  static const String api_url = 'fidena_api_url';
  static const String key_app = 'fidena_key_app';
  static const String encrypted_pk = 'fidena_encrypted_pk';
  static const String password_pk = 'fidena_password_pk';
  static const String address = 'fidena_address';

  // For plain-text data
  Future<void> set(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    }
  }

  Future<dynamic> get(String key, {dynamic defaultValue}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.get(key) ?? defaultValue;
  }

  // Key-specific helpers
  Future<void> setSeedBackedUp(bool value) async {
    return await set(seed_backed_up_key, value);
  }

  Future<bool> getSeedBackedUp() async {
    return await get(seed_backed_up_key, defaultValue: false);
  }

  Future<void> setHasSeenRootWarning() async {
    return await set(has_shown_root_warning, true);
  }

  Future<bool> getHasSeenRootWarning() async {
    return await get(has_shown_root_warning, defaultValue: false);
  }

  Future<void> setFirstLaunch() async {
    return await set(first_launch_key, false);
  }

  Future<bool> getFirstLaunch() async {
    return await get(first_launch_key, defaultValue: true);
  }

  Future<void> setFirstContactAdded(bool value) async {
    return await set(firstcontact_added, value);
  }

  Future<bool> getFirstContactAdded() async {
    return await get(firstcontact_added, defaultValue: false);
  }

  Future<void> setPriceConversion(PriceConversion conversion) async {
    return await set(price_conversion, conversion.index);
  }

  Future<PriceConversion> getPriceConversion() async {
    return PriceConversion.values[
        await get(price_conversion, defaultValue: PriceConversion.BTC.index)];
  }

  Future<void> setAuthMethod(AuthenticationMethod method) async {
    return await set(auth_method, method.getIndex());
  }

  Future<AuthenticationMethod> getAuthMethod() async {
    return AuthenticationMethod(AuthMethod.values[
        await get(auth_method, defaultValue: AuthMethod.BIOMETRICS.index)]);
  }

  Future<void> setCurrency(AvailableCurrency currency) async {
    return await set(cur_currency, currency.getIndex());
  }

  Future<AvailableCurrency> getCurrency(Locale deviceLocale) async {
    return AvailableCurrency(AvailableCurrencyEnum.values[await get(
        cur_currency,
        defaultValue:
            AvailableCurrency.getBestForLocale(deviceLocale).currency.index)]);
  }

  Future<void> setLanguage(LanguageSetting language) async {
    return await set(cur_language, language.getIndex());
  }

  Future<LanguageSetting> getLanguage() async {
    return LanguageSetting(AvailableLanguage.values[await get(cur_language,
        defaultValue: AvailableLanguage.DEFAULT.index)]);
  }

  Future<void> setRepresentative(String rep) async {
    return await set(user_representative, rep);
  }

  Future<String> getRepresentative() async {
    return await get(user_representative,
        defaultValue: AppWallet.defaultRepresentative);
  }

  Future<void> setLock(bool value) async {
    return await set(lock_kalium, value);
  }

  Future<bool> getLock() async {
    return await get(lock_kalium, defaultValue: false);
  }

  Future<void> setLockTimeout(LockTimeoutSetting setting) async {
    return await set(kalium_lock_timeout, setting.getIndex());
  }

  Future<LockTimeoutSetting> getLockTimeout() async {
    return LockTimeoutSetting(LockTimeoutOption.values[await get(
        kalium_lock_timeout,
        defaultValue: LockTimeoutOption.ONE.index)]);
  }

  // Locking out when max pin attempts exceeded
  Future<int> getLockAttempts() async {
    return await get(pin_attempts, defaultValue: 0);
  }

  Future<void> incrementLockAttempts() async {
    await set(pin_attempts, await getLockAttempts() + 1);
  }

  Future<void> resetLockAttempts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(pin_attempts);
    await prefs.remove(pin_lock_until);
  }

  Future<bool> shouldLock() async {
    if (await get(pin_lock_until) != null || await getLockAttempts() >= 5) {
      return true;
    }
    return false;
  }

  Future<void> updateLockDate() async {
    int attempts = await getLockAttempts();
    if (attempts >= 20) {
      // 4+ failed attempts
      await set(
          pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(Duration(hours: 24))));
    } else if (attempts >= 15) {
      // 3 failed attempts
      await set(
          pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(Duration(minutes: 15))));
    } else if (attempts >= 10) {
      // 2 failed attempts
      await set(
          pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(Duration(minutes: 5))));
    } else if (attempts >= 5) {
      await set(
          pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(Duration(minutes: 1))));
    }
  }

  Future<DateTime> getLockDate() async {
    String lockDateStr = await get(pin_lock_until);
    if (lockDateStr == null) {
      return null;
    }
    return DateFormat.yMd().add_jms().parseUtc(lockDateStr);
  }

  Future<bool> useLegacyStorage() async {
    return await get(use_legacy_storage, defaultValue: false);
  }

  Future<void> setUseLegacyStorage() async {
    await set(use_legacy_storage, true);
  }

  Future<void> setApiUrl(String value) async {
    return await set(api_url, value);
  }

  Future<Uri> getApiUrl() async {
    try
    {
        String apiUrl = await get(api_url, defaultValue: "");
        Uri uri = Uri.parse(apiUrl);
        return uri;
    }
    catch(e)
    {
        return null;
    }
  }

  Future<void> setKeyApp(String value) async {
    return await set(key_app, value);
  }

  Future<String> getKeyApp() async {
    return await get(key_app, defaultValue: "");
  }

  Future<void> setEncryptedPk(String value) async {
    return await set(encrypted_pk, value);
  }

  Future<String> getEncryptedPk() async {
    return await get(encrypted_pk, defaultValue: "");
  }

  Future<void> setPasswordPk(String value) async {
    return await set(password_pk, value);
  }

  Future<String> getPasswordPk() async {
    return await get(password_pk, defaultValue: "");
  }

  Future<void> setAddress(String value) async {
    return await set(address, value);
  }

  Future<String> getAddress() async {
    return await get(address, defaultValue: "");
  }

 // For logging out
  Future<void> deleteConfAccessNode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(api_url);
    await prefs.remove(key_app);
    await prefs.remove(encrypted_pk);
    await prefs.remove(password_pk);
    await prefs.remove(address);
  }

  // For logging out
  Future<void> deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(seed_backed_up_key);
    await prefs.remove(app_uuid_key);
    await prefs.remove(price_conversion);
    await prefs.remove(user_representative);
    await prefs.remove(cur_currency);
    await prefs.remove(auth_method);
    await prefs.remove(lock_kalium);
    await prefs.remove(pin_attempts);
    await prefs.remove(pin_lock_until);
    await prefs.remove(kalium_lock_timeout);
    await prefs.remove(has_shown_root_warning);
    await prefs.remove(api_url);
    await prefs.remove(key_app);
    await prefs.remove(encrypted_pk);
    await prefs.remove(password_pk);
    await prefs.remove(address);
  }
}
