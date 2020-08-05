import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FutureBuilder<IdenaSharedPreferences>(
            future: SharedPreferencesHelper.getIdenaSharedPreferences(),
            builder: (BuildContext context,
                AsyncSnapshot<IdenaSharedPreferences> snapshot) {
              if (snapshot.hasData == false) {
                return Center(child: CircularProgressIndicator());
              } else {
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
                                  color: MyIdenaAppTheme.grey.withOpacity(0.2),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, top: 8, bottom: 16),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: TextFormField(
                                              controller: initialValue(
                                                  snapshot.data.apiUrl == null
                                                      ? ''
                                                      : snapshot.data.apiUrl),
                                              validator: (val) => val.isEmpty
                                                  ? AppLocalizations.of(context)
                                                      .translate(
                                                          "Enter your API url")
                                                  : null,
                                              onChanged: (val) => apiUrl = val,
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'OpenSans',
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
                                                      color: Color(0xFFF2F3F8),
                                                      width: 1.0),
                                                ),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.only(top: 14.0),
                                                prefixIcon: Icon(
                                                  Icons.blur_on,
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
                                              controller: initialValue(
                                                  snapshot.data.keyApp == null
                                                      ? ''
                                                      : snapshot.data.keyApp),
                                              validator: (val) => val.isEmpty
                                                  ? AppLocalizations.of(context)
                                                      .translate(
                                                          "Enter your key app")
                                                  : null,
                                              onChanged: (val) => keyApp = val,
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'OpenSans',
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
                                                      color: Color(0xFFF2F3F8),
                                                      width: 1.0),
                                                ),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.only(top: 14.0),
                                                prefixIcon: Icon(
                                                  Icons.vpn_key,
                                                  color: Colors.black54,
                                                ),
                                                hintText: AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        "Enter your key app"),
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
                                                                keyApp,
                                                                null));
                                                  } catch (e) {
                                                    print(e.toString());
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
                                                                          AppLocalizations.of(context)
                                                                              .translate("Parameters have been saved"),
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
                                                    BorderRadius.circular(30.0),
                                              ),
                                              color: Colors.white,
                                              child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate("Save"),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    letterSpacing: 1.5,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'OpenSans',
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24,
                                                right: 24,
                                                top: 8,
                                                bottom: 8),
                                            child: Container(
                                              height: 2,
                                              decoration: BoxDecoration(
                                                color:
                                                    MyIdenaAppTheme.background,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(context).translate(
                                                "Simulation mode enables functions normally available only during validation sessions."),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily:
                                                  MyIdenaAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: -0.2,
                                              color: MyIdenaAppTheme.darkText,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Container(
                                              height: 4,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: HexColor('#000000')
                                                    .withOpacity(0.2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 70,
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            HexColor('#000000')
                                                                .withOpacity(
                                                                    0.1),
                                                            HexColor('#000000'),
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: SwitchListTile(
                                              title: Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        "Simulation mode"),
                                                style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: MyIdenaAppTheme
                                                        .darkText),
                                              ),
                                              value: snapshot.data
                                                          .simulationMode ==
                                                      null
                                                  ? ''
                                                  : snapshot
                                                      .data.simulationMode,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  SharedPreferencesHelper
                                                      .setIdenaSharedPreferencesSimulationMode(
                                                          value);
                                                });
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Home()));
                                              },
                                              activeTrackColor:
                                                  Colors.green[100],
                                              activeColor: Colors.green[300],
                                              secondary: const Icon(
                                                Icons.build,
                                                color: Colors.white,
                                              ),
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
              }
            });
      },
    );
  }

  initialValue(val) {
    return TextEditingController(text: val);
  }
}
