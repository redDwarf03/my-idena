import 'package:flutter/material.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/backoffice/factory/validation,_session_infos.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/utils/relevance_type.dart' as RelevantType;

class ValidationWordsView extends StatefulWidget {
  final ValidationSessionInfoFlips validationSessionInfoFlips;
  final int index;
  final List<int> selectedIconList;
  final List relevantFlipList;

  const ValidationWordsView(
      {Key key,
      this.validationSessionInfoFlips,
      this.index,
      this.selectedIconList,
      this.relevantFlipList})
      : super(key: key);

  @override
  _ValidationWordsViewState createState() => _ValidationWordsViewState();
}

class _ValidationWordsViewState extends State<ValidationWordsView> {
  Widget build(BuildContext context) {
    if (dnaAll.dnaGetEpochResponse.result.currentPeriod ==
            EpochPeriod.LongSession &&
        checkFlipsQualityProcess) {
      String word1Name = "";
      String word2Name = "";
      String word1Desc = "";
      String word2Desc = "";

      if (widget.validationSessionInfoFlips.listWords != null &&
          widget.validationSessionInfoFlips.listWords.length > 0) {
        word1Name = widget.validationSessionInfoFlips.listWords[0] != null
            ? widget.validationSessionInfoFlips.listWords[0].name
            : "";
        word1Desc = widget.validationSessionInfoFlips.listWords[0] != null
            ? widget.validationSessionInfoFlips.listWords[0].desc
            : "";
        if (widget.validationSessionInfoFlips.listWords.length > 1) {
          word2Name = widget.validationSessionInfoFlips.listWords[1] != null
              ? widget.validationSessionInfoFlips.listWords[1].name
              : "";
          word2Desc = widget.validationSessionInfoFlips.listWords[1] != null
              ? widget.validationSessionInfoFlips.listWords[1].desc
              : "";
        }
      }
      return LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .translate("Are both keywords relevant to the flip ?"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    word1Name == ""
                        ? AppLocalizations.of(context)
                            .translate("No keywords available")
                        : word1Name,
                    style: TextStyle(
                        fontFamily: MyIdenaAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.1,
                        color: MyIdenaAppTheme.darkText),
                  ),
                  Text(
                    word1Desc == "" ? "" : word1Desc,
                    style: TextStyle(
                        fontFamily: MyIdenaAppTheme.fontName,
                        fontSize: 14,
                        letterSpacing: -0.1,
                        color: MyIdenaAppTheme.darkText),
                  ),
                  SizedBox(width: 1, height: 10),
                  Text(
                    word2Name == ""
                        ? AppLocalizations.of(context)
                            .translate("No keywords available")
                        : word2Name,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontFamily: MyIdenaAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.1,
                        color: MyIdenaAppTheme.darkText),
                  ),
                  Text(
                    word2Desc == "" ? "" : word2Desc,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontFamily: MyIdenaAppTheme.fontName,
                        fontSize: 14,
                        letterSpacing: -0.1,
                        color: MyIdenaAppTheme.darkText),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            setState(() {
                              widget.relevantFlipList[widget.index] =
                                  RelevantType.RELEVANT;
                              widget.selectedIconList[widget.index] = 2;
                            });
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: widget.selectedIconList[widget.index] == 2
                              ? Colors.blue
                              : Colors.white,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Both relevant"),
                              style: TextStyle(
                                color:
                                    widget.selectedIconList[widget.index] == 2
                                        ? Colors.white
                                        : Colors.blue,
                                letterSpacing: 1.5,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: MyIdenaAppTheme.fontName,
                              )),
                        ),
                        SizedBox(
                          width: 30,
                          height: 1,
                        ),
                        RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            setState(() {
                              widget.relevantFlipList[widget.index] =
                                  RelevantType.IRRELEVANT;
                              widget.selectedIconList[widget.index] = 3;
                            });
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: widget.selectedIconList[widget.index] == 3
                              ? Colors.red
                              : Colors.white,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Irrelevant"),
                              style: TextStyle(
                                color:
                                    widget.selectedIconList[widget.index] == 3
                                        ? Colors.white
                                        : Colors.red,
                                letterSpacing: 1.5,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: MyIdenaAppTheme.fontName,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
    } else {
      return SizedBox();
    }
  }
}
