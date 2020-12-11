import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hex/hex.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/connectivity_service.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/backoffice/factory/sharedPreferencesHelper.dart';
import 'package:my_idena/beans/deepLinkParam.dart';
import 'package:my_idena/beans/dictWords.dart';
import 'package:my_idena/enums/connection_status.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/screens/deep_link_screen.dart';
import 'package:my_idena/pages/screens/route_screen.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/utils/crypto/cryptor.dart';
import 'package:my_idena/utils/crypto/hash.dart';
import 'package:my_idena/utils/util_demo_mode.dart';
import 'package:my_idena/utils/util_public_node.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/gcm.dart';
import 'package:provider/provider.dart';
import 'package:quartet/quartet.dart';
import 'package:sha3/sha3.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'package:uni_links/uni_links.dart';
import 'package:secp256k1/secp256k1.dart' as secp256k1;

DnaAll dnaAll = new DnaAll();
var logger = Logger();
DeepLinkParam deepLinkParam;
HttpService httpService = HttpService();
List wordsMap;
IdenaSharedPreferences idenaSharedPreferences;
String idenaAddress;
DictWords dictWords;

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
    initIdenaSharedPreferences();
    initWords();
  }

  @override
  dispose() {
    if (_sub != null) _sub.cancel();
    super.dispose();
  }

  initWords() async {
    Map<String, dynamic> dictWordsDdata;
    dictWords = await DictWords().getDictWords();
    dictWordsDdata = dictWords.toJson();
    wordsMap = dictWordsDdata["words"];
    logger.i("Nb words loaded: " + wordsMap.length.toString());
  }

  initIdenaSharedPreferences() async {
    await SharedPreferencesHelper.getIdenaSharedPreferences().then((value) {
      idenaSharedPreferences = value;
      initIdenaAddress();
    });
    logger
        .i("Idena Shared Preferences loaded: " + idenaSharedPreferences.apiUrl);
  }

  initIdenaAddress() async {
    if (getDemoModeStatus()) {
      idenaAddress = DM_IDENTITY_ADDRESS;
    } else {
      if (getPublicNode() == false) {
        idenaAddress = "";
        Uri url = Uri.parse(idenaSharedPreferences.apiUrl);
        await httpService
            .getDnaGetCoinbaseAddr(url, idenaSharedPreferences.keyApp)
            .then((value) => idenaAddress);
      } else {
        // TODO: A changer

       /* 

        var k = SHA3(256, SHA3_PADDING, 256);
        k.update(utf8.encode(mdp));
        var mdpHash = k.digest();
        print("** hash mdp " + HEX.encode(mdpHash));

        // ok
        var mdpArray = Uint8List.fromList(HEX.decode(HEX.encode(mdpHash)));
        print("** key : " + HEX.encode(mdpArray));

        // Data - ok
        var dataArray = Uint8List.fromList(HEX.decode(encPrivateKey));
        print("** dataArray : " + dataArray.toString());

        var dataArray0to12 = dataArray.sublist(0, 12);
        var dataArray0ToLength16 = dataArray.sublist(0, dataArray.length - 16);
        var dataArray12ToLength16 =
            dataArray.sublist(12, dataArray.length - 16);

        // Algorithm : String algorithm = "aes-256-gcm";
        // Key
        // const key = Buffer.from(sha3_256.array(passphrase));
        // Initialization vector - ok
        // dataArray0to12
        print("iv : " + HEX.encode(dataArray0to12));

        String plainText = encPrivateKey;
        String key = HEX.encode(mdpArray);
        String iv = HEX.encode(dataArray0to12);
        String decryptedString;

        //final decrypted = Cryptor.decrypt(encPrivateKey, key);
        //print("private decrypted : " + decrypted);
        var keyGen = CryptKey();
        var key32 = HEX.encode(mdpHash);
        var iv16 = HEX.encode(dataArray0to12);
        var aes = AesCrypt(key: key32, padding: PaddingAES.pkcs7);

        print('AES Symmetric GCM:');
        var crypted = aes.gcm.encrypt(inp: encPrivateKey, iv: iv16); //encrypt
        print(crypted);
        print(aes.gcm.decrypt(enc: encPrivateKey, iv: iv16)); //decrypt
        print('');

        String privateKeyDecrypted =
            "c51310620099d4939031ff990702f8027e38eeebcb4961547a91b63272d13376";
        // Privatkey decrypted
        var pk = secp256k1.PrivateKey.fromHex(privateKeyDecrypted);

        var pub = pk.publicKey;

        String sPubKey = "0x" + slice(pub.toHex(), 2);
        print("** sPubKey : " + sPubKey);
        //print("** adresse : 0x" + HEX.encode(keccak256(sPubKey)).substring(24));
        var m = SHA3(256, SHA3_PADDING, 256);
        m.update(utf8.encode(sPubKey));
        print("** adresse : 0x" + HEX.encode(k.digest()));
*/
        idenaAddress = "0xf429e36d68be10428d730784391589572ee0f72b";
      }
    }

    logger.i("Idena address loaded: " + idenaAddress);
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
          const Locale('id', ''),
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

  Uint8List createUint8ListFromHexString(String hex) {
    hex = hex.replaceAll(RegExp(r'\s'), ''); // remove all whitespace, if any

    var result = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < hex.length; i += 2) {
      var num = hex.substring(i, i + 2);
      var byte = int.parse(num, radix: 16);
      result[i ~/ 2] = byte;
    }
    return result;
  }
}
