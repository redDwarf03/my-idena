import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_idena/pages/about.dart';
import 'package:my_idena/pages/home.dart';
import 'package:my_idena/pages/flip_words.dart';
import 'package:my_idena/pages/validation_session..dart';
import 'package:my_idena/pages/paramRPC.dart';
import 'package:my_idena/utils/app_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('fr', 'FR'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: Home(),
        routes: <String, WidgetBuilder>{
          '/landingpage': (BuildContext context) => new MyApp(),
          '/home': (BuildContext context) => new Home(),
          '/flipWords': (BuildContext context) => new FlipWords(),
          '/validationSession': (BuildContext context) => new ValidationSession(),
          '/paramRPC': (BuildContext context) => new ParamRPC(),
          '/about': (BuildContext context) => new About(),
        },
    );
     
  }
}
