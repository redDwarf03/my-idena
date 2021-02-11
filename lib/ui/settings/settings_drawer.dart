import 'dart:async';
import 'package:event_taxi/event_taxi.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/network/model/response/dna_identity_response.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/ui/accounts/accountdetails_sheet.dart';
import 'package:my_idena/ui/invite/activate_invite.dart';
import 'package:my_idena/ui/receive/receive_sheet.dart';
import 'package:my_idena/ui/send/send_sheet.dart';
import 'package:my_idena/ui/settings/about_widget.dart';
import 'package:my_idena/ui/settings/backupseed_sheet.dart';
import 'package:my_idena/ui/settings/chart_sheet.dart';
import 'package:my_idena/ui/settings/profile_infos_widget.dart';
import 'package:my_idena/ui/settings/validation_basics_widget.dart';
import 'package:my_idena/ui/widgets/app_simpledialog.dart';
import 'package:my_idena/ui/widgets/sheet_util.dart';
import 'package:my_idena/util/hapticutil.dart';
import 'package:my_idena/util/util_identity.dart';
import 'package:my_idena/util/util_node.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/bus/events.dart';
import 'package:my_idena/model/authentication_method.dart';
import 'package:my_idena/model/available_currency.dart';
import 'package:my_idena/model/device_unlock_option.dart';
import 'package:my_idena/model/device_lock_timeout.dart';
import 'package:my_idena/model/available_language.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/ui/settings/settings_list_item.dart';
import 'package:my_idena/ui/settings/contacts_widget.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/ui/widgets/security.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/biometrics.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

import '../../appstate_container.dart';
import '../../util/sharedprefsutil.dart';

class SettingsSheet extends StatefulWidget {
  final ReceiveSheet receive;
  final int nodeType;
  final BuildContext contextInput;

  SettingsSheet(this.receive, this.nodeType, this.contextInput);

  _SettingsSheetState createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController _controller;
  Animation<Offset> _offsetFloat;
  AnimationController _securityController;
  Animation<Offset> _securityOffsetFloat;
  AnimationController _validationBasicsController;
  Animation<Offset> _validationBasicsOffsetFloat;
  AnimationController _aboutController;
  Animation<Offset> _aboutOffsetFloat;
  AnimationController _profileInfosController;
  Animation<Offset> _profileInfosOffsetFloat;
  AnimationController _inviteController;
  Animation<Offset> _inviteOffsetFloat;
  String versionString = "";

  final Logger log = sl.get<Logger>();
  bool _hasBiometrics = false;
  AuthenticationMethod _curAuthMethod =
      AuthenticationMethod(AuthMethod.BIOMETRICS);
  UnlockSetting _curUnlockSetting = UnlockSetting(UnlockOption.NO);
  LockTimeoutSetting _curTimeoutSetting =
      LockTimeoutSetting(LockTimeoutOption.ONE);

  bool _securityOpen;

  bool _inviteOpen;

  bool _loadingAccounts;

  bool _contactsOpen;

  bool _validationBasicsOpen;

  bool _aboutOpen;

  bool _profileInfosOpen;

  bool notNull(Object o) => o != null;

  bool _miningActive;
  bool _canMine;
  List _flipKeyWordPairs;

  void loadCtx() async {
    DnaIdentityResponse _dnaIdentityResponse = await sl
        .get<AppService>()
        .getDnaIdentity(StateContainer.of(widget.contextInput).selectedAccount.address);
    bool _m = false;
    List _fk = new List();
    bool cm = false;
    if (_dnaIdentityResponse != null && _dnaIdentityResponse.result != null) {
      _m = _dnaIdentityResponse.result.online;
      _fk = _dnaIdentityResponse.result.flipKeyWordPairs;
      cm = UtilIdentity().canMine(_dnaIdentityResponse.result.state);
    }

    setState(() {
      _miningActive = _m;
      _canMine = cm;
      _flipKeyWordPairs = _fk;
    });
  }

