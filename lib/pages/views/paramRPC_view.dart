import 'dart:async';

import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_idena/backoffice/factory/connectivity_service.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/sharedPreferencesHelper.dart';

class ParamRPCView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ParamRPCView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ParamRPCViewState createState() => _ParamRPCViewState();
}

class _ParamRPCViewState extends State<ParamRPCView> {
  final _keyFormParamRPC = GlobalKey<FormState>();
  String apiUrl;
  String keyApp;
  bool _keyAppVisible;
  bool _checkNodeConnection;
  StreamController _nodeController;
  TextEditingController apiUrlController = new TextEditingController();
  TextEditingController keyAppController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _keyAppVisible = false;
    _nodeController = StreamController<bool>.broadcast();

    Timer.periodic(Duration(milliseconds: 1000), (_) => checkNode());
  }

  Future checkNode() async {
    if (!_nodeController.isClosed) {
      httpService
          .checkConnection(apiUrlController.text, keyAppController.text)
          .then((res) {
        _nodeController.add(res);
        return res;
      });
    }
  }

  @override
  void dispose() {
    _nodeController.close();
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
                                                checkNodeConnection(),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: TextFormField(
                                                controller: apiUrlController,
                                                validator: (val) => val.isEmpty
                                                    ? AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            "Enter your API url")
                                                    : null,
                                                onChanged: (val) =>
                                                    apiUrl = val,
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
                                                onChanged: (val) =>
                                                    keyApp = val,
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: RaisedButton(
                                                elevation: 5.0,
                                                onPressed: () async {
                                                  if (_keyFormParamRPC
                                                      .currentState
                                                      .validate()) {
                                                    try {
                                                      await SharedPreferencesHelper
                                                          .setIdenaSharedPreferences(
                                                              IdenaSharedPreferences(
                                                                  apiUrl,
                                                                  keyApp));
                                                    } catch (e) {
                                                      logger.e(e.toString());
                                                    }
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (context) =>
                                                                SimpleDialog(
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            AppLocalizations.of(context).translate("Parameters have been saved"),
                                                                            style: TextStyle(
                                                                                fontFamily: MyIdenaAppTheme.fontName,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 16,
                                                                                letterSpacing: -0.1,
                                                                                color: MyIdenaAppTheme.darkText),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ));
                                                    setState(() {});
                                                  }
                                                },
                                                padding: EdgeInsets.all(15.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                color: Colors.white,
                                                child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate("Save"),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      letterSpacing: 1.5,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          MyIdenaAppTheme
                                                              .fontName,
                                                    )),
                                              ),
                                            ),
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
}
