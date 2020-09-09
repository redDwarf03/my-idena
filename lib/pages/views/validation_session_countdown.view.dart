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
  final String currentPeriod;
  final AnimationController animationController;
  final DnaAll dnaAll;
  const ValidationSessionCountdownText(
      {Key key,
      @required this.nextValidation,
      this.animationController,
      this.dnaAll,
      this.currentPeriod})
      : super(key: key);

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
  DnaAll dnaAll;
  Timer _timer;
  String currentPeriod = "";
  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    timeCounter = widget.nextValidation.difference(now).inSeconds;
    // TODO
    timeCounter = 1500;

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
      print(timeCounter.toString());
      // TODO:
      if (timeCounter < 10) {
        currentPeriod = EpochPeriod.FlipLottery;
      }
      if (timeCounter <= 0) {
        currentPeriod = EpochPeriod.ShortSession;
      }

      _timerUpdate();
    });
  }

  _buildChild() {
    if (UtilIdentity().canValidate(widget.dnaAll) == false) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 8),
          child: Container(
              child: Row(children: <Widget>[
            Text(
              AppLocalizations.of(context).translate(
                  "Your status doesn't allow you to participate in the validation session"),
              style: TextStyle(
                  fontFamily: MyIdenaAppTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  letterSpacing: 0.0,
                  color: MyIdenaAppTheme.darkText),
            )
          ])));
    }
    if (currentPeriod == null) currentPeriod = EpochPeriod.None;
    switch (currentPeriod) {
      case EpochPeriod.FlipLottery:
        {
          return Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 8),
              child: Container(
                  child: Row(children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                SizedBox(width: 15, height: 1),
                Text(
                  AppLocalizations.of(context)
                          .translate("Idena validation will start soon") +
                      " : " +
                      "${printDuration(Duration(seconds: timeCounter))}",
                  style: TextStyle(
                      fontFamily: MyIdenaAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: 0.0,
                      color: Colors.red),
                )
              ])));
        }
      case EpochPeriod.ShortSession:
        {
          WidgetsBinding.instance.addPostFrameCallback((_) => launchSession());
          return SizedBox(width: 1, height: 1);
        }
      case EpochPeriod.LongSession:
        {
          return Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 8),
              child: Container(
                  child: Row(children: <Widget>[
                Text(
                  AppLocalizations.of(context)
                      .translate("Waiting for the end of long session"),
                  style: TextStyle(
                      fontFamily: MyIdenaAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: 0.0,
                      color: Colors.red),
                )
              ])));
        }
      case EpochPeriod.AfterLongSession:
        {
          return Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 8),
              child: Container(
                  child: Row(children: <Widget>[
                Text(
                  AppLocalizations.of(context).translate(
                      "Please wait. The network is reaching consensus about validated identities"),
                  style: TextStyle(
                      fontFamily: MyIdenaAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: 0.0,
                      color: Colors.red),
                )
              ])));
        }
      default:
        {
          return displayNextValidationDate(dnaAll);
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

  Widget displayNextValidationDate(DnaAll thisDnaAll) {
    return Expanded(
      child: Column(
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
                  .format(thisDnaAll.dnaGetEpochResponse.result.nextValidation
                      .toLocal())
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
      ),
    );
  }

  Widget displayCurrentPeriod(DnaAll thisDnaAll) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
      ),
    );
  }
}
