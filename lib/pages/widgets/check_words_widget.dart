import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/factory/validation_session_infos.dart';
import 'package:my_idena/beans/dictWords.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/enums/relevance_type.dart' as RelevantType;
import 'package:my_idena/enums/epoch_period.dart' as EpochPeriod;

class CheckWordsWidget extends StatelessWidget {
  CheckWordsWidget(
      {Key key,
      this.listWords,
      this.currentPeriod,
      this.index,
      this.animationController,
      this.validationSessionInfo,
      this.checkFlipsQualityProcess})
      : super(key: key);

  final List<Word> listWords;
  final String currentPeriod;
  final int index;
  final AnimationController animationController;
  final ValidationSessionInfo validationSessionInfo;
  final bool checkFlipsQualityProcess;

  @override
  Widget build(BuildContext context) {
    if (currentPeriod == EpochPeriod.LongSession && checkFlipsQualityProcess) {
      String word1Name = "";
      String word2Name = "";
      String word1Desc = "";
      String word2Desc = "";

      if (listWords != null && listWords.length > 0) {
        word1Name = listWords[0] != null ? listWords[0].name : "";
        word1Desc = listWords[0] != null ? listWords[0].desc : "";
        if (listWords.length > 1) {
          word2Name = listWords[1] != null ? listWords[1].name : "";
          word2Desc = listWords[1] != null ? listWords[1].desc : "";
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
                            /*setState(() {
                              validationItemList[index].relevanceType =
                                  RelevantType.RELEVANT;
                            });*/
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: validationSessionInfo
                                      .listSessionValidationFlips[index]
                                      .relevanceType ==
                                  RelevantType.RELEVANT
                              ? Colors.blue
                              : Colors.white,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Both relevant"),
                              style: TextStyle(
                                color: validationSessionInfo
                                            .listSessionValidationFlips[index]
                                            .relevanceType ==
                                        RelevantType.RELEVANT
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
                            /*setState(() {
                              validationItemList[index].relevanceType =
                                  RelevantType.IRRELEVANT;
                            });*/
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: validationSessionInfo
                                      .listSessionValidationFlips[index]
                                      .relevanceType ==
                                  RelevantType.IRRELEVANT
                              ? Colors.red
                              : Colors.white,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Irrelevant"),
                              style: TextStyle(
                                color: validationSessionInfo
                                            .listSessionValidationFlips[index]
                                            .relevanceType ==
                                        RelevantType.IRRELEVANT
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
