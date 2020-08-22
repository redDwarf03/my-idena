import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/beans/deepLinkParam.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:my_idena/pages/screens/on_boarding_screen.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;
import 'package:logger/logger.dart';
import 'package:uni_links/uni_links.dart';

bool firstState = true;
DnaAll dnaAll;
String typeLaunchSession = EpochPeriod.ShortSession;
var logger = Logger();
String campaign = "v20200823.1";
bool checkFlipsQualityProcess = false;
DeepLinkParam deepLinkParam;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

enum UniLinksType { string, uri }

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  initState() {
    super.initState();
    // initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          Locale('en', ''),
          Locale('fr', ''),
          Locale('ru', ''),
          Locale('cn', 'SC'),
          Locale('cn', 'TC'),
          Locale('sr', ''),

        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: MyIdenaAppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        home: StreamBuilder(
          stream: getLinksStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var uri = Uri.parse(snapshot.data);
              var list = uri.queryParametersAll.entries.toList();
              deepLinkParam = new DeepLinkParam();
              for (var i = 0; i < list.length; i++) {
                switch (list[i].key) {
                  case "nonce_endpoint":
                    {
                      deepLinkParam.nonce_endpoint = list[i].value[0];
                    }
                    break;
                  case "token":
                    {
                      deepLinkParam.token = list[i].value[0];
                    }
                    break;
                  case "callback_url":
                    {
                      deepLinkParam.callback_url = list[i].value[0];
                    }
                    break;
                  case "authentication_endpoint":
                    {
                      deepLinkParam.authentication_endpoint = list[i].value[0];
                    }
                    break;
                }
              }
              logger.i("nonce_endpoint: " + deepLinkParam.nonce_endpoint);
              logger.i("token: " + deepLinkParam.token);
              logger.i("callback_url: " + deepLinkParam.callback_url);
              logger.i("authentication_endpoint: " +
                  deepLinkParam.authentication_endpoint);
              return Home();
            } else {
              return OnBoardingScreen();
            }
          },
        ));
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