  @override
  void initState() {
    super.initState();
    _contactsOpen = false;
    _validationBasicsOpen = false;
    _aboutOpen = false;
    _securityOpen = false;
    _inviteOpen = false;
    _profileInfosOpen = false;
    _loadingAccounts = false;
    _miningActive = false;
    _canMine = false;

    loadCtx();

    // Determine if they have face or fingerprint enrolled, if not hide the setting
    sl.get<BiometricUtil>().hasBiometrics().then((bool hasBiometrics) {
      setState(() {
        _hasBiometrics = hasBiometrics;
      });
    });
    // Get default auth method setting
    sl.get<SharedPrefsUtil>().getAuthMethod().then((authMethod) {
      setState(() {
        _curAuthMethod = authMethod;
      });
    });
    // Get default unlock settings
    sl.get<SharedPrefsUtil>().getLock().then((lock) {
      setState(() {
        _curUnlockSetting = lock
            ? UnlockSetting(UnlockOption.YES)
            : UnlockSetting(UnlockOption.NO);
      });
    });
    sl.get<SharedPrefsUtil>().getLockTimeout().then((lockTimeout) {
      setState(() {
        _curTimeoutSetting = lockTimeout;
      });
    });
    // Setup animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    // For security menu
    _securityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _inviteController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );

    _validationBasicsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _aboutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _profileInfosController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _offsetFloat = Tween<Offset>(begin: Offset(1.1, 0), end: Offset(0, 0))
        .animate(_controller);
    _securityOffsetFloat =
        Tween<Offset>(begin: Offset(1.1, 0), end: Offset(0, 0))
            .animate(_securityController);
    _inviteOffsetFloat = Tween<Offset>(begin: Offset(1.1, 0), end: Offset(0, 0))
        .animate(_inviteController);
    _validationBasicsOffsetFloat =
        Tween<Offset>(begin: Offset(1.1, 0), end: Offset(0, 0))
            .animate(_validationBasicsController);

    _aboutOffsetFloat = Tween<Offset>(begin: Offset(1.1, 0), end: Offset(0, 0))
        .animate(_aboutController);

    _profileInfosOffsetFloat =
        Tween<Offset>(begin: Offset(1.1, 0), end: Offset(0, 0))
            .animate(_profileInfosController);

