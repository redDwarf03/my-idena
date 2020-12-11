import 'dart:async';

import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/backoffice/factory/connectivity_service.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/backoffice/factory/sharedPreferencesHelper.dart';
import 'package:my_idena/utils/util_demo_mode.dart';
import 'package:my_idena/utils/util_public_node.dart';

class ParamRPCView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ParamRPCView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ParamRPCViewState createState() => _ParamRPCViewState();
}

class _ParamRPCViewState extends State<ParamRPCView> {
  HttpService httpService = HttpService();
  var logger = Logger();
  final _keyFormParamRPC = GlobalKey<FormState>();
  String apiUrl;
  String keyApp;
  bool _keyAppVisible;
  bool _checkNodeConnection;
  StreamController _nodeController;
  TextEditingController apiUrlController = new TextEditingController();
  TextEditingController keyAppController = new TextEditingController();
  Timer _timer;
  var checkedValue = getPublicNode();

  @override
  void initState() {
    super.initState();
    _keyAppVisible = false;
    _nodeController = StreamController<bool>.broadcast();

    _timer = Timer.periodic(Duration(milliseconds: 500), (_) => checkNode());
  }

  Future checkNode() async {
    httpService
        .checkConnection(apiUrlController.text, keyAppController.text)
        .then((res) {
      if (!_nodeController.isClosed && _timer.isActive) {
        _nodeController.add(res);
        return res;
      }
    });
  }

  @override
  void dispose() {
    _nodeController.close();
    _timer.cancel();
    apiUrlController.dispose();
    keyAppController.dispose();
    super.dispose();
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
            apiUrlController.text =
                snapshot.data.apiUrl != null ? snapshot.data.apiUrl : "";
            keyAppController.text =
                snapshot.data.keyApp != null ? snapshot.data.keyApp : "";
            return AnimatedBuilder(
                animation: widget.animationController,
                builder: (BuildContext context, Widget child) {
                  return FadeTransition(
                    opacity: widget.animation,
                    child: Form(
                      key: _keyFormParamRPC,
                      child: new Transform(
                        transform: new Matrix4.translationValues(
                            0.0, 30 * (1.0 - widget.animation.value), 0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 16, bottom: 18),
                          child: Container(
                            decoration: BoxDecoration(
                              color: MyIdenaAppTheme.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                  topRight: Radius.circular(68.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color:
                                        MyIdenaAppTheme.grey.withOpacity(0.2),
                                    offset: Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 30, top: 8, bottom: 16),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ConnectivityService()
                                                    .getConnectionStatus(
                                                        context),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: CheckboxListTile(
                                                activeColor: Colors.black12,
                                                checkColor: Colors.green,
                                                title: Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          "Public node ?"),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                  ),
                                                ),
                                                value: checkedValue,
                                                onChanged: (newValue) {
                                                  if (newValue) {
                                                    apiUrlController.value =
                                                        TextEditingValue(
                                                            text: PN_URL_SLASH);
                                                  } else {
                                                    apiUrlController.value =
                                                        TextEditingValue(
                                                            text: "http://");
                                                  }
                                                  try {
                                                    IdenaSharedPreferences
                                                        _idenaSharedPreferences =
                                                        IdenaSharedPreferences(
                                                            apiUrlController
                                                                .text,
                                                            keyAppController
                                                                .text);
                                                    SharedPreferencesHelper
                                                        .setIdenaSharedPreferences(
                                                            _idenaSharedPreferences);
                                                    idenaSharedPreferences =
                                                        _idenaSharedPreferences;
                                                    initIdenaAddress();
                                                  } catch (e) {
                                                    logger.e(e.toString());
                                                  }
                                                  setState(() {
                                                    checkedValue = newValue;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: TextFormField(
                                                enableInteractiveSelection:
                                                    getPublicNode()
                                                        ? false
                                                        : true,
                                                enabled: getPublicNode()
                                                    ? false
                                                    : true,
                                                controller: apiUrlController,
                                                validator: (val) => val.isEmpty
                                                    ? AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            "Enter your API url")
                                                    : null,
                                                onChanged: (val) {
                                                  try {
                                                    IdenaSharedPreferences
                                                        _idenaSharedPreferences =
                                                        IdenaSharedPreferences(
                                                            apiUrlController
                                                                .text,
                                                            keyAppController
                                                                .text);
                                                    SharedPreferencesHelper
                                                        .setIdenaSharedPreferences(
                                                            _idenaSharedPreferences);
                                                    idenaSharedPreferences =
                                                        _idenaSharedPreferences;
                                                    initIdenaAddress();
                                                  } catch (e) {
                                                    logger.e(e.toString());
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                ),
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey[400],
                                                        width: 1.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF2F3F8),
                                                        width: 1.0),
                                                  ),
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 14.0),
                                                  prefixIcon: Icon(
                                                    FlevaIcons.link_2,
                                                    color: Colors.black54,
                                                  ),
                                                  hintText: AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                          "Enter your API url"),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: TextFormField(
                                                controller: keyAppController,
                                                validator: (val) => val.isEmpty
                                                    ? AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            "Enter your key app")
                                                    : null,
                                                onChanged: (val) {
                                                  try {
                                                    IdenaSharedPreferences
                                                        _idenaSharedPreferences =
                                                        IdenaSharedPreferences(
                                                            apiUrlController
                                                                .text,
                                                            keyAppController
                                                                .text);
                                                    SharedPreferencesHelper
                                                        .setIdenaSharedPreferences(
                                                            _idenaSharedPreferences);
                                                    idenaSharedPreferences =
                                                        _idenaSharedPreferences;
                                                    initIdenaAddress();
                                                  } catch (e) {
                                                    logger.e(e.toString());
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                obscureText: !_keyAppVisible,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                ),
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey[400],
                                                        width: 1.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF2F3F8),
                                                        width: 1.0),
                                                  ),
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 14.0),
                                                  prefixIcon: Icon(
                                                    Icons.vpn_key,
                                                    color: Colors.black54,
                                                  ),
                                                  hintText: AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                          "Enter your key app"),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _keyAppVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: Theme.of(context)
                                                          .primaryColorDark,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _keyAppVisible =
                                                            !_keyAppVisible;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            checkNodeConnection(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }

  Widget checkNodeConnection() {
    return new StreamBuilder(
        stream: _nodeController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _checkNodeConnection = snapshot.data;
            if (_checkNodeConnection) {
              return Text(
                AppLocalizations.of(context).translate("Connection to node ok"),
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontFamily: MyIdenaAppTheme.fontName,
                    letterSpacing: -0.2,
                    fontWeight: FontWeight.w500),
              );
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
        idenaAddress = "0xf429e36d68be10428d730784391589572ee0f72b";
      }
    }

    logger.i("Idena address loaded: " + idenaAddress);
  }
}
