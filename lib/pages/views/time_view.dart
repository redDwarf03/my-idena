import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:ntp/ntp.dart';

  DateTime _myTime;
  DateTime _ntpTime;
  int _differenceTime;

class TimeView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const TimeView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _TimeViewState createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {

  @override
  void initState() {
    super.initState();
    getDifferenceTime();
  }

  @override
  Widget build(BuildContext context) {
    getDifferenceTime();
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
                          color: MyIdenaAppTheme.grey.withOpacity(0.2),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 0, bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("My set time: "),
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
                                        color: HexColor('#000000')
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 90,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                HexColor('#000000')
                                                    .withOpacity(0.1),
                                                HexColor('#000000'),
                                              ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      _myTime != null
                                          ? DateFormat.yMMMMEEEEd(
                                                  Localizations.localeOf(
                                                          context)
                                                      .languageCode)
                                              .add_Hm()
                                              .format(_myTime.toLocal())
                                          : "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: MyIdenaAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: MyIdenaAppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("The current time: "),
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
                                        color: HexColor('#000000')
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 90,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                HexColor('#000000')
                                                    .withOpacity(0.1),
                                                HexColor('#000000'),
                                              ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      _ntpTime != null
                                          ? DateFormat.yMMMMEEEEd(
                                                  Localizations.localeOf(
                                                          context)
                                                      .languageCode)
                                              .add_Hm()
                                              .format(_ntpTime.toLocal())
                                          : "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: MyIdenaAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: MyIdenaAppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  getDifferenceTimeMsg(),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
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

  Future<void> getDifferenceTime() async {
    _myTime = await NTP.now();

    final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
    _ntpTime = _myTime.add(Duration(milliseconds: offset));

    _differenceTime = _myTime.difference(_ntpTime).inMilliseconds;

  }

  Widget getDifferenceTimeMsg() {
    if (_differenceTime == null || _differenceTime.abs() > 500) {
      return Text(
        AppLocalizations.of(context).translate(
            "Please check your local clock. The time must be synchronized with internet time"),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.red[400],
            fontSize: 12,
            fontFamily: MyIdenaAppTheme.fontName,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.2),
      );
    } else {
      return Text(
        AppLocalizations.of(context).translate("Ok, you are on time !"),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.green[400],
            fontSize: 12,
            fontFamily: MyIdenaAppTheme.fontName,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.2),
      );
    }
  }
}
