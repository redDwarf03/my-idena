import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/utils/util_date.dart';
import 'package:my_idena/utils/util_identity.dart';

class ValidationSessionCountdownText extends StatefulWidget {
  final DateTime nextValidation;
  final AnimationController animationController;
  final DnaAll dnaAll;
  const ValidationSessionCountdownText(
      {Key key,
      @required this.nextValidation,
      this.animationController,
      this.dnaAll})
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
    if(UtilIdentity().canValidate(widget.dnaAll) == false)
    {
        return SizedBox(width: 1, height: 1);
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
          return SizedBox(width: 1, height: 1);
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
}
