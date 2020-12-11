import 'package:flutter/material.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/enums/epoch_period.dart' as EpochPeriod;

class ValidationStartCheckingKeywordsButtonView extends StatefulWidget {
  final AnimationController animationController;
  final bool simulationMode;
  final int millisecondsSinceEpoch;
  final int shortSessionDuration;
  final int longSessionDuration;

  const ValidationStartCheckingKeywordsButtonView(
      {Key key,
      this.animationController,
      this.simulationMode,
      this.millisecondsSinceEpoch,
      this.shortSessionDuration,
      this.longSessionDuration})
      : super(key: key);

  @override
  _ValidationStartCheckingKeywordsButtonViewState createState() =>
      _ValidationStartCheckingKeywordsButtonViewState();
}

class _ValidationStartCheckingKeywordsButtonViewState
    extends State<ValidationStartCheckingKeywordsButtonView> {
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          elevation: 5.0,
          onPressed: () {
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
                                    "Your answers are not yet submitted"),
                                style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: -0.1,
                                    color: MyIdenaAppTheme.darkText),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppLocalizations.of(context).translate(
                                    "Please qualify the keywords relevance and submit the answers."),
                                style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.1,
                                    color: MyIdenaAppTheme.darkText),
                              ),
                              Text(
                                AppLocalizations.of(context).translate(
                                    "The flips with irrelevant keywords will be penalized"),
                                style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.1,
                                    color: MyIdenaAppTheme.darkText),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RaisedButton(
                                elevation: 5.0,
                                onPressed: () {
                                  Navigator.push<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            ValidationSessionScreen(
                                          longSessionDuration:
                                              widget.longSessionDuration,
                                          shortSessionDuration:
                                              widget.shortSessionDuration,
                                          millisecondsSinceEpoch:
                                              widget.millisecondsSinceEpoch,
                                          simulationMode: widget.simulationMode,
                                          animationController:
                                              widget.animationController,
                                          typeLaunchSession:
                                              EpochPeriod.LongSession,
                                          checkFlipsQualityProcess: true,
                                        ),
                                      ));
                                },
                                padding: EdgeInsets.all(5.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.white,
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate("Ok, I understand"),
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 1.5,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: MyIdenaAppTheme.fontName,
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ));
          },
          padding: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
              AppLocalizations.of(context).translate("Start checking keywords"),
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.5,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontFamily: MyIdenaAppTheme.fontName,
              )),
        ),
      ],
    );
  }
}
