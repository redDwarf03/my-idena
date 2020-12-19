import 'dart:async';
import 'package:badges/badges.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/backoffice/bean/dna_ceremonyIntervals_response.dart';
import 'package:my_idena/backoffice/bean/dna_identity_response.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/pages/widgets/line_widget.dart';
import 'package:my_idena/pages/widgets/text_above_line_widget.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/enums/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/utils/util_identity.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class ValidationSessionCountdownText extends StatefulWidget {
  final DateTime nextValidation;
  final AnimationController animationController;
  final DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponse;

  const ValidationSessionCountdownText({
    Key key,
    @required this.nextValidation,
    @required this.dnaCeremonyIntervalsResponse,
    this.animationController,
  }) : super(key: key);

  @override
  _ValidationSessionCountdownTextState createState() =>
      _ValidationSessionCountdownTextState();
}

class _ValidationSessionCountdownTextState
    extends State<ValidationSessionCountdownText> {
  var logger = Logger();
  bool timeUpFlag = false;
  bool sendIdna = false;
  bool sessionAlert = false;
  bool afterLongSession = false;
  HttpService httpService = new HttpService();
  String currentPeriod = "";
  int endTime;
  Timer _timer;
  bool wait = false;
  CountdownTimerController controller;

  @override
  void initState() {
    super.initState();

    if (widget.nextValidation != null &&
        widget.dnaCeremonyIntervalsResponse != null) {
      endTime = widget.nextValidation.millisecondsSinceEpoch;
      controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    }

    _timerUpdate();
  }

  void onEnd() {
    wait = true;
    Future.delayed(const Duration(seconds: 5), () {
      launchSession();
      wait = false;
    });
  }

  _timerUpdate() {
    _timer = Timer(const Duration(seconds: 1), () async {
      currentPeriod = await httpService.getCurrentPeriod();
      if (!mounted) return;
      setState(() {});
      _timerUpdate();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildChild();
  }

  _buildChild() {
    return FutureBuilder(
        future: httpService.getDnaIdentity(
            Uri.parse(idenaSharedPreferences.apiUrl),
            idenaSharedPreferences.keyApp),
        builder: (BuildContext context,
            AsyncSnapshot<DnaIdentityResponse> _dnaIdentityResponse) {
          if (!_dnaIdentityResponse.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            int canValidate =
                UtilIdentity().canValidate(_dnaIdentityResponse.data);
            if (canValidate > 0) {
              return Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 10, top: 0, bottom: 8),
                  child: Container(
                      child: Row(children: <Widget>[
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          canValidate == 1
                              ? textAboveLineWidget(
                                  AppLocalizations.of(context).translate(
                                      "Your status doesn't allow you to participate in the validation session"),
                                  14)
                              : textAboveLineWidget(
                                  AppLocalizations.of(context).translate(
                                      "To participate in the validation session, you must provide your flips"),
                                  14),
                          lineWidget(90),
                        ]))
                  ])));
            }
            if (currentPeriod == null) currentPeriod = EpochPeriod.None;
            switch (currentPeriod) {
              case EpochPeriod.FlipLottery:
                {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, top: 0, bottom: 8),
                      child: Container(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Text(
                                AppLocalizations.of(context).translate(
                                        "Idena validation will start soon") +
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
                              CountdownTimer(
                                controller: controller,
                                widgetBuilder: (_, CurrentRemainingTime time) {
                                  if (time == null) {
                                    return Text("");
                                  } else {
                                    return Row(
                                      children: [
                                        Text(
                                            time.min != null
                                                ? "${time.min} m "
                                                : "0 m ",
                                            style: TextStyle(
                                              fontFamily:
                                                  MyIdenaAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: -0.2,
                                              color: Colors.red,
                                            )),
                                        Text(
                                            time.sec != null
                                                ? "${time.sec} s "
                                                : "0 s ",
                                            style: TextStyle(
                                              fontFamily:
                                                  MyIdenaAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: -0.2,
                                              color: Colors.red,
                                            )),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ]))
                      ])));
                }
              case EpochPeriod.ShortSession:
                {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, top: 0, bottom: 8),
                      child: Container(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              wait
                                  ? Text("")
                                  : Text(
                                      AppLocalizations.of(context).translate(
                                          "Idena validation started. Please, click the button"),
                                      style: TextStyle(
                                        fontFamily: MyIdenaAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: -0.2,
                                        color: Colors.red,
                                      ),
                                    ),
                              wait
                                  ? Text("")
                                  : FloatingActionButton(
                                      onPressed: () => launchSession(),
                                      backgroundColor: Colors.red,
                                      child: new Icon(Icons.refresh,
                                          color: Colors.white),
                                    ),
                            ])),
                      ])));
                }
              case EpochPeriod.LongSession:
                {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, top: 0, bottom: 8),
                      child: Container(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Text(
                                AppLocalizations.of(context).translate(
                                    "Waiting for the end of long session"),
                                style: TextStyle(
                                  fontFamily: MyIdenaAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: -0.2,
                                  color: Colors.red,
                                ),
                              ),
                              lineWidget(90),
                              sendIdna
                                  ? Container()
                                  : gift(context, _dnaIdentityResponse.data)
                            ]))
                      ])));
                }
              case EpochPeriod.AfterLongSession:
                {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, top: 0, bottom: 8),
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
                              lineWidget(90),
                              sendIdna
                                  ? Container()
                                  : gift(context, _dnaIdentityResponse.data)
                            ]))
                      ])));
                }
              default:
                {
                  return displayNextValidationDate(widget.nextValidation);
                }
            }
          }
        });
  }

  Widget gift(BuildContext context, DnaIdentityResponse dnaIdentityResponse) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          AppLocalizations.of(context).translate(
              "If you are satisfied with the validation session with the mobile application, you can send a tip of 1, 10 or 50 IDNA. Thank you."),
          style: TextStyle(
            fontFamily: MyIdenaAppTheme.fontName,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: -0.2,
            color: MyIdenaAppTheme.darkText,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Badge(
              shape: BadgeShape.square,
              borderRadius: BorderRadius.circular(20),
              badgeContent: Text('1 iDNA',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
              badgeColor: Colors.green[300],
              child: IconButton(
                icon: Icon(
                  FlevaIcons.gift,
                  color: Colors.black54,
                  size: 30,
                ),
                tooltip: 'Send 1 iDNA',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)
                          .translate("Confirmation")),
                      content: Text(AppLocalizations.of(context).translate(
                          "Are you sure you want to send a donation ?")),
                      actions: [
                        FlatButton(
                          child: Text(AppLocalizations.of(context)
                              .translate("No, sorry")),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                            child: Text(AppLocalizations.of(context)
                                .translate("Yes with pleasure")),
                            onPressed: () {
                              try {
                                httpService.sendTransaction(
                                    dnaIdentityResponse.result.address, 1);
                              } catch (e) {
                                logger.e(e.toString());
                              }

                              setState(() {
                                sendIdna = true;
                                Navigator.of(context).pop();
                              });
                            }),
                      ],
                    ),
                  );
                },
              ),
            ),
            Badge(
              shape: BadgeShape.square,
              borderRadius: BorderRadius.circular(20),
              badgeContent: Text('10 iDNA',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
              badgeColor: Colors.green[300],
              child: IconButton(
                icon: Icon(
                  FlevaIcons.gift,
                  color: Colors.black54,
                  size: 30,
                ),
                tooltip: 'Send 10 iDNA',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)
                          .translate("Confirmation")),
                      content: Text(AppLocalizations.of(context).translate(
                          "Are you sure you want to send a donation ?")),
                      actions: [
                        FlatButton(
                          child: Text(AppLocalizations.of(context)
                              .translate("No, sorry")),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                            child: Text(AppLocalizations.of(context)
                                .translate("Yes with pleasure")),
                            onPressed: () {
                              try {
                                httpService.sendTransaction(
                                    dnaIdentityResponse.result.address, 10);
                              } catch (e) {
                                logger.e(e.toString());
                              }

                              setState(() {
                                sendIdna = true;
                                Navigator.of(context).pop();
                              });
                            }),
                      ],
                    ),
                  );
                },
              ),
            ),
            Badge(
              shape: BadgeShape.square,
              borderRadius: BorderRadius.circular(20),
              badgeContent: Text('50 iDNA',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
              badgeColor: Colors.green[300],
              child: IconButton(
                icon: Icon(
                  FlevaIcons.gift,
                  color: Colors.black54,
                  size: 30,
                ),
                tooltip: 'Send 50 iDNA',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)
                          .translate("Confirmation")),
                      content: Text(AppLocalizations.of(context).translate(
                          "Are you sure you want to send a donation ?")),
                      actions: [
                        FlatButton(
                          child: Text(AppLocalizations.of(context)
                              .translate("No, sorry")),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                            child: Text(AppLocalizations.of(context)
                                .translate("Yes with pleasure")),
                            onPressed: () {
                              try {
                                httpService.sendTransaction(
                                    dnaIdentityResponse.result.address, 50);
                              } catch (e) {
                                logger.e(e.toString());
                              }

                              setState(() {
                                sendIdna = true;
                                Navigator.of(context).pop();
                              });
                            }),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Future launchSession() async {
    Uri url = Uri.parse(idenaSharedPreferences.apiUrl);
    String keyApp = idenaSharedPreferences.keyApp;

    await httpService.getDnaGetEpoch(url, keyApp).then((_dnaGetEpochResponse) {
      dnaAll.dnaGetEpochResponse = _dnaGetEpochResponse;
      dnaAll.dnaGetEpochResponse.result.nextValidation = DateTime.now();
    });
    await httpService.getDnaCeremonyIntervals(url, keyApp).then(
        (_dnaCeremonyIntervalsResponse) => dnaAll.dnaCeremonyIntervalsResponse =
            _dnaCeremonyIntervalsResponse);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ValidationSessionScreen(
                longSessionDuration: dnaAll
                    .dnaCeremonyIntervalsResponse.result.longSessionDuration,
                shortSessionDuration: dnaAll
                    .dnaCeremonyIntervalsResponse.result.shortSessionDuration,
                millisecondsSinceEpoch: dnaAll.dnaGetEpochResponse.result
                    .nextValidation.millisecondsSinceEpoch,
                typeLaunchSession: EpochPeriod.ShortSession,
                simulationMode: false,
                checkFlipsQualityProcess: false,
                animationController: widget.animationController)));
  }

  Widget displayNextValidationDate(DateTime nextValidation) {
    if (nextValidation != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          textAboveLineWidget(
              AppLocalizations.of(context).translate("Next validation"), 14),
          lineWidget(90),
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
          CountdownTimer(
            controller: controller,
            widgetBuilder: (_, CurrentRemainingTime time) {
              if (time == null) {
                return Text("");
              } else {
                return Row(
                  children: [
                    Text(time.days != null ? "${time.days} d " : "0 d ",
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.2,
                          color: MyIdenaAppTheme.grey.withOpacity(0.5),
                        )),
                    Text(time.hours != null ? "${time.hours} h " : "0 h ",
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.2,
                          color: MyIdenaAppTheme.grey.withOpacity(0.5),
                        )),
                    Text(time.min != null ? "${time.min} m " : "0 m ",
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.2,
                          color: MyIdenaAppTheme.grey.withOpacity(0.5),
                        )),
                    Text(time.sec != null ? "${time.sec} s " : "0 s ",
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.2,
                          color: MyIdenaAppTheme.grey.withOpacity(0.5),
                        )),
                  ],
                );
              }
            },
          ),
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
