// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/setting_item.dart';

enum AuthMethod { PIN, BIOMETRICS }

/// Represent the available authentication methods our app supports
class AuthenticationMethod extends SettingSelectionItem {
  AuthMethod method;

  AuthenticationMethod(this.method);

  String getDisplayName(BuildContext context) {
    switch (method) {
      case AuthMethod.BIOMETRICS:
        return AppLocalization.of(context).biometricsMethod;
      case AuthMethod.PIN:
        return AppLocalization.of(context).pinMethod;
      default:
        return AppLocalization.of(context).pinMethod;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return method.index;
  }
}
