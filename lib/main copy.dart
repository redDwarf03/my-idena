import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/connectivity_service.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/beans/deepLinkParam.dart';
import 'package:my_idena/enums/connection_status.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:my_idena/pages/screens/deep_link_screen.dart';
import 'package:my_idena/pages/screens/route_screen.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/utils/util_deepLinks.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

DnaAll dnaAll = new DnaAll();
var logger = Logger();
String campaign = "v20200831.1";
DeepLinkParam deepLinkParam;
HttpService httpService = HttpService();

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
    return StreamProvider<ConnectivityStatus>(
      create: (contextStream) =>
          ConnectivityService().connectionStatusController.stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          Locale('en', ''),
          Locale('fr', ''),
          Locale('ru', ''),
          Locale('cn', 'SC'),
          Locale('cn', 'TC'),
          Locale('sr', ''),
          Locale('sr', 'RS'),
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
                      deepLinkParam.nonceEndpoint = list[i].value[0];
                    }
                    break;
                  case "token":
                    {
                      deepLinkParam.token = list[i].value[0];
                    }
                    break;
                  case "callback_url":
                    {
                      deepLinkParam.callbackUrl = list[i].value[0];
                    }
                    break;
                  case "authentication_endpoint":
                    {
                      deepLinkParam.authenticationEndpoint = list[i].value[0];
                    }
                    break;
                }
              }
              logger.i("nonce_endpoint: " + deepLinkParam.nonceEndpoint);
              logger.i("token: " + deepLinkParam.token);
              logger.i("callback_url: " + deepLinkParam.callbackUrl);
              logger.i("authentication_endpoint: " +
                  deepLinkParam.authenticationEndpoint);
              return DeepLinkScreen(
                deepLinkParam: deepLinkParam,
              );
            } else {
              return RouteScreen();
            }
          },
        ),
      ),
    );
  }
}
