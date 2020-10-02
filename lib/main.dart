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
import 'package:my_idena/pages/screens/deep_link_screen.dart';
import 'package:my_idena/pages/screens/route_screen.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

DnaAll dnaAll = new DnaAll();
var logger = Logger();
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
  StreamSubscription _sub;
  UniLinksType _type = UniLinksType.string;
  String _latestLink = 'Unknown';
  Uri _latestUri;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  @override
  dispose() {
    if (_sub != null) _sub.cancel();
    super.dispose();
  }

  initPlatformState() async {
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    } else {
      await initPlatformStateForUriUniLinks();
    }
  }

  initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    _sub = getLinksStream().listen((String link) {
      if (!mounted) return;
      setState(() {
        _latestLink = link ?? 'Unknown';
        _latestUri = null;
        try {
          if (link != null) _latestUri = Uri.parse(link);
        } on FormatException {}
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestLink = 'Failed to get latest link: $err.';
        _latestUri = null;
      });
    });

    // Attach a second listener to the stream
    getLinksStream().listen((String link) {
      print('got link: $link');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest link
    String initialLink;
    Uri initialUri;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      print('initial link: $initialLink');
      if (initialLink != null) initialUri = Uri.parse(initialLink);
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
      initialUri = null;
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
      initialUri = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestLink = initialLink;
      _latestUri = initialUri;
    });
  }

  /// An implementation using the [Uri] convenience helpers
  initPlatformStateForUriUniLinks() async {
    // Attach a listener to the Uri links stream
    _sub = getUriLinksStream().listen((Uri uri) {
      if (!mounted) return;
      setState(() {
        _latestUri = uri;
        _latestLink = uri?.toString() ?? 'Unknown';
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestUri = null;
        _latestLink = 'Failed to get latest link: $err.';
      });
    });

    // Attach a second listener to the stream
    getUriLinksStream().listen((Uri uri) {
      print('got uri: ${uri?.path} ${uri?.queryParametersAll}');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest Uri
    Uri initialUri;
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialUri = await getInitialUri();
      print('initial uri: ${initialUri?.path}'
          ' ${initialUri?.queryParametersAll}');
      initialLink = initialUri?.toString();
    } on PlatformException {
      initialUri = null;
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialUri = null;
      initialLink = 'Bad parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestUri = initialUri;
      _latestLink = initialLink;
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = _latestUri?.queryParametersAll?.entries?.toList();
    if (list != null) {
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
      logger.i(
          "authentication_endpoint: " + deepLinkParam.authenticationEndpoint);
    }
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
          const Locale('en', ''),
          const Locale('fr', ''),
          const Locale('hr', ''),
          const Locale('ru', ''),
          const Locale('ja', ''),
          const Locale('es', ''),
          const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
          const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
          const Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn'),
          const Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Cyrl'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: MyIdenaAppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        home: list != null && list.length > 0
            ? new DeepLinkScreen(
                deepLinkParam: deepLinkParam,
              )
            : new RouteScreen(),
      ),
    );
  }
}