    // Version string
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        versionString = "v${packageInfo.version}";
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _securityController.dispose();
    _inviteController.dispose();
    _validationBasicsController.dispose();
    _aboutController.dispose();
    _profileInfosController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  Future<void> _authMethodDialog() async {
    switch (await showDialog<AuthMethod>(
        context: context,
        builder: (BuildContext context) {
          return AppSimpleDialog(
            title: Text(
              AppLocalization.of(context).authMethod,
              style: AppStyles.textStyleDialogHeader(context),
            ),
            children: <Widget>[
              AppSimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AuthMethod.BIOMETRICS);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalization.of(context).biometricsMethod,
                    style: AppStyles.textStyleDialogOptions(context),
                  ),
                ),
              ),
              AppSimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AuthMethod.PIN);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalization.of(context).pinMethod,
                    style: AppStyles.textStyleDialogOptions(context),
                  ),
                ),
              ),
            ],
          );
        })) {
      case AuthMethod.PIN:
        sl
            .get<SharedPrefsUtil>()
            .setAuthMethod(AuthenticationMethod(AuthMethod.PIN))
            .then((result) {
          setState(() {
            _curAuthMethod = AuthenticationMethod(AuthMethod.PIN);
          });
        });
        break;
      case AuthMethod.BIOMETRICS:
        sl
            .get<SharedPrefsUtil>()
            .setAuthMethod(AuthenticationMethod(AuthMethod.BIOMETRICS))
            .then((result) {
          setState(() {
            _curAuthMethod = AuthenticationMethod(AuthMethod.BIOMETRICS);
          });
        });
        break;
    }
  }

  Future<void> _lockDialog() async {
    switch (await showDialog<UnlockOption>(
        context: context,
        builder: (BuildContext context) {
          return AppSimpleDialog(
            title: Text(
              AppLocalization.of(context).lockAppSetting,
              style: AppStyles.textStyleDialogHeader(context),
            ),
            children: <Widget>[
              AppSimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, UnlockOption.NO);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalization.of(context).no,
                    style: AppStyles.textStyleDialogOptions(context),
                  ),
                ),
              ),
              AppSimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, UnlockOption.YES);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalization.of(context).yes,
                    style: AppStyles.textStyleDialogOptions(context),
                  ),
                ),
              ),
            ],
          );
        })) {
      case UnlockOption.YES:
        sl.get<SharedPrefsUtil>().setLock(true).then((result) {
          setState(() {
            _curUnlockSetting = UnlockSetting(UnlockOption.YES);
          });
        });
        break;
      case UnlockOption.NO:
        sl.get<SharedPrefsUtil>().setLock(false).then((result) {
          setState(() {
            _curUnlockSetting = UnlockSetting(UnlockOption.NO);
          });
        });
        break;
    }
  }

  List<Widget> _buildCurrencyOptions() {
    List<Widget> ret = new List();
    AvailableCurrencyEnum.values.forEach((AvailableCurrencyEnum value) {
      ret.add(SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            AvailableCurrency(value).getDisplayName(context),
            style: AppStyles.textStyleDialogOptions(context),
          ),
        ),
      ));
    });
    return ret;
  }

  Future<void> _currencyDialog() async {
    AvailableCurrencyEnum selection =
        await showAppDialog<AvailableCurrencyEnum>(
            context: context,
            builder: (BuildContext context) {
              return AppSimpleDialog(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    AppLocalization.of(context).currency,
                    style: AppStyles.textStyleDialogHeader(context),
                  ),
                ),
                children: _buildCurrencyOptions(),
              );
            });
    if (selection != null) {
      sl
          .get<SharedPrefsUtil>()
          .setCurrency(AvailableCurrency(selection))
          .then((result) {
        if (StateContainer.of(context).curCurrency.currency != selection) {
          setState(() {
            StateContainer.of(context).curCurrency =
                AvailableCurrency(selection);
            StateContainer.of(context)
                .updateCurrency(AvailableCurrency(selection));
          });
        }
      });
    }
  }

  List<Widget> _buildLanguageOptions() {
    List<Widget> ret = new List();
    AvailableLanguage.values.forEach((AvailableLanguage value) {
      ret.add(SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            LanguageSetting(value).getDisplayName(context),
            style: AppStyles.textStyleDialogOptions(context),
          ),
        ),
      ));
    });
    return ret;
  }

  Future<void> _languageDialog() async {
    AvailableLanguage selection = await showAppDialog<AvailableLanguage>(
        context: context,
        builder: (BuildContext context) {
          return AppSimpleDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context).language,
                style: AppStyles.textStyleDialogHeader(context),
              ),
            ),
            children: _buildLanguageOptions(),
          );
        });
    if (selection != null) {
      sl
          .get<SharedPrefsUtil>()
          .setLanguage(LanguageSetting(selection))
          .then((result) {
        if (StateContainer.of(context).curLanguage.language != selection) {
          setState(() {
            StateContainer.of(context)
                .updateLanguage(LanguageSetting(selection));
          });
        }
      });
    }
  }

  List<Widget> _buildLockTimeoutOptions() {
    List<Widget> ret = new List();
    LockTimeoutOption.values.forEach((LockTimeoutOption value) {
      ret.add(SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            LockTimeoutSetting(value).getDisplayName(context),
            style: AppStyles.textStyleDialogOptions(context),
          ),
        ),
      ));
    });
    return ret;
  }

  Future<void> _lockTimeoutDialog() async {
    LockTimeoutOption selection = await showAppDialog<LockTimeoutOption>(
        context: context,
        builder: (BuildContext context) {
          return AppSimpleDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context).autoLockHeader,
                style: AppStyles.textStyleDialogHeader(context),
              ),
            ),
            children: _buildLockTimeoutOptions(),
          );
        });
    sl
        .get<SharedPrefsUtil>()
        .setLockTimeout(LockTimeoutSetting(selection))
        .then((result) {
      if (_curTimeoutSetting.setting != selection) {
        sl
            .get<SharedPrefsUtil>()
            .setLockTimeout(LockTimeoutSetting(selection))
            .then((_) {
          setState(() {
            _curTimeoutSetting = LockTimeoutSetting(selection);
          });
        });
      }
    });
  }

  Future<bool> _onBackButtonPressed() async {
    if (_contactsOpen) {
      setState(() {
        _contactsOpen = false;
      });
      _controller.reverse();
      return false;
    } else if (_securityOpen) {
      setState(() {
        _securityOpen = false;
      });
      _securityController.reverse();
      return false;
    } else if (_inviteOpen) {
      setState(() {
        _inviteOpen = false;
      });
      _inviteController.reverse();
      return false;
    } else if (_validationBasicsOpen) {
      setState(() {
        _validationBasicsOpen = false;
      });
      _validationBasicsController.reverse();
      return false;
    } else if (_aboutOpen) {
      setState(() {
        _aboutOpen = false;
      });
      _aboutController.reverse();
      return false;
    } else if (_profileInfosOpen) {
      setState(() {
        _profileInfosOpen = false;
      });
      _profileInfosController.reverse();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Drawer in flutter doesn't have a built-in way to push/pop elements
    // on top of it like our Android counterpart. So we can override back button
    // presses and replace the main settings widget with contacts based on a bool
    return new WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: ClipRect(
        child: Stack(
          children: <Widget>[
            Container(
              color: StateContainer.of(context).curTheme.backgroundDark,
              constraints: BoxConstraints.expand(),
            ),
            buildMainSettings(context),
            SlideTransition(
                position: _offsetFloat,
                child: ContactsList(_controller, _contactsOpen)),
            SlideTransition(
                position: _securityOffsetFloat,
                child: buildSecurityMenu(context)),
            SlideTransition(
                position: _inviteOffsetFloat, child: buildInviteMenu(context)),
            SlideTransition(
                position: _validationBasicsOffsetFloat,
                child: ValidationBasics(
                    _validationBasicsController, _validationBasicsOpen)),
            SlideTransition(
                position: _aboutOffsetFloat,
                child: About(_aboutController, _aboutOpen)),
            StateContainer.of(context).selectedAccount.address != null
                ? SlideTransition(
                    position: _profileInfosOffsetFloat,
                    child: ProfileInfos(
                        _profileInfosController,
                        _profileInfosOpen,
                        StateContainer.of(context).selectedAccount.address))
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildMainSettings(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.backgroundDark,
      ),
      child: SafeArea(
        minimum: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 30,
        ),
        child: Column(
          children: <Widget>[
            // A container for accounts area
            Container(
              margin:
                  EdgeInsetsDirectional.only(start: 26.0, end: 20, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 4.0),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  border: Border.all(
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .primary,
                                      width: 0),
                                ),
                                alignment: AlignmentDirectional(-1, 0),
                                child: CircleAvatar(
                                  backgroundColor: StateContainer.of(context)
                                      .curTheme
                                      .text05,
                                  backgroundImage: UIUtil.getRobohashURL(
                                      StateContainer.of(context)
                                          .selectedAccount
                                          .address),
                                  radius: 50.0,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 64,
                                height: 64,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  highlightColor: StateContainer.of(context)
                                      .curTheme
                                      .text15,
                                  splashColor: StateContainer.of(context)
                                      .curTheme
                                      .text15,
                                  padding: EdgeInsets.all(0.0),
                                  child: SizedBox(
                                    width: 60,
                                    height: 60,
                                  ),
                                  onPressed: () {
                                    if (StateContainer.of(context)
                                            .selectedAccount
                                            .address !=
                                        null) {
                                      AccountDetailsSheet(
                                              StateContainer.of(context)
                                                  .selectedAccount)
                                          .mainBottomSheet(context);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // A row for other accounts and account switcher
                      Row(
                        children: <Widget>[
                          // Second Account
                          StateContainer.of(context).recentLast != null
                              ? Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          height: 52,
                                          width: 52,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .text05,
                                            backgroundImage:
                                                UIUtil.getRobohashURL(
                                                    StateContainer.of(context)
                                                        .recentLast
                                                        .address),
                                            radius: 50.0,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 52,
                                          height: 52,
                                          color: Colors.transparent,
                                          child: FlatButton(
                                            onPressed: () {
                                              sl
                                                  .get<DBHelper>()
                                                  .changeAccount(
                                                      StateContainer.of(context)
                                                          .recentLast)
                                                  .then((_) {
                                                EventTaxiImpl.singleton().fire(
                                                    AccountChangedEvent(
                                                        account:
                                                            StateContainer.of(
                                                                    context)
                                                                .recentLast,
                                                        delayPop: true));
                                              });
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0)),
                                            highlightColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .text15,
                                            splashColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .text15,
                                            padding: EdgeInsets.all(0.0),
                                            child: Container(
                                              width: 52,
                                              height: 52,
                                              color: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          // Third Account
                          StateContainer.of(context).recentSecondLast != null
                              ? Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          height: 52,
                                          width: 52,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .text05,
                                            backgroundImage:
                                                UIUtil.getRobohashURL(
                                              StateContainer.of(context)
                                                  .recentSecondLast
                                                  .address,
                                            ),
                                            radius: 50.0,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 52,
                                          height: 52,
                                          color: Colors.transparent,
                                          child: FlatButton(
                                            onPressed: () {
                                              sl
                                                  .get<DBHelper>()
                                                  .changeAccount(
                                                      StateContainer.of(context)
                                                          .recentSecondLast)
                                                  .then((_) {
                                                EventTaxiImpl.singleton().fire(
                                                    AccountChangedEvent(
                                                        account: StateContainer
                                                                .of(context)
                                                            .recentSecondLast,
                                                        delayPop: true));
                                              });
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0)),
                                            highlightColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .text15,
                                            splashColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .text15,
                                            padding: EdgeInsets.all(0.0),
                                            child: Container(
                                              width: 52,
                                              height: 52,
                                              color: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          // Account switcher
                          /*Container(
                            height: 36,
                            width: 36,
                            margin: EdgeInsets.symmetric(horizontal: 6.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: FlatButton(
                              onPressed: () {
                                if (!_loadingAccounts) {
                                  setState(() {
                                    _loadingAccounts = true;
                                  });
                                  StateContainer.of(context)
                                      .getSeed()
                                      .then((seed) {
                                    sl
                                        .get<DBHelper>()
                                        .getAccounts(seed)
                                        .then((accounts) {
                                      setState(() {
                                        _loadingAccounts = false;
                                      });
                                      AppAccountsSheet(accounts)
                                          .mainBottomSheet(context);
                                    });
                                  });
                                }
                              },
                              padding: EdgeInsets.all(0.0),
                              shape: CircleBorder(),
                              splashColor: _loadingAccounts
                                  ? Colors.transparent
                                  : StateContainer.of(context).curTheme.text30,
                              highlightColor: _loadingAccounts
                                  ? Colors.transparent
                                  : StateContainer.of(context).curTheme.text15,
                              child: Icon(AppIcons.accountswitcher,
                                  size: 36,
                                  color: _loadingAccounts
                                      ? StateContainer.of(context)
                                          .curTheme
                                          .icon60
                                      : StateContainer.of(context)
                                          .curTheme
                                          .icon),
                            ),
                          ),*/
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    child: FlatButton(
                      padding: EdgeInsets.all(4.0),
                      highlightColor:
                          StateContainer.of(context).curTheme.text15,
                      splashColor: StateContainer.of(context).curTheme.text30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      onPressed: () {
                        if (StateContainer.of(context)
                                .selectedAccount
                                .address !=
                            null) {
                          AccountDetailsSheet(
                                  StateContainer.of(context).selectedAccount)
                              .mainBottomSheet(context);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Main account name
                          Container(
                            child: Text(
                              StateContainer.of(context).selectedAccount.name,
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: StateContainer.of(context).curTheme.text,
                              ),
                            ),
                          ),
                          // Main account address
                          Container(
                            child: Text(
                              StateContainer.of(context).wallet != null &&
                                      StateContainer.of(context)
                                              .wallet
                                              .address !=
                                          null
                                  ? StateContainer.of(context).wallet?.address
                                  : "",
                              style: TextStyle(
                                fontFamily: "OverpassMono",
                                fontWeight: FontWeight.w100,
                                fontSize: 14.0,
                                color:
                                    StateContainer.of(context).curTheme.text60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Settings items
            Expanded(
                child: Stack(
              children: <Widget>[
                ListView(
                  padding: EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: 30.0, top: 20.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context).features,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color:
                                  StateContainer.of(context).curTheme.text60)),
                    ),
                    widget.nodeType != SHARED_NODE &&
                            widget.nodeType != DEMO_NODE &&
                            widget.nodeType != PUBLIC_NODE &&
                            _canMine == true
                        ? Divider(
                            height: 2,
                            color: StateContainer.of(context).curTheme.text15,
                          )
                        : SizedBox(),
                    widget.nodeType != SHARED_NODE &&
                            widget.nodeType != DEMO_NODE &&
                            widget.nodeType != PUBLIC_NODE &&
                            _canMine == true
                        ? AppSettings.buildSettingsListItemSwitch(
                            context,
                            AppLocalization.of(context).miningStatus,
                            RpgAwesome.mining_diamonds,
                            _miningActive, onChanged: (_isSwitched) {
                            _isSwitched
                                ? AppDialogs.showConfirmDialog(
                                    context,
                                    AppLocalization.of(context)
                                        .activateMiningHeader,
                                    AppLocalization.of(context)
                                        .activateMiningInfos,
                                    CaseChange.toUpperCase(
                                        AppLocalization.of(context)
                                            .validationUnderstand,
                                        context), () {
                                    setState(() {
                                      sl.get<AppService>().becomeOnline();
                                      _miningActive = _isSwitched;
                                      StateContainer.of(context)
                                          .requestUpdate();
                                    });
                                  })
                                : AppDialogs.showConfirmDialog(
                                    context,
                                    AppLocalization.of(context)
                                        .deactivateMiningHeader,
                                    AppLocalization.of(context)
                                        .deactivateMiningInfos,
                                    CaseChange.toUpperCase(
                                        AppLocalization.of(context)
                                            .validationUnderstand,
                                        context), () {
                                    setState(() {
                                      sl.get<AppService>().becomeOffline();
                                      _miningActive = _isSwitched;
                                      StateContainer.of(context)
                                          .requestUpdate();
                                    });
                                  });
                          })
                        : SizedBox(),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).tryValidationSession,
                        LineariconsFree.select, onPressed: () {
                      bool simulationMode = true;
                      Navigator.of(context).pushNamed(
                          '/validation_session_step_1',
                          arguments: simulationMode);
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).receive,
                        AppIcons.import_icon, onPressed: () {
                      if (widget.receive == null) {
                        return;
                      }
                      Sheets.showAppHeightEightSheet(
                          context: context, widget: widget.receive);
                    }),
                    StateContainer.of(context).wallet != null &&
                            StateContainer.of(context).wallet.accountBalance >
                                0 
                        ? Divider(
                            height: 2,
                            color: StateContainer.of(context).curTheme.text15,
                          )
                        : SizedBox(),
                    StateContainer.of(context).wallet != null &&
                            StateContainer.of(context).wallet.accountBalance >
                                0 
                        ? AppSettings.buildSettingsListItemSingleLine(
                            context,
                            AppLocalization.of(context).send,
                            AppIcons.export_icon, onPressed: () {
                            Sheets.showAppHeightNineSheet(
                                context: context,
                                widget: SendSheet(
                                    localCurrency: StateContainer.of(context)
                                        .curCurrency));
                          })
                        : SizedBox(),
                    /*Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).flipsCreatorHeader,
                        FontAwesome5.paint_brush, onPressed: () {
                      Navigator.of(context).pushNamed('/creation_flips_step_1',
                          arguments: _flipKeyWordPairs);
                    }),*/
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: 30.0, top: 20.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context).informations,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color:
                                  StateContainer.of(context).curTheme.text60)),
                    ),
                    widget.nodeType == PUBLIC_NODE
                        ? SizedBox()
                        : StateContainer.of(context).selectedAccount.address !=
                                null
                            ? Divider(
                                height: 2,
                                color:
                                    StateContainer.of(context).curTheme.text15,
                              )
                            : SizedBox(),
                    StateContainer.of(context).selectedAccount.address !=
                                null &&
                            StateContainer.of(context)
                                    .selectedAccount
                                    .address !=
                                PN_ADDRESS
                        ? AppSettings.buildSettingsListItemSingleLine(
                            context,
                            AppLocalization.of(context).profileInfosHeader,
                            FontAwesome5.address_card, onPressed: () {
                            setState(() {
                              _profileInfosOpen = true;
                            });
                            _profileInfosController.forward();
                          })
                        : SizedBox(),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).contactsHeader,
                        Typicons.contacts, onPressed: () {
                      setState(() {
                        _contactsOpen = true;
                      });
                      _controller.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).chartHeader,
                        FontAwesome.chart_line, onPressed: () {
                      Sheets.showAppHeightNineSheet(
                          context: context,
                          widget: ChartSheet(
                              localCurrency:
                                  StateContainer.of(context).curCurrency));
                    }),
                    widget.nodeType != PUBLIC_NODE &&
                            widget.nodeType != SHARED_NODE
                        ? Divider(
                            height: 2,
                            color: StateContainer.of(context).curTheme.text15,
                          )
                        : SizedBox(),
                    widget.nodeType != PUBLIC_NODE &&
                            widget.nodeType != SHARED_NODE
                        ? AppSettings.buildSettingsListItemSingleLine(
                            context,
                            AppLocalization.of(context).inviteHeader,
                            FontAwesome.user_plus, onPressed: () {
                            setState(() {
                              _inviteOpen = true;
                            });
                            _inviteController.forward();
                          })
                        : SizedBox(),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).validationBasicsHeader,
                        Octicons.law, onPressed: () {
                      setState(() {
                        _validationBasicsOpen = true;
                      });
                      _validationBasicsController.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).faq,
                        FontAwesome.help_circled, onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return UIUtil.showFAQ(context);
                      }));
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).aboutHeader,
                        AppIcons.info, onPressed: () {
                      setState(() {
                        _aboutOpen = true;
                      });
                      _aboutController.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          top: 20, start: 30.0, bottom: 10),
                      child: Text(AppLocalization.of(context).preferences,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color:
                                  StateContainer.of(context).curTheme.text60)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemDoubleLine(
                        context,
                        AppLocalization.of(context).changeCurrency,
                        StateContainer.of(context).curCurrency,
                        FontAwesome.money,
                        _currencyDialog),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemDoubleLine(
                        context,
                        AppLocalization.of(context).language,
                        StateContainer.of(context).curLanguage,
                        FontAwesome.language,
                        _languageDialog),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).securityHeader,
                        AppIcons.security, onPressed: () {
                      setState(() {
                        _securityOpen = true;
                      });
                      _securityController.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: 30.0, top: 20.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context).manage,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color:
                                  StateContainer.of(context).curTheme.text60)),
                    ),
                    widget.nodeType != PUBLIC_NODE &&
                            widget.nodeType != SHARED_NODE
                        ? SizedBox()
                        : Divider(
                            height: 2,
                            color: StateContainer.of(context).curTheme.text15,
                          ),
                    widget.nodeType != PUBLIC_NODE &&
                            widget.nodeType != SHARED_NODE
                        ? SizedBox()
                        : AppSettings.buildSettingsListItemSingleLine(
                            context,
                            AppLocalization.of(context).backupSecretPhrase,
                            AppIcons.backupseed, onPressed: () async {
                            // Authenticate
                            AuthenticationMethod authMethod =
                                await sl.get<SharedPrefsUtil>().getAuthMethod();
                            bool hasBiometrics =
                                await sl.get<BiometricUtil>().hasBiometrics();
                            if (authMethod.method == AuthMethod.BIOMETRICS &&
                                hasBiometrics) {
                              try {
                                bool authenticated = await sl
                                    .get<BiometricUtil>()
                                    .authenticateWithBiometrics(
                                        context,
                                        AppLocalization.of(context)
                                            .fingerprintSeedBackup);
                                if (authenticated) {
                                  sl.get<HapticUtil>().fingerprintSucess();
                                  StateContainer.of(context)
                                      .getSeed()
                                      .then((seed) {
                                    AppSeedBackupSheet(seed)
                                        .mainBottomSheet(context);
                                  });
                                }
                              } catch (e) {
                                await authenticateWithPin();
                              }
                            } else {
                              await authenticateWithPin();
                            }
                          }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).logout,
                        FontAwesome.logout, onPressed: () {
                      AppDialogs.showConfirmDialog(
                          context,
                          CaseChange.toUpperCase(
                              AppLocalization.of(context).warning, context),
                          AppLocalization.of(context).logoutDetail,
                          AppLocalization.of(context)
                              .logoutAction
                              .toUpperCase(), () {
                        // Show another confirm dialog
                        AppDialogs.showConfirmDialog(
                            context,
                            AppLocalization.of(context).logoutAreYouSure,
                            AppLocalization.of(context).logoutReassurance,
                            CaseChange.toUpperCase(
                                AppLocalization.of(context).yes, context), () {
                          // Delete all data
                          sl.get<Vault>().deleteAll().then((_) {
                            sl
                                .get<SharedPrefsUtil>()
                                .deleteAll()
                                .then((result) {
                              StateContainer.of(context).logOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                            });
                          });
                        });
                      });
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(versionString,
                              style: AppStyles.textStyleVersion(context)),
                          Text(" | ",
                              style: AppStyles.textStyleVersion(context)),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return UIUtil.showWebview(context,
                                      AppLocalization.of(context).privacyUrl);
                                }));
                              },
                              child: Text(
                                  AppLocalization.of(context).privacyPolicy,
                                  style: AppStyles.textStyleVersionUnderline(
                                      context))),
                        ],
                      ),
                    ),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          StateContainer.of(context).curTheme.backgroundDark,
                          StateContainer.of(context).curTheme.backgroundDark00
                        ],
                        begin: AlignmentDirectional(0.5, -1.0),
                        end: AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildSecurityMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.backgroundDark,
        boxShadow: [
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30,
              offset: Offset(-5, 0),
              blurRadius: 20),
        ],
      ),
      child: SafeArea(
        minimum: EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            // Back button and Security Text
            Container(
              margin: EdgeInsets.only(bottom: 10.0, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      //Back button
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: FlatButton(
                            highlightColor:
                                StateContainer.of(context).curTheme.text15,
                            splashColor:
                                StateContainer.of(context).curTheme.text15,
                            onPressed: () {
                              setState(() {
                                _securityOpen = false;
                              });
                              _securityController.reverse();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(8.0),
                            child: Icon(AppIcons.back,
                                color: StateContainer.of(context).curTheme.text,
                                size: 24)),
                      ),
                      //Security Header Text
                      Text(
                        AppLocalization.of(context).securityHeader,
                        style: AppStyles.textStyleSettingsHeader(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                ListView(
                  padding: EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsetsDirectional.only(start: 30.0, bottom: 10),
                      child: Text(AppLocalization.of(context).preferences,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color:
                                  StateContainer.of(context).curTheme.text60)),
                    ),
                    // Authentication Method
                    _hasBiometrics
                        ? Divider(
                            height: 2,
                            color: StateContainer.of(context).curTheme.text15,
                          )
                        : null,
                    _hasBiometrics
                        ? AppSettings.buildSettingsListItemDoubleLine(
                            context,
                            AppLocalization.of(context).authMethod,
                            _curAuthMethod,
                            AppIcons.fingerprint,
                            _authMethodDialog)
                        : null,
                    // Authenticate on Launch
                    Column(children: <Widget>[
                      Divider(
                          height: 2,
                          color: StateContainer.of(context).curTheme.text15),
                      AppSettings.buildSettingsListItemDoubleLine(
                          context,
                          AppLocalization.of(context).lockAppSetting,
                          _curUnlockSetting,
                          AppIcons.lock,
                          _lockDialog),
                    ]),
                    // Authentication Timer
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemDoubleLine(
                      context,
                      AppLocalization.of(context).autoLockHeader,
                      _curTimeoutSetting,
                      AppIcons.timer,
                      _lockTimeoutDialog,
                      disabled: _curUnlockSetting.setting == UnlockOption.NO,
                    ),
                    // Encrypt option
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          StateContainer.of(context).curTheme.backgroundDark,
                          StateContainer.of(context).curTheme.backgroundDark00
                        ],
                        begin: AlignmentDirectional(0.5, -1.0),
                        end: AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildInviteMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.backgroundDark,
        boxShadow: [
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30,
              offset: Offset(-5, 0),
              blurRadius: 20),
        ],
      ),
      child: SafeArea(
        minimum: EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            // Back button
            Container(
              margin: EdgeInsets.only(bottom: 10.0, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      //Back button
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: FlatButton(
                            highlightColor:
                                StateContainer.of(context).curTheme.text15,
                            splashColor:
                                StateContainer.of(context).curTheme.text15,
                            onPressed: () {
                              setState(() {
                                _inviteOpen = false;
                              });
                              _inviteController.reverse();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(8.0),
                            child: Icon(AppIcons.back,
                                color: StateContainer.of(context).curTheme.text,
                                size: 24)),
                      ),
                      //Security Header Text
                      Text(
                        AppLocalization.of(context).inviteHeader,
                        style: AppStyles.textStyleSettingsHeader(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                ListView(
                  padding: EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsetsDirectional.only(start: 30.0, bottom: 10),
                      child: Text(AppLocalization.of(context).manage,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color:
                                  StateContainer.of(context).curTheme.text60)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).invitationActivateTitle,
                        FontAwesome.check, onPressed: () {
                      Sheets.showAppHeightNineSheet(
                          context: context, widget: ActivateInvite());
                    }),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          StateContainer.of(context).curTheme.backgroundDark,
                          StateContainer.of(context).curTheme.backgroundDark00
                        ],
                        begin: AlignmentDirectional(0.5, -1.0),
                        end: AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }

  Future<void> authenticateWithPin() async {
    // PIN Authentication
    String expectedPin = await sl.get<Vault>().getPin();
    bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new PinScreen(
        PinOverlayType.ENTER_PIN,
        expectedPin: expectedPin,
        description: AppLocalization.of(context).pinSeedBackup,
      );
    }));
    if (auth != null && auth) {
      await Future.delayed(Duration(milliseconds: 200));
      Navigator.of(context).pop();
      StateContainer.of(context).getSeed().then((seed) {
        AppSeedBackupSheet(seed).mainBottomSheet(context);
      });
    }
  }
}
