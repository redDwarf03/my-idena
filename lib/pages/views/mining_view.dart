import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_hexcolor.dart';
import 'package:my_idena/utils/util_identity.dart';

class MiningView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final bool firstState;

  const MiningView(
      {Key key, this.animationController, this.animation, this.firstState})
      : super(key: key);

  @override
  _MiningViewState createState() => _MiningViewState();
}

class _MiningViewState extends State<MiningView> {
  bool miningSwitchValue;
  bool firstStateForView;
  HttpService httpService = new HttpService();
  DnaAll dnaAll;

  @override
  void initState() {
    firstStateForView = widget.firstState;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: httpService.getDnaAll(),
        builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
          if (snapshot.hasData) {
            dnaAll = snapshot.data;
            if (dnaAll == null || dnaAll.dnaIdentityResponse == null) {
              return Text("");
            } else {
              if (firstStateForView) {
                miningSwitchValue = dnaAll.dnaIdentityResponse.result.online;
                firstStateForView = false;
              }

              return AnimatedBuilder(
                  animation: widget.animationController,
                  builder: (BuildContext context, Widget child) {
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
                                      left: 4, right: 24, top: 0, bottom: 5),
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
                                              padding: const EdgeInsets.only(
                                                  left: 6,
                                                  right: 10,
                                                  top: 16,
                                                  bottom: 14),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  UtilIdentity().canMine(
                                                              dnaAll) ==
                                                          true
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 0,
                                                                        bottom:
                                                                            2),
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "Mining"),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontFamily: MyIdenaAppTheme
                                                                          .fontName,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16,
                                                                      letterSpacing:
                                                                          -0.1,
                                                                      color: MyIdenaAppTheme
                                                                          .darkText),
                                                                ),
                                                              ),
                                                              displayMiningSwitch(),
                                                              displayPenalty(),
                                                            ])
                                                      : Row(children: <Widget>[
                                                          Expanded(
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "Your current status doesn't allow you to mine."),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        MyIdenaAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    letterSpacing:
                                                                        -0.2,
                                                                    color: MyIdenaAppTheme
                                                                        .darkText,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 4),
                                                                  child:
                                                                      Container(
                                                                    height: 4,
                                                                    width: 90,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: HexColor(
                                                                              '#000000')
                                                                          .withOpacity(
                                                                              0.2),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(4.0)),
                                                                    ),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          width:
                                                                              90,
                                                                          height:
                                                                              4,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            gradient:
                                                                                LinearGradient(colors: [
                                                                              HexColor('#000000').withOpacity(0.1),
                                                                              HexColor('#000000'),
                                                                            ]),
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(4.0)),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]))
                                                        ]),
                                                ],
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
                    );
                  });
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget displayPenalty() {
    if (double.tryParse(dnaAll.dnaIdentityResponse.result.penalty) != null &&
        double.parse(dnaAll.dnaIdentityResponse.result.penalty) > 0) {
      return Text(
        AppLocalizations.of(context).translate("Penalty: ") + double.parse(dnaAll.dnaIdentityResponse.result.penalty).toDouble().toStringAsFixed(4) + " iDNA",
        style: TextStyle(
            fontFamily: MyIdenaAppTheme.fontName,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: -0.1,
            color: MyIdenaAppTheme.darkText),
      );
    } else {
      return Text("");
    }
  }

  Widget displayMiningSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Switch(
          value: miningSwitchValue,
          onChanged: (value) {
            setState(() {
              if (miningSwitchValue) {
                showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                          contentPadding: EdgeInsets.zero,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                      AppLocalizations.of(context).translate(
                                          "Deactivate mining status"),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: MyIdenaAppTheme.fontName,
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
                                        fontFamily: MyIdenaAppTheme.fontName,
                                        fontSize: 15.0,
                                      )),
                                  SizedBox(height: 20.0),
                                  Text(
                                      AppLocalizations.of(context).translate(
                                          "You can activate it again afterwards."),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: MyIdenaAppTheme.fontName,
                                        fontSize: 15.0,
                                      )),
                                  SizedBox(height: 10.0),
                                  new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      FlatButton(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("Submit"),
                                          ),
                                          color: Colors.grey[200],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          onPressed: () {
                                            httpService.becomeOffline();
                                            miningSwitchValue =
                                                !miningSwitchValue;
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          }),
                                      FlatButton(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("Cancel"),
                                          ),
                                          color: Colors.grey[200],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
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
                        ));
              } else {
                showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
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
                                        fontFamily: MyIdenaAppTheme.fontName,
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
                                        fontFamily: MyIdenaAppTheme.fontName,
                                        fontSize: 15.0,
                                      )),
                                  SizedBox(height: 20.0),
                                  Text(
                                      AppLocalizations.of(context).translate(
                                          "You can deactivate your online status at any time."),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: MyIdenaAppTheme.fontName,
                                        fontSize: 15.0,
                                      )),
                                  new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      FlatButton(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("Submit"),
                                          ),
                                          color: Colors.grey[200],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          onPressed: () {
                                            setState(() {
                                              httpService.becomeOnline();
                                              miningSwitchValue =
                                                  !miningSwitchValue;
                                              Navigator.pop(context);
                                            });
                                          }),
                                      FlatButton(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("Cancel"),
                                          ),
                                          color: Colors.grey[200],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
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
                        ));
              }
            });
          },
          activeTrackColor: Colors.green[100],
          activeColor: Colors.green[300],
        ),
      ],
    );
  }
}
