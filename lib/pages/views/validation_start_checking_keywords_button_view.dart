import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/utils/answer_type.dart' as AnswerType;
import 'package:my_idena/pages/views/validation_session_view.dart';

class ValidationStartCheckingKeywordsButtonView extends StatefulWidget {
  final List selectionFlipList;
  final AnimationController controllerChrono;
  final DnaAll dnaAll;
  final bool checkFlipsQualityProcess;
  final AnimationController animationController;

  const ValidationStartCheckingKeywordsButtonView(
      {Key key,
      this.selectionFlipList,
      this.controllerChrono,
      this.dnaAll,
      this.animationController,
      this.checkFlipsQualityProcess})
      : super(key: key);

  @override
  _ValidationStartCheckingKeywordsButtonViewState createState() =>
      _ValidationStartCheckingKeywordsButtonViewState();
}

class _ValidationStartCheckingKeywordsButtonViewState
    extends State<ValidationStartCheckingKeywordsButtonView> {
  Widget build(BuildContext context) {
    if (widget.dnaAll.dnaGetEpochResponse.result.currentPeriod ==
            EpochPeriod.LongSession &&
        widget.checkFlipsQualityProcess == false) {
      for (int i = 0; i < widget.selectionFlipList.length; i++) {
        if (widget.selectionFlipList[i] == AnswerType.NONE) {
          return SizedBox();
        }
      }

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
                                      "The flips with relevant keywords will be penalized"),
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
                                    Duration durationChrono =
                                        widget.controllerChrono.duration *
                                            widget.controllerChrono.value;
                                    controllerChronoValue =
                                        durationChrono.inSeconds;
                                    Navigator.push<dynamic>(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) =>
                                              ValidationSessionScreen(animationController: widget.animationController, dnaAll: widget.dnaAll, typeLaunchSession: EpochPeriod.LongSession, checkFlipsQualityProcess: true,),
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
                AppLocalizations.of(context)
                    .translate("Start checking keywords"),
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
    } else {
      return SizedBox();
    }
  }
}
