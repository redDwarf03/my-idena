import 'dart:async';
import 'dart:io';

import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/backoffice/factory/connectivity_service.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/backoffice/factory/sharedPreferencesHelper.dart';

Timer _timerCheckNode;

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int bottomSelectedIndex = 0;
  int nbPages;
  int numPage;
  final _keyForm = GlobalKey<FormState>();
  bool _keyAppVisible;
  bool _checkNodeConnection;
  TextEditingController apiUrlController = new TextEditingController();
  TextEditingController keyAppController = new TextEditingController();
  StreamController _nodeController;
  HttpService httpService = HttpService();
  var logger = Logger();

  @override
  void dispose() {
    pageController.dispose();
    apiUrlController.dispose();
    keyAppController.dispose();
    _nodeController.close();
    _timerCheckNode.cancel();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _keyAppVisible = false;
    _nodeController = StreamController<bool>.broadcast();

    _timerCheckNode =
        Timer.periodic(Duration(milliseconds: 1000), (_) => checkNode());

    Platform.isAndroid ? nbPages = 4 : nbPages = 3;
  }

  Future checkNode() async {
    httpService
        .checkConnection(apiUrlController.text, keyAppController.text)
        .then((res) {
      if (!_nodeController.isClosed && _timerCheckNode.isActive) {
        _nodeController.add(res);
        return res;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<IdenaSharedPreferences>(
        future: SharedPreferencesHelper.getIdenaSharedPreferences(),
        builder: (BuildContext context,
            AsyncSnapshot<IdenaSharedPreferences> snapshot) {
          if (snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator());
          } else {
            numPage = 1;
            apiUrlController.text =
                snapshot.data.apiUrl != null ? snapshot.data.apiUrl : "";
            keyAppController.text =
                snapshot.data.keyApp != null ? snapshot.data.keyApp : "";
            return Form(
              key: _keyForm,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    bottomSelectedIndex = index;
                  });
                },
                children: <Widget>[
                  _welcome(index: numPage++),
                  if (Platform.isAndroid) _connectAndroid(index: numPage++),
                  _getPageUrlApi(index: numPage++, contextStream: context),
                  _getPageKeyApp(index: numPage++, contextStream: context),
                ],
              ),
            );
          }
        });
  }

  _welcome({int index}) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
              top: 80.0, left: 8.0, right: 8.0, bottom: 8.0),
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/img_idena_intro.png'),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context).translate("Welcome !"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: MyIdenaAppTheme.fontName,
                    letterSpacing: -0.2,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              _getPageIndicator(index, Colors.white54, Colors.white),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context).translate(
                    "Idena is the first proof-of-person blockchain where every node belongs to a certain individual and has equal voting power. It is one of the most decentralized blockchains.\n\n"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: MyIdenaAppTheme.fontName,
                    letterSpacing: -0.2),
              ),
              Text(
                AppLocalizations.of(context).translate(
                    "Idena's network of validated people solves the blockchain oracle problem: Its independent mining nodes can act as oracles. To formalize a unique human, Idena does not require the disclosure of any personal data (no KYC). It proves the humanness and uniqueness of its participants by running an AI-hard Turing test at the same time for everyone around the globe."),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: MyIdenaAppTheme.fontName,
                    letterSpacing: -0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _connectAndroid({int index}) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
              top: 80.0, left: 8.0, right: 8.0, bottom: 8.0),
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/img_android-settings.png'),
              SizedBox(
                height: 40,
              ),
              Text(
                "Connect the app to your VPS node using ssh tunnel",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: MyIdenaAppTheme.fontName,
                    letterSpacing: -0.2,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              _getPageIndicator(index, Colors.white54, Colors.white),
              SizedBox(
                height: 20,
              ),
              Text(
                "1. Install Termux app from Google Play\n\n2. Open Termux app, run two commands to install openssh and sshpass:\npkg install openssh\npkg install sshpass\n\n3. Make a test connection to accept VPS fingerprint\nssh root@YOUR_VPS_IP\ntype 'yes'\nafter that it will ask you to enter password to login to your vps, you can just minimize app and exit it from notification\n\n4. Make a connection script, run Termux again\nnano conn.sh\n- type next line for connection\nsshpass -p YOUR_VPS_PASS ssh -L 9999:localhost:9009 root@YOUR_VPS_IP\nCtrl+X - exit nano\nS - confirm save\n\n5. Make connection script executable\nchmod +x conn.sh\n\n6. Run your connection script\n./conn.sh\n\nNow you can connect my_idena app to your node on vps by entering\nNode address: http://localhost:9999\nApi key: YOUR_API_KEY\n\n",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: MyIdenaAppTheme.fontName,
                    letterSpacing: -0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getPageUrlApi({int index, BuildContext contextStream}) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
              top: 80.0, left: 8.0, right: 8.0, bottom: 8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Image.asset('assets/images/img_ip.png'),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context).translate("Type your\nurl api"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: MyIdenaAppTheme.fontName,
                    letterSpacing: -0.2,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              _getPageIndicator(index, Colors.white54, Colors.white),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context).translate(
                    "Please, type http://{ip_address}:{port_number}\nto connect to your node"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: MyIdenaAppTheme.fontName,
                    letterSpacing: -0.2),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConnectivityService().getConnectionStatus(contextStream),
                ],
              ),
              TextFormField(
                cursorColor: Colors.white,
                controller: apiUrlController,
                validator: (val) => val.isEmpty
                    ? AppLocalizations.of(context)
                        .translate("Enter your API url")
                    : null,
                onChanged: (val) {
                  try {
                    SharedPreferencesHelper.setIdenaSharedPreferences(
                        IdenaSharedPreferences(
                            apiUrlController.text, keyAppController.text));
                  } catch (e) {
                    logger.e(e.toString());
                  }
                },
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: MyIdenaAppTheme.fontName,
                  letterSpacing: -0.2,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400], width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF2F3F8), width: 1.0),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    FlevaIcons.link_2,
                    color: Colors.white54,
                  ),
                  hintText: AppLocalizations.of(context)
                      .translate("Enter your API url"),
                ),
              ),
              checkNodeConnection(),
            ],
          ),
        ),
      ),
    );
  }

  _getPageKeyApp({int index, BuildContext contextStream}) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
                top: 80.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/img_key.png'),
                Text(
                  AppLocalizations.of(context).translate("Type your\nkey app"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: MyIdenaAppTheme.fontName,
                      letterSpacing: -0.2,
                      fontSize: 35,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                _getPageIndicator(index, Colors.white54, Colors.white),
                SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context).translate(
                      "Please, type the api.key (cf \\datadir\\api.key file)"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: MyIdenaAppTheme.fontName,
                      letterSpacing: -0.2),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConnectivityService().getConnectionStatus(contextStream),
                  ],
                ),
                TextFormField(
                  controller: keyAppController,
                  validator: (val) => val.isEmpty
                      ? AppLocalizations.of(context)
                          .translate("Enter your key app")
                      : null,
                  onChanged: (val) {
                    try {
                      SharedPreferencesHelper.setIdenaSharedPreferences(
                          IdenaSharedPreferences(
                              apiUrlController.text, keyAppController.text));
                    } catch (e) {
                      logger.e(e.toString());
                    }
                  },
                  keyboardType: TextInputType.text,
                  obscureText: !_keyAppVisible,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: MyIdenaAppTheme.fontName,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[400], width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFF2F3F8), width: 1.0),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.white54,
                    ),
                    hintText: AppLocalizations.of(context)
                        .translate("Enter your key app"),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _keyAppVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _keyAppVisible = !_keyAppVisible;
                        });
                      },
                    ),
                  ),
                ),
                checkNodeConnection(),
              ],
            ),
          ),
        ));
  }

  _getPageIndicator(index, Color colorsSelected, Color colorsByDefault) {
    if (nbPages == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: index == 1 ? 16 : 6,
            height: 6,
            decoration: BoxDecoration(
                color: index == 1 ? colorsByDefault : colorsSelected,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: index == 2 ? 16 : 6,
            height: 6,
            decoration: BoxDecoration(
                color: index == 2 ? colorsByDefault : colorsSelected,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: index == 3 ? 16 : 6,
            height: 6,
            decoration: BoxDecoration(
                color: index == 3 ? colorsByDefault : colorsSelected,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: index == 1 ? 16 : 6,
            height: 6,
            decoration: BoxDecoration(
                color: index == 1 ? colorsByDefault : colorsSelected,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: index == 2 ? 16 : 6,
            height: 6,
            decoration: BoxDecoration(
                color: index == 2 ? colorsByDefault : colorsSelected,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: index == 3 ? 16 : 6,
            height: 6,
            decoration: BoxDecoration(
                color: index == 3 ? colorsByDefault : colorsSelected,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: index == 4 ? 16 : 6,
            height: 6,
            decoration: BoxDecoration(
                color: index == 4 ? colorsByDefault : colorsSelected,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      );
    }
  }

  Widget checkNodeConnection() {
    return new StreamBuilder(
        stream: _nodeController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _checkNodeConnection = snapshot.data;
            if (_checkNodeConnection) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              });
              return Container();
            } else {
              return Text(
                AppLocalizations.of(context).translate(
                    "Connection to node ko. Please check your settings."),
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontFamily: MyIdenaAppTheme.fontName,
                    letterSpacing: -0.2,
                    fontWeight: FontWeight.w500),
              );
            }
          } else {
            _checkNodeConnection = false;
            return Text(
              AppLocalizations.of(context).translate(
                  "Connection to node ko. Please check your settings."),
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontFamily: MyIdenaAppTheme.fontName,
                  letterSpacing: -0.2,
                  fontWeight: FontWeight.w500),
            );
          }
        });
  }
}
