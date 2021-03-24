// @dart=2.9
import 'dart:async';
import 'package:badges/badges.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/response/dna_ceremonyIntervals_response.dart';
import 'package:my_idena/network/model/response/dna_getEpoch_response.dart';
import 'package:my_idena/network/model/response/dna_identity_response.dart';
import 'package:my_idena/factory/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/util_identity.dart';
import 'package:my_idena/util/enums/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/util/util_node.dart';

class ValidationSessionCountdownText extends StatefulWidget {
  const ValidationSessionCountdownText({
    Key key,
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
  String currentPeriod = "";
  int endTime;
  Timer _timer;
  bool wait = false;
  int _nodeType;
  CountdownTimerController controller;
  DnaCeremonyIntervalsResponse _dnaCeremonyIntervalsResponse;
  DnaGetEpochResponse _dnaGetEpochResponse;

  @override
  void initState() {
    super.initState();
    _nodeType = UNKOWN_NODE;
    loadInfos();

    _timerUpdate();
  }

  Future<void> loadInfos() async {
    int _nt = await NodeUtil().getNodeType();
    _dnaCeremonyIntervalsResponse =
        await sl.get<AppService>().getDnaCeremonyIntervals();
    _dnaGetEpochResponse = await sl.get<AppService>().getDnaGetEpoch();

    if (_dnaGetEpochResponse != null &&
        _dnaGetEpochResponse.result != null &&
        _dnaGetEpochResponse.result.nextValidation != null &&
        _dnaGetEpochResponse.result.nextValidation.compareTo(DateTime.now()) >=
            0 &&
        _dnaCeremonyIntervalsResponse != null) {
      endTime =
          _dnaGetEpochResponse.result.nextValidation.millisecondsSinceEpoch;
      controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    }
    setState(() {
      _nodeType = _nt;
    });
  }

  void onEnd() {
    wait = true;
    Future.delayed(const Duration(seconds: 5), () {
      launchSession(false);
      wait = false;
    });
  }

  _timerUpdate() {
    _timer = Timer(const Duration(seconds: 1), () async {
      currentPeriod = await sl.get<AppService>().getCurrentPeriod();
      if (!mounted) return;
      setState(() {});
      _timerUpdate();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    if (controller != null) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _dnaGetEpochResponse == null || _dnaGetEpochResponse.result == null
        ? SizedBox()
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(68.0)),
              color: StateContainer.of(context).curTheme.primary,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0.1, 1.1),
                    blurRadius: 5.0),
              ],
            ),
            height: 150,
            width: (MediaQuery.of(context).size.width - 14),
            margin: EdgeInsetsDirectional.only(start: 7, top: 0.0, end: 7.0),
            child: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    return FutureBuilder(
        future: sl
            .get<AppService>()
            .getDnaIdentity(StateContainer.of(context).selectedAccount.address),
        builder: (BuildContext context,
            AsyncSnapshot<DnaIdentityResponse> _dnaIdentityResponse) {
          if (!_dnaIdentityResponse.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (_dnaIdentityResponse.data.result.address == null) {
              return SizedBox();
            }

            int canValidate =
                UtilIdentity().canValidate(_dnaIdentityResponse.data);
            if (canValidate > 0) {
              return Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 0, bottom: 0),
                  child: Container(
                      child: Row(children: <Widget>[
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          Column(
                            children: [
                              displayNextValidationDate(
                                  _dnaGetEpochResponse.result.nextValidation),
                              SizedBox(
                                height: 10,
                              ),
                              canValidate == 1
                                  ? RaisedButton.icon(
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      label: Text(
                                        AppLocalization.of(context)
                                            .validationDoesntAllow,
                                        style:
                                            AppStyles.textStyleHomeInfoWarning(
                                                context),
                                      ),
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.white,
                                      ),
                                      textColor: Colors.white,
                                      splashColor: Colors.red,
                                      color: Colors.red[300],
                                    )
                                  : RaisedButton.icon(
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      label: Text(
                                        AppLocalization.of(context)
                                            .validationMustProvideFlips,
                                        style:
                                            AppStyles.textStyleHomeInfoWarning(
                                                context),
                                      ),
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.white,
                                      ),
                                      textColor: Colors.white,
                                      splashColor: Colors.red,
                                      color: Colors.red[300],
                                    ),
                            ],
                          )
                        ]))
                  ])));
            }
            if (currentPeriod == null) currentPeriod = EpochPeriod.None;
            switch (currentPeriod) {
              case EpochPeriod.FlipLottery:
                {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 0),
                      child: Container(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              controller == null
                                  ? SizedBox()
                                  : CountdownTimer(
                                      controller: controller,
                                      widgetBuilder:
                                          (_, CurrentRemainingTime time) {
                                        if (time == null) {
                                          return Text("");
                                        } else {
                                          return RaisedButton.icon(
                                            onPressed: () {},
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            label: Row(
                                              children: [
                                                Text(
                                                  AppLocalization.of(context)
                                                      .validationWillStartSoon,
                                                  style: AppStyles
                                                      .textStyleHomeInfoWarning(
                                                          context),
                                                ),
                                                Text(
                                                    time.min != null
                                                        ? "${time.min}" +
                                                            AppLocalization.of(
                                                                    context)
                                                                .timeMin
                                                        : "0" +
                                                            AppLocalization.of(
                                                                    context)
                                                                .timeMin,
                                                    style: AppStyles
                                                        .textStyleHomeInfoWarning(
                                                            context)),
                                                Text(
                                                    time.sec != null
                                                        ? " ${time.sec}" +
                                                            AppLocalization.of(
                                                                    context)
                                                                .timeSec
                                                        : " 0" +
                                                            AppLocalization.of(
                                                                    context)
                                                                .timeSec,
                                                    style: AppStyles
                                                        .textStyleHomeInfoWarning(
                                                            context)),
                                              ],
                                            ),
                                            icon: Icon(
                                              Icons.warning,
                                              color: Colors.white,
                                            ),
                                            textColor: Colors.white,
                                            splashColor: Colors.red,
                                            color: Colors.red[300],
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
                          left: 10, right: 10, top: 0, bottom: 0),
                      child: Container(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              wait
                                  ? Text("")
                                  : RaisedButton.icon(
                                      onPressed: () {
                                        launchSession(true);
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      label: Text(
                                        AppLocalization.of(context)
                                            .validationForceStart,
                                        style:
                                            AppStyles.textStyleHomeInfoWarning(
                                                context),
                                      ),
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.white,
                                      ),
                                      textColor: Colors.white,
                                      splashColor: Colors.red,
                                      color: Colors.red[300],
                                    )
                            ])),
                      ])));
                }

              case EpochPeriod.LongSession:
                {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 0),
                      child: Container(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Text(
                                  AppLocalization.of(context)
                                      .validationWaitingEnd,
                                  style: AppStyles.textStyleHomeInfoHeader(
                                      context)),
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
                          left: 10, right: 10, top: 0, bottom: 0),
                      child: Container(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Text(
                                AppLocalization.of(context)
                                    .validationReachingConsensus,
                                style:
                                    AppStyles.textStyleHomeInfoWarning(context),
                              ),
                              sendIdna
                                  ? Container()
                                  : gift(context, _dnaIdentityResponse.data)
                            ]))
                      ])));
                }
              default:
                {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 0),
                      child: Container(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            displayNextValidationDate(
                                _dnaGetEpochResponse.result.nextValidation),
                            canValidate == 1
                                ? RaisedButton.icon(
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    label: Text(
                                      AppLocalization.of(context)
                                          .validationDoesntAllow,
                                      style: AppStyles.textStyleHomeInfoWarning(
                                          context),
                                    ),
                                    icon: Icon(
                                      Icons.warning,
                                      color: Colors.white,
                                    ),
                                    textColor: Colors.white,
                                    splashColor: Colors.red,
                                    color: Colors.red[300],
                                  )
                                : RaisedButton.icon(
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    label: Text(
                                      AppLocalization.of(context)
                                          .validationNextAllowed,
                                      style: AppStyles.textStyleHomeInfoWarning(
                                          context),
                                    ),
                                    icon: Icon(
                                      Icons.warning,
                                      size: 0,
                                      color: Colors.white,
                                    ),
                                    textColor: Colors.white,
                                    splashColor: Colors.green,
                                    color: Colors.green[300],
                                  ),
                            _nodeType != DEMO_NODE
                                ? Text(
                                    "The validation session is being tested on this application. Only use it if you want to participate in the testing phase with the associated risks",
                                    style:
                                        AppStyles.textStyleHomeInfoWarningRed(
                                            context),
                                  )
                                : SizedBox()
                          ],
                        ))
                      ])));
                }
            }
          }
        });
  }

  Widget gift(BuildContext context, DnaIdentityResponse dnaIdentityResponse) {
    return Column(
      children: [
        Text(AppLocalization.of(context).validationTipInfo,
            style: AppStyles.textStyleHomeInfoDetail(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 20,
            ),
            getBadgeGift(1),
            getBadgeGift(10),
            getBadgeGift(50),
          ],
        )
      ],
    );
  }

  Future launchSession(bool force) async {
    if (currentPeriod == EpochPeriod.ShortSession || force) {
      bool simulationMode = false;
      Navigator.of(context).pushNamed('/validation_session_step_1', arguments: {
        'simulationMode': simulationMode,
        'address': StateContainer.of(context).selectedAccount.address
      });
    }
  }

  Widget getBadgeGift(int amount) {
    return Badge(
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(20),
      badgeContent: Text(amount.toString() + ' iDNA',
          style: TextStyle(color: Colors.white, fontSize: 10)),
      badgeColor: Colors.green[300],
      child: IconButton(
        icon: Icon(
          FlevaIcons.gift,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          AppDialogs.showConfirmDialog(
              context,
              AppLocalization.of(context).validationTipConfirmationHeader,
              AppLocalization.of(context).validationTipConfirmationQuestion +
                  " " +
                  amount.toString() +
                  " iDNA ?",
              CaseChange.toUpperCase(
                  AppLocalization.of(context).yesButton, context), () {
            setState(() async {
              sl.get<AppService>().sendTip(
                  StateContainer.of(context).selectedAccount.address,
                  amount.toDouble().toString(),
                  await StateContainer.of(context).getSeed());
              AppDialogs.showConfirmDialog(
                  context,
                  AppLocalization.of(context).validationTipThxHeader,
                  "",
                  CaseChange.toUpperCase(
                      AppLocalization.of(context).close, context),
                  () {});
            });
          });
        },
      ),
    );
  }

  Widget displayNextValidationDate(DateTime nextValidation) {
    if (nextValidation != null) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
          child: Container(
              child: Row(children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalization.of(context).validationNextDate,
                  style: AppStyles.textStyleHomeInfoHeader(context),
                ),
                Text(
                    DateFormat.yMMMMEEEEd(
                            Localizations.localeOf(context).languageCode)
                        .add_Hm()
                        .format(nextValidation.toLocal())
                        .toString(),
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleHomeInfoDetail(context)),
                controller != null
                    ? CountdownTimer(
                        controller: controller,
                        widgetBuilder: (_, CurrentRemainingTime time) {
                          if (time == null) {
                            return Text("");
                          } else {
                            return Row(
                              children: [
                                Text(
                                    time.days != null
                                        ? "${time.days}" +
                                            AppLocalization.of(context).timeDays
                                        : "0" +
                                            AppLocalization.of(context)
                                                .timeDays,
                                    style: AppStyles.textStyleHomeInfoDetail(
                                        context)),
                                Text(
                                    time.hours != null
                                        ? " ${time.hours}" +
                                            AppLocalization.of(context)
                                                .timeHours
                                        : " 0" +
                                            AppLocalization.of(context)
                                                .timeHours,
                                    style: AppStyles.textStyleHomeInfoDetail(
                                        context)),
                                Text(
                                    time.min != null
                                        ? " ${time.min}" +
                                            AppLocalization.of(context).timeMin
                                        : " 0" +
                                            AppLocalization.of(context).timeMin,
                                    style: AppStyles.textStyleHomeInfoDetail(
                                        context)),
                                Text(
                                    time.sec != null
                                        ? " ${time.sec}" +
                                            AppLocalization.of(context).timeSec
                                        : " 0" +
                                            AppLocalization.of(context).timeSec,
                                    style: AppStyles.textStyleHomeInfoDetail(
                                        context)),
                              ],
                            );
                          }
                        },
                      )
                    : SizedBox(),
              ],
            ))
          ])));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
