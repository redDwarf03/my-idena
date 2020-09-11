import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/utils/util_date.dart';
import 'package:my_idena/utils/util_hexcolor.dart';
import 'package:my_idena/utils/util_identity.dart';

class ValidationSessionCountdownText extends StatefulWidget {
  final DateTime nextValidation;
  final AnimationController animationController;
  final DnaAll dnaAll;
  const ValidationSessionCountdownText({
    Key key,
    @required this.nextValidation,
    this.animationController,
    this.dnaAll,
  }) : super(key: key);

  @override
  _ValidationSessionCountdownTextState createState() =>
      _ValidationSessionCountdownTextState();
}

class _ValidationSessionCountdownTextState
    extends State<ValidationSessionCountdownText> {
  bool timeUpFlag = false;
  bool sessionAlert = false;
  bool afterLongSession = false;
  int timeCounter = 0;
  HttpService httpService = new HttpService();
  Timer _timer;
  String currentPeriod = "";
  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    if (widget.nextValidation != null) {
      timeCounter = widget.nextValidation.difference(now).inSeconds;
    }
    _timerUpdate();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _timerUpdate() {
    _timer = Timer(const Duration(seconds: 1), () async {
      currentPeriod = await httpService.getCurrentPeriod();
      if (!mounted) return;
      setState(() {
        timeCounter--;
      });
      _timerUpdate();
    });
  }

  _buildChild() {
    int canValidate = UtilIdentity().canValidate(widget.dnaAll);
    if (canValidate > 0) {
      return Padding(
          padding: const EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 8),
          child: Container(
              child: Row(children: <Widget>[
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  canValidate == 1
                      ? Text(
                          AppLocalizations.of(context).translate(
                              "Your status doesn't allow you to participate in the validation session"),
                          style: TextStyle(
                            fontFamily: MyIdenaAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: -0.2,
                            color: MyIdenaAppTheme.darkText,
                          ),
                        )
                      : Text(
                          AppLocalizations.of(context).translate(
                              "To participate in the validation session, you must provide your flips"),
                          style: TextStyle(
                            fontFamily: MyIdenaAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: -0.2,
                            color: MyIdenaAppTheme.darkText,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      height: 4,
                      width: 90,
                      decoration: BoxDecoration(
                        color: HexColor('#000000').withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 4,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
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
          ])));
    }
    if (currentPeriod == null) currentPeriod = EpochPeriod.None;
    switch (currentPeriod) {
      case EpochPeriod.FlipLottery:
        {
          return Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 8),
              child: Container(
                  child: Row(children: <Widget>[
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text(
                        AppLocalizations.of(context)
                                .translate("Idena validation will start soon") +
                            " : " +
                            "${printDuration(Duration(seconds: timeCounter))}" +
                            "\n" +
                            AppLocalizations.of(context).translate(
                                "Please, stay on this page until launch."),
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.2,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          height: 4,
                          width: 90,
                          decoration: BoxDecoration(
                            color: HexColor('#000000').withOpacity(0.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 90,
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
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
              ])));
        }
      case EpochPeriod.ShortSession:
        {
          WidgetsBinding.instance.addPostFrameCallback((_) => launchSession());
          return Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 8),
              child: Container(
                  child: Row(children: <Widget>[
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text(
                        AppLocalizations.of(context)
                            .translate("Idena validation will start soon"),
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.2,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          height: 4,
                          width: 90,
                          decoration: BoxDecoration(
                            color: HexColor('#000000').withOpacity(0.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 90,
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
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
              ])));
        }
      case EpochPeriod.LongSession:
        {
          return Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 8),
              child: Container(
                  child: Row(children: <Widget>[
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text(
                        AppLocalizations.of(context)
                            .translate("Waiting for the end of long session"),
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.2,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          height: 4,
                          width: 90,
                          decoration: BoxDecoration(
                            color: HexColor('#000000').withOpacity(0.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 90,
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
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
              ])));
        }
      case EpochPeriod.AfterLongSession:
        {
          return Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 8),
              child: Container(
                  child: Row(children: <Widget>[
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate(
                            "Please wait. The network is reaching consensus about validated identities"),
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.2,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          height: 4,
                          width: 90,
                          decoration: BoxDecoration(
                            color: HexColor('#000000').withOpacity(0.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 90,
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
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
              ])));
        }
      default:
        {
          return displayNextValidationDate(widget.nextValidation);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildChild();
  }

  void launchSession() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ValidationSessionScreen(
                typeLaunchSession: EpochPeriod.ShortSession,
                checkFlipsQualityProcess: false,
                dnaAll: widget.dnaAll,
                animationController: widget.animationController)));
  }

  Widget displayNextValidationDate(DateTime nextValidation) {
    if (nextValidation != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate("Next validation"),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: MyIdenaAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              letterSpacing: -0.2,
              color: MyIdenaAppTheme.darkText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              height: 4,
              width: 90,
              decoration: BoxDecoration(
                color: HexColor('#000000').withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 90,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        HexColor('#000000').withOpacity(0.1),
                        HexColor('#000000'),
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              DateFormat.yMMMMEEEEd(
                      Localizations.localeOf(context).languageCode)
                  .add_Hm()
                  .format(nextValidation.toLocal())
                  .toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: MyIdenaAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0.0,
                color: MyIdenaAppTheme.grey.withOpacity(0.5),
              ),
            ),
          ),
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget displayCurrentPeriod() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 1, height: 10),
        Text(
          AppLocalizations.of(context).translate("Current period"),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: MyIdenaAppTheme.fontName,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: -0.2,
            color: MyIdenaAppTheme.darkText,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            height: 4,
            width: 90,
            decoration: BoxDecoration(
              color: HexColor('#000000').withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 90,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      HexColor('#000000').withOpacity(0.1),
                      HexColor('#000000'),
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            currentPeriod != null ? currentPeriod : "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: MyIdenaAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              letterSpacing: 0.0,
              color: MyIdenaAppTheme.grey.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
