import 'package:flutter/material.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/backoffice/factory/validation_session_infos.dart';
import 'package:my_idena/enums/relevance_type.dart' as RelevantType;

class ValidationLongSessionButtonView extends StatefulWidget {
  final ValidationSessionInfo validationSessionInfo;
  final bool simulationMode;

  const ValidationLongSessionButtonView(
      {Key key, this.validationSessionInfo, this.simulationMode})
      : super(key: key);

  @override
  _ValidationLongSessionButtonViewState createState() =>
      _ValidationLongSessionButtonViewState();
}

class _ValidationLongSessionButtonViewState
    extends State<ValidationLongSessionButtonView> {
  Widget build(BuildContext context) {
    int nbIrrelevant = 0;
    int nbRelevant = 0;
    for (int i = 0; i < widget.validationSessionInfo.listSessionValidationFlips.length; i++) {
      if (widget.validationSessionInfo.listSessionValidationFlips[i].relevanceType == RelevantType.RELEVANT) {
        nbRelevant++;
      }
      if (widget.validationSessionInfo.listSessionValidationFlips[i].relevanceType ==
          RelevantType.IRRELEVANT) {
        nbIrrelevant++;
      }
    }

    if (nbIrrelevant != 0 && nbRelevant / nbIrrelevant < 3) {
      return Text(
          "The number of flips that can be reported\nshould be limited to 1/3",
          style: TextStyle(
              fontFamily: MyIdenaAppTheme.fontName,
              fontSize: 14,
              letterSpacing: -0.1,
              color: Colors.red));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          elevation: 5.0,
          onPressed: () {
            if (widget.simulationMode == false) {
              submitLongAnswers(
                widget.validationSessionInfo);
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
                                AppLocalizations.of(context).translate(
                                    "Your answers for the validation session have been submitted successfully!"),
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
                              RaisedButton(
                                elevation: 5.0,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                },
                                padding: EdgeInsets.all(5.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.white,
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate("Go home"),
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
