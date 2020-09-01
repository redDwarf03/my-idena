import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_hexcolor.dart';
import 'package:my_idena/utils/util_identity.dart';

HttpService httpService = HttpService();
bool miningSwitchValue;

class ProfileView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ProfileView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
              if (firstState) {
                miningSwitchValue = dnaAll.dnaIdentityResponse.result.online;
                firstState = false;
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
                                      top: 0, left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 8, top: 16),
                                        child: UtilIdentity().canMine(dnaAll) ==
                                                true
                                            ? Text(
                                                AppLocalizations.of(context)
                                                    .translate("Mining"),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: MyIdenaAppTheme
                                                        .darkText),
                                              )
                                            : Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        "Your current status doesn't allow you to mine."),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: MyIdenaAppTheme
                                                        .darkText),
                                              ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new UtilIdentity().canMine(dnaAll) ==
                                                  true
                                              ? displayMiningSwitch()
                                              : Text(""),
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
                                                      DateFormat.yMMMMEEEEd(
                                                              Localizations
                                                                      .localeOf(
                                                                          context)
                                                                  .languageCode)
                                                          .add_Hm()
                                                          .format(dnaAll
                                                              .dnaGetEpochResponse
                                                              .result
                                                              .nextValidation
                                                              .toLocal())
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
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
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
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
                                      left: 10, right: 10, top: 0, bottom: 8),
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: MyIdenaAppTheme.background,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 0, bottom: 5),
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
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#000000')
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4.0)),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 90,
                                                      height: 4,
                                                      decoration: BoxDecoration(
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
                                                dnaAll.dnaIdentityResponse
                                                    .result.address,
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
                                      left: 10, right: 10, top: 0, bottom: 0),
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: MyIdenaAppTheme.background,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 8, bottom: 16),
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
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#000000')
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4.0)),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 90,
                                                      height: 4,
                                                      decoration: BoxDecoration(
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
                                                dnaAll.dnaIdentityResponse
                                                    .result.age
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
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    letterSpacing: -0.2,
                                                    color: MyIdenaAppTheme
                                                        .darkText,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Container(
                                                    height: 4,
                                                    width: 90,
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
                                                          width: 90,
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
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4.0)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                        dnaAll
                                                            .dnaGetEpochResponse
                                                            .result
                                                            .epoch
                                                            .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          MyIdenaAppTheme
                                                              .fontName,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: MyIdenaAppTheme
                                                          .grey
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
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    letterSpacing: -0.2,
                                                    color: MyIdenaAppTheme
                                                        .darkText,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, top: 4),
                                                  child: Container(
                                                    height: 4,
                                                    width: 90,
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
                                                          width: 90,
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
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4.0)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6),
                                                  child: Text(
                                                    new UtilIdentity()
                                                        .mapToFriendlyStatus(dnaAll
                                                            .dnaIdentityResponse
                                                            .result
                                                            .state),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          MyIdenaAppTheme
                                                              .fontName,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: MyIdenaAppTheme
                                                          .grey
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 8, bottom: 16),
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
                                                  .translate("Score"),
                                              textAlign: TextAlign.center,
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
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#000000')
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4.0)),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 90,
                                                      height: 4,
                                                      decoration: BoxDecoration(
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
                                                dnaAll
                                                        .dnaIdentityResponse
                                                        .result
                                                        .totalShortFlipPoints
                                                        .toString() +
                                                    " / " +
                                                    dnaAll
                                                        .dnaIdentityResponse
                                                        .result
                                                        .totalQualifiedFlips
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
                                                      .translate(
                                                          "Required flips"),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    letterSpacing: -0.2,
                                                    color: MyIdenaAppTheme
                                                        .darkText,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Container(
                                                    height: 4,
                                                    width: 90,
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
                                                          width: 90,
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
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4.0)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6),
                                                  child: Text(
                                                    dnaAll.dnaIdentityResponse
                                                        .result.requiredFlips
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          MyIdenaAppTheme
                                                              .fontName,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: MyIdenaAppTheme
                                                          .grey
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
                                                      .translate("Made flips"),
                                                  style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    letterSpacing: -0.2,
                                                    color: MyIdenaAppTheme
                                                        .darkText,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, top: 4),
                                                  child: Container(
                                                    height: 4,
                                                    width: 90,
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
                                                          width: 90,
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
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4.0)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6),
                                                  child: Text(
                                                    dnaAll.dnaIdentityResponse
                                                        .result.madeFlips
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          MyIdenaAppTheme
                                                              .fontName,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: MyIdenaAppTheme
                                                          .grey
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
                  });
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
