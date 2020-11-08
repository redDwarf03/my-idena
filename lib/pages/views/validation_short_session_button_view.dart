import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/backoffice/factory/validation_session_infos.dart';

class ValidationShortSessionButtonView extends StatefulWidget {
  final ValidationSessionInfo validationSessionInfo;
  final DnaAll dnaAll;
  final String currentPeriod;
  final AnimationController animationController;
  final bool simulationMode;
  final Function goLongSession;

  const ValidationShortSessionButtonView(
      {Key key,
      this.dnaAll,
      this.currentPeriod,
      this.animationController,
      this.validationSessionInfo,
      this.goLongSession,
      this.simulationMode})
      : super(key: key);

  @override
  _ValidationShortSessionButtonViewState createState() =>
      _ValidationShortSessionButtonViewState();
}

class _ValidationShortSessionButtonViewState
    extends State<ValidationShortSessionButtonView> {
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          elevation: 5.0,
          onPressed: () {
            if (widget.simulationMode == false) {
              submitShortAnswers(widget.validationSessionInfo);
            }
            widget.goLongSession(true);
           /* Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => ValidationSessionScreen(
                    simulationMode: widget.simulationMode,
                    animationController: widget.animationController,
                    dnaAll: widget.dnaAll,
                    typeLaunchSession: EpochPeriod.LongSession,
                    checkFlipsQualityProcess: false,
                  ),
                ));*/
          },
          padding: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(AppLocalizations.of(context).translate("Submit answers"),
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
