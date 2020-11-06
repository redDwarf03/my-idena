import 'dart:async';
import 'package:badges/badges.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
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
  var logger = Logger();
  bool timeUpFlag = false;
  bool sendIdna = false;
  bool sessionAlert = false;
  bool afterLongSession = false;
  HttpService httpService = new HttpService();
  String currentPeriod = "";
  int endTime;
  int endTimeBeforeFlipSession;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    if (widget.nextValidation != null) {
      endTime = widget.nextValidation.millisecondsSinceEpoch;
      endTimeBeforeFlipSession = widget.nextValidation.millisecondsSinceEpoch -
          (widget.dnaAll.dnaCeremonyIntervalsResponse.result
                  .flipLotteryDuration) *
              1000;
    }

    _timerUpdate();
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
                        endTime: endTime,
                        onEnd: () {
                          launchSession();
                        },
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
                                      fontFamily: MyIdenaAppTheme.fontName,
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
                                      fontFamily: MyIdenaAppTheme.fontName,
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
                      lineWidget(90),
                      sendIdna ? Container() : gift(context)
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
                      lineWidget(90),
                      sendIdna ? Container() : gift(context)
                    ]))
              ])));
        }
      default:
        {
          return displayNextValidationDate(widget.nextValidation);
        }
    }
  }

  Widget gift(BuildContext context) {
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
              borderRadius: 20,
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
                  try {
                    httpService.sendTransaction(
                        widget.dnaAll.dnaIdentityResponse.result.address, 1);
                  } catch (e) {
                    logger.e(e.toString());
                  }
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
                                          .translate("Thank you !!! :)"),
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
                  setState(() {
                    sendIdna = true;
                  });
                },
              ),
            ),
            Badge(
              shape: BadgeShape.square,
              borderRadius: 20,
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
                  try {
                    httpService.sendTransaction(
                        widget.dnaAll.dnaIdentityResponse.result.address, 10);
                  } catch (e) {
                    logger.e(e.toString());
                  }
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
                                          .translate("Thank you !!! :)"),
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
                  setState(() {
                    sendIdna = true;
                  });
                },
              ),
            ),
            Badge(
              shape: BadgeShape.square,
              borderRadius: 20,
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
                  try {
                    httpService.sendTransaction(
                        widget.dnaAll.dnaIdentityResponse.result.address, 50);
                  } catch (e) {
                    logger.e(e.toString());
                  }
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
                                          .translate("Thank you !!! :)"),
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
                  setState(() {
                    sendIdna = true;
                  });
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  void launchSession() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ValidationSessionScreen(
                typeLaunchSession: EpochPeriod.ShortSession,
                simulationMode: false,
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
            endTime: endTime,
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
