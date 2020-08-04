import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_idena/beans/rpc/dna_all.dart';
import 'package:my_idena/beans/rpc/httpService.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';

DnaAll dnaAll;
HttpService httpService = HttpService();

class ProfileView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ProfileView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}


class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FutureBuilder(
            future: httpService.getDnaAll(),
            builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
              if (snapshot.hasData) {
                dnaAll = snapshot.data;
                if (dnaAll == null || dnaAll.dnaIdentityResponse == null) {
                  return Text("Go to param");
                } else {
                  return FadeTransition(
                    opacity: widget.animation,
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
                                    top: 16, left: 16, right: 24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 8, top: 16),
                                      child: Text(
                                        'Mining',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily:
                                                MyIdenaAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color: MyIdenaAppTheme.darkText),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Switch(
                                              value: dnaAll.dnaIdentityResponse.result.online,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (dnaAll.dnaIdentityResponse.result.online) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            _boiteDeDialogueStopMining(
                                                                context));
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            _boiteDeDialogueStartMining(
                                                                context));
                                                  }
                                                });
                                              },
                                              activeTrackColor:
                                                  Colors.green[100],
                                              activeColor: Colors.green[300],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.access_time,
                                                  color: MyIdenaAppTheme.grey
                                                      .withOpacity(0.5),
                                                  size: 16,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Text(
                                                    new DateFormat.yMd()
                                                        .add_jm()
                                                        .format(dnaAll
                                                            .dnaGetEpochResponse
                                                            .result
                                                            .nextValidation),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          MyIdenaAppTheme
                                                              .fontName,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: 0.0,
                                                      color: MyIdenaAppTheme
                                                          .grey
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4, bottom: 14),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        "Next validation"),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  letterSpacing: 0.0,
                                                  color: MyIdenaAppTheme
                                                      .nearlyDarkBlue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, top: 8, bottom: 8),
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: MyIdenaAppTheme.background,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                              ),
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
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("Address"),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  MyIdenaAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
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
                                            child: Text(
                                              dnaAll.dnaIdentityResponse.result
                                                  .address,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    MyIdenaAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                color: MyIdenaAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, top: 8, bottom: 8),
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: MyIdenaAppTheme.background,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                              ),
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
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("Age"),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  MyIdenaAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
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
                                            child: Text(
                                              dnaAll.dnaIdentityResponse.result
                                                  .age
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    MyIdenaAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: MyIdenaAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate("Epoch"),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.2,
                                                  color:
                                                      MyIdenaAppTheme.darkText,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Container(
                                                  height: 4,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#000000')
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 70,
                                                        height: 4,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                HexColor(
                                                                        '#000000')
                                                                    .withOpacity(
                                                                        0.1),
                                                                HexColor(
                                                                    '#000000'),
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.0)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  (dnaAll.dnaGetEpochResponse
                                                                  .result.epoch -
                                                              dnaAll
                                                                  .dnaIdentityResponse
                                                                  .result
                                                                  .age)
                                                          .toString() +
                                                      " - " +
                                                      dnaAll.dnaGetEpochResponse
                                                          .result.epoch
                                                          .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: MyIdenaAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate("State"),
                                                style: TextStyle(
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.2,
                                                  color:
                                                      MyIdenaAppTheme.darkText,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0, top: 4),
                                                child: Container(
                                                  height: 4,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#000000')
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 70,
                                                        height: 4,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                HexColor(
                                                                        '#000000')
                                                                    .withOpacity(
                                                                        0.1),
                                                                HexColor(
                                                                    '#000000'),
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.0)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  dnaAll.dnaIdentityResponse
                                                      .result.state,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: MyIdenaAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });
      },
    );
  }

  Widget _boiteDeDialogueStopMining(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                  AppLocalizations.of(context)
                      .translate("Deactivate mining status"),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  AppLocalizations.of(context).translate(
                      "Submit the form to deactivate your mining status."),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  )),
              SizedBox(height: 20.0),
              Text(
                  AppLocalizations.of(context)
                      .translate("You can activate it again afterwards."),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  )),
              SizedBox(height: 10.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                      child: Text(
                        AppLocalizations.of(context).translate("Submit"),
                      ),
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        httpService.becomeOffline();
                        setState(() {
                          Navigator.pop(context);
                        });
                      }),
                  FlatButton(
                      child: Text(
                        AppLocalizations.of(context).translate("Cancel"),
                      ),
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      })
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _boiteDeDialogueStartMining(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                  AppLocalizations.of(context)
                      .translate("Activate mining status"),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  AppLocalizations.of(context).translate(
                      "Submit the form to start mining. Your node has to be online unless you deactivate your status. Otherwise penalties might be charged after being offline more than 1 hour."),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  )),
              SizedBox(height: 20.0),
              Text(
                  AppLocalizations.of(context).translate(
                      "You can deactivate your online status at any time."),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  )),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                      child: Text(
                        AppLocalizations.of(context).translate("Submit"),
                      ),
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        setState(() {
                          httpService.becomeOnline();
                          Navigator.pop(context);
                        });

                      }),
                  FlatButton(
                      child: Text(
                        AppLocalizations.of(context).translate("Cancel"),
                      ),
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      })
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
