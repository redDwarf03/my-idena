import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/enums/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/enums/answer_type.dart' as AnswerType;
import 'package:my_idena/backoffice/factory/validation_session_infos.dart';

class ValidationShortSessionButtonView extends StatefulWidget {
  final List selectionFlipList;
  final List<int> selectedIconList;
  final ValidationSessionInfo validationSessionInfo;
  final DnaAll dnaAll;
  final String currentPeriod;
  final AnimationController animationController;

  const ValidationShortSessionButtonView(
      {Key key,
      this.selectionFlipList,
      this.selectedIconList,
      this.dnaAll,
      this.currentPeriod,
      this.animationController,
      this.validationSessionInfo})
      : super(key: key);

  @override
  _ValidationShortSessionButtonViewState createState() =>
      _ValidationShortSessionButtonViewState();
}

class _ValidationShortSessionButtonViewState
    extends State<ValidationShortSessionButtonView> {
  Widget build(BuildContext context) {
    if (widget.currentPeriod == EpochPeriod.ShortSession) {
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
              submitShortAnswers(
                  widget.selectionFlipList, widget.validationSessionInfo);
              Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => ValidationSessionScreen(
                      animationController: widget.animationController,
                      dnaAll: widget.dnaAll,
                      typeLaunchSession: EpochPeriod.LongSession,
                      checkFlipsQualityProcess: false,
                    ),
                  ));
            },
            padding: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.white,
            child:
                Text(AppLocalizations.of(context).translate("Submit answers"),
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
