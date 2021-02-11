import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/model/available_language.dart';
import 'package:my_idena/network/model/dictWords.dart';
import 'package:my_idena/themes.dart';
import 'package:my_idena/ui/before_scan_screen.dart';
import 'package:my_idena/ui/createFlips/creation_flips_step_1.dart';
import 'package:my_idena/ui/createFlips/creation_flips_step_2.dart';
import 'package:my_idena/ui/createFlips/creation_flips_step_3.dart';
import 'package:my_idena/ui/createFlips/creation_flips_step_4.dart';
import 'package:my_idena/ui/intro/intro_backup_seed.dart';
import 'package:my_idena/ui/intro/intro_import_seed.dart';
import 'package:my_idena/ui/settings/configure_access_node.dart';
import 'package:my_idena/ui/password_lock_screen.dart';
import 'package:my_idena/ui/validation_session/validation_session_step_1.dart';
import 'package:my_idena/ui/validation_session/validation_session_step_2.dart';
import 'package:my_idena/ui/validation_session/validation_session_step_3.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/ui/home_page.dart';
import 'package:my_idena/ui/lock_screen.dart';
import 'package:my_idena/ui/intro/intro_welcome.dart';
import 'package:my_idena/ui/intro/intro_backup_confirm.dart';
import 'package:my_idena/ui/util/routes.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/util/app_ffi/apputil.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:root_checker/root_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Setup Service Provide
  setupServiceLocator();
  // Setup logger, only show warning and higher in release mode.
  if (kReleaseMode) {
    Logger.level = Level.warning;
  } else {
    Logger.level = Level.debug;
  }
  // Run app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new StateContainer(child: new App()));
  });
}

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    setListWords();
    super.initState();
  }

  void setListWords() async {
    var dictWords = await DictWords().getDictWords();
    setState(() {
      StateContainer.of(context).dictWords = dictWords;
      print("Nb words loaded: " +
          StateContainer.of(context).dictWords.words.length.toString());
    });
  }

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        StateContainer.of(context).curTheme.statusBar);
    return OKToast(
      textStyle: AppStyles.textStyleSnackbar(context),
      backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'my Idena',
        darkTheme: ThemeData(
          dialogBackgroundColor:
              StateContainer.of(context).curTheme.backgroundDark,
          primaryColor: StateContainer.of(context).curTheme.primary,
          accentColor: StateContainer.of(context).curTheme.primary10,
          backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
          fontFamily: StateContainer.of(context).curTheme.fontFamily,
          brightness: StateContainer.of(context).curTheme.brightness,
        ),
        theme: ThemeData(
          dialogBackgroundColor:
              StateContainer.of(context).curTheme.backgroundDark,
          primaryColor: StateContainer.of(context).curTheme.primary,
          accentColor: StateContainer.of(context).curTheme.primary10,
          backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
          fontFamily: StateContainer.of(context).curTheme.fontFamily,
          brightness: StateContainer.of(context).curTheme.brightness,
        ),
        localizationsDelegates: [
          AppLocalizationsDelegate(StateContainer.of(context).curLanguage),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: StateContainer.of(context).curLanguage == null ||
                StateContainer.of(context).curLanguage.language ==
                    AvailableLanguage.DEFAULT
            ? null
            : StateContainer.of(context).curLanguage.getLocale(),
        supportedLocales: [
          const Locale('en', 'US'), // English
          // Currency-default requires country included
          const Locale("es", "AR"),
          const Locale("en", "AU"),
          const Locale("pt", "BR"),
          const Locale("en", "CA"),
          const Locale("de", "CH"),
          const Locale("es", "CL"),
          const Locale("zh", "CN"),
          const Locale("cs", "CZ"),
          const Locale("da", "DK"),
          const Locale("fr", "FR"),
          const Locale("en", "GB"),
          const Locale("zh", "HK"),
          const Locale("hu", "HU"),
          const Locale("id", "ID"),
          const Locale("he", "IL"),
          const Locale("hi", "IN"),
          const Locale("ja", "JP"),
          const Locale("ko", "KR"),
          const Locale("es", "MX"),
          const Locale("ta", "MY"),
          const Locale("en", "NZ"),
          const Locale("tl", "PH"),
          const Locale("ur", "PK"),
          const Locale("pl", "PL"),
          const Locale("ru", "RU"),
          const Locale("sv", "SE"),
          const Locale("zh", "SG"),
          const Locale("th", "TH"),
          const Locale("tr", "TR"),
          const Locale("en", "TW"),
          const Locale("es", "VE"),
          const Locale("en", "ZA"),
          const Locale("en", "US"),
          const Locale("es", "AR"),
          const Locale("de", "AT"),
          const Locale("fr", "BE"),
          const Locale("de", "BE"),
          const Locale("nl", "BE"),
          const Locale("tr", "CY"),
          const Locale("et", "EE"),
          const Locale("fi", "FI"),
          const Locale("fr", "FR"),
          const Locale("el", "GR"),
          const Locale("es", "AR"),
          const Locale("en", "IE"),
          const Locale("it", "IT"),
          const Locale("es", "AR"),
          const Locale("lv", "LV"),
          const Locale("lt", "LT"),
          const Locale("fr", "LU"),
          const Locale("en", "MT"),
          const Locale("nl", "NL"),
          const Locale("pt", "PT"),
          const Locale("sk", "SK"),
          const Locale("sl", "SI"),
          const Locale("es", "ES"),
          const Locale("ar", "AE"), // UAE
          const Locale("ar", "SA"), // Saudi Arabia
          const Locale("ar", "KW"), // Kuwait
        ],
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return NoTransitionRoute(
                builder: (_) => Splash(),
                settings: settings,
              );
            case '/home':
              return NoTransitionRoute(
                builder: (_) =>
                    AppHomePage(priceConversion: settings.arguments),
                settings: settings,
              );
            case '/home_transition':
              return NoPopTransitionRoute(
                builder: (_) =>
                    AppHomePage(priceConversion: settings.arguments),
                settings: settings,
              );
            case '/intro_welcome':
              return NoTransitionRoute(
                builder: (_) => IntroWelcomePage(),
                settings: settings,
              );
            case '/configure_access_node':
              return MaterialPageRoute(
                builder: (_) => ConfigureAccessNodePage(),
                settings: settings,
              );
            case '/intro_backup':
              return MaterialPageRoute(
                builder: (_) =>
                    IntroBackupSeedPage(encryptedSeed: settings.arguments),
                settings: settings,
              );
            case '/intro_backup_confirm':
              return MaterialPageRoute(
                builder: (_) => IntroBackupConfirm(),
                settings: settings,
              );
            case '/lock_screen':
              return NoTransitionRoute(
                builder: (_) => AppLockScreen(),
                settings: settings,
              );
            case '/lock_screen_transition':
              return MaterialPageRoute(
                builder: (_) => AppLockScreen(),
                settings: settings,
              );
            case '/password_lock_screen':
              return NoTransitionRoute(
                builder: (_) => AppPasswordLockScreen(),
                settings: settings,
              );
            case '/before_scan_screen':
              return NoTransitionRoute(
                builder: (_) => BeforeScanScreen(),
                settings: settings,
              );
            case '/intro_import':
              return MaterialPageRoute(
                builder: (_) => IntroImportSeedPage(),
                settings: settings,
              );
            case '/validation_session_step_1':
              return NoTransitionRoute(
                builder: (_) => ValidationSessionStep1Page(
                    simulationMode: settings.arguments),
                settings: settings,
              );
            case '/validation_session_step_2':
              return NoTransitionRoute(
                builder: (_) => ValidationSessionStep2Page(
                    simulationMode: settings.arguments),
                settings: settings,
              );
            case '/validation_session_step_3':
              var map = Map<String, dynamic>.from(settings.arguments);
              return NoTransitionRoute(
                builder: (_) => ValidationSessionStep3Page(
                  simulationMode: map['simulationMode'],
                  paramValidationSessionInfo: map['validationSessionInfo'],
                ),
                settings: settings,
              );
            case '/creation_flips_step_1':
              return NoTransitionRoute(
                builder: (_) => CreationFlipsStep1Page(
                    flipKeyWordPairs: settings.arguments),
                settings: settings,
              );
            case '/creation_flips_step_2':
              var map = Map<String, dynamic>.from(settings.arguments);
              return NoTransitionRoute(
                builder: (_) => CreationFlipsStep2Page(
                  word1: map['word1'],
                  word2: map['word2'],
                ),
                settings: settings,
              );
            case '/creation_flips_step_3':
              var map = Map<String, dynamic>.from(settings.arguments);
              return NoTransitionRoute(
                builder: (_) => CreationFlipsStep3Page(
                  imgToDisplay_1: map['imgToDisplay_1'],
                  imgToDisplay_2: map['imgToDisplay_2'],
                  imgToDisplay_3: map['imgToDisplay_3'],
                  imgToDisplay_4: map['imgToDisplay_4'],
                ),
                settings: settings,
              );
            case '/creation_flips_step_4':
              var map = Map<String, dynamic>.from(settings.arguments);
              return NoTransitionRoute(
                builder: (_) => CreationFlipsStep4Page(
                  imgToDisplay_1: map['imgToDisplay_1'],
                  imgToDisplay_2: map['imgToDisplay_2'],
                  imgToDisplay_3: map['imgToDisplay_3'],
                  imgToDisplay_4: map['imgToDisplay_4'],
                  imgToDisplayMixed_1: map['imgToDisplayMixed_1'],
                  imgToDisplayMixed_2: map['imgToDisplayMixed_2'],
                  imgToDisplayMixed_3: map['imgToDisplayMixed_3'],
                  imgToDisplayMixed_4: map['imgToDisplayMixed_4'],
                ),
                settings: settings,
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}

/// Splash
/// Default page route that determines if user is logged in and routes them appropriately.
class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with WidgetsBindingObserver {
  bool _hasCheckedLoggedIn;
  bool _retried;

  Future checkLoggedIn() async {
    // Check if device is rooted or jailbroken, show user a warning informing them of the risks if so
    if (!(await sl.get<SharedPrefsUtil>().getHasSeenRootWarning()) &&
        (await RootChecker.isDeviceRooted)) {
      AppDialogs.showConfirmDialog(
          context,
          CaseChange.toUpperCase(AppLocalization.of(context).warning, context),
          AppLocalization.of(context).rootWarning,
          AppLocalization.of(context).iUnderstandTheRisks.toUpperCase(),
          () async {
            await sl.get<SharedPrefsUtil>().setHasSeenRootWarning();
            checkLoggedIn();
          },
          cancelText: AppLocalization.of(context).exit.toUpperCase(),
          cancelAction: () {
            if (Platform.isIOS) {
              exit(0);
            } else {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          });
      return;
    }
    if (!_hasCheckedLoggedIn) {
      _hasCheckedLoggedIn = true;
    } else {
      return;
    }
    try {
      // iOS key store is persistent, so if this is first launch then we will clear the keystore
      bool firstLaunch = await sl.get<SharedPrefsUtil>().getFirstLaunch();
      if (firstLaunch) {
        await sl.get<Vault>().deleteAll();
      }
      await sl.get<SharedPrefsUtil>().setFirstLaunch();
      // See if logged in already
      bool isLoggedIn = false;
      bool isEncrypted = false;
      var pin = await sl.get<Vault>().getPin();
      if (pin != null) {
        isLoggedIn = true;
      }

      if (isLoggedIn) {
        if (isEncrypted) {
          Navigator.of(context).pushReplacementNamed('/password_lock_screen');
        } else if (await sl.get<SharedPrefsUtil>().getLock() ||
            await sl.get<SharedPrefsUtil>().shouldLock()) {
          Navigator.of(context).pushReplacementNamed('/lock_screen');
        } else {
          await AppUtil().loginAccount(context);
          PriceConversion conversion =
              await sl.get<SharedPrefsUtil>().getPriceConversion();
          Navigator.of(context)
              .pushReplacementNamed('/home', arguments: conversion);
        }
      } else {
        Navigator.of(context).pushReplacementNamed('/intro_welcome');
      }
    } catch (e) {
      /// Fallback secure storage
      /// A very small percentage of users are encountering issues writing to the
      /// Android keyStore using the flutter_secure_storage plugin.
      ///
      /// Instead of telling them they are out of luck, this is an automatic "fallback"
      /// It will generate a 64-byte secret using the native android "bottlerocketstudios" Vault
      /// This secret is used to encrypt sensitive data and save it in SharedPreferences
      if (Platform.isAndroid && e.toString().contains("flutter_secure")) {
        if (!(await sl.get<SharedPrefsUtil>().useLegacyStorage())) {
          await sl.get<SharedPrefsUtil>().setUseLegacyStorage();
          checkLoggedIn();
        }
      } else {
        await sl.get<Vault>().deleteAll();
        await sl.get<SharedPrefsUtil>().deleteAll();
        if (!_retried) {
          _retried = true;
          _hasCheckedLoggedIn = false;
          checkLoggedIn();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hasCheckedLoggedIn = false;
    _retried = false;
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => checkLoggedIn());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Account for user changing locale when leaving the app
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        setLanguage();
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  void setLanguage() {
    setState(() {
      StateContainer.of(context).deviceLocale = Localizations.localeOf(context);
    });
    sl.get<SharedPrefsUtil>().getLanguage().then((setting) {
      setState(() {
        StateContainer.of(context).updateLanguage(setting);
      });
    });
  }

  void setBrightnessMode() {
    setState(() {
      StateContainer.of(context).curTheme = MediaQuery.of(context).platformBrightness == Brightness.dark ? IdenaDarkTheme() : IdenaTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This seems to be the earliest place we can retrieve the device Locale
    setLanguage();
    setBrightnessMode();
    sl
        .get<SharedPrefsUtil>()
        .getCurrency(StateContainer.of(context).deviceLocale)
        .then((currency) {
      StateContainer.of(context).curCurrency = currency;
    });
    return new Scaffold(
      backgroundColor: StateContainer.of(context).curTheme.background,
    );
  }
}
