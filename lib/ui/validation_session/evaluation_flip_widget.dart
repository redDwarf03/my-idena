// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:idena_lib_dart/enums/relevance_type.dart' as RelevantType;
import 'package:idena_lib_dart/factory/validation_service.dart';
import 'package:idena_lib_dart/model/dictWords.dart';
import 'package:idena_lib_dart/model/validation_session_infos.dart';

// Project imports:
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';

class EvaluationFlip extends StatefulWidget {
  final ValidationSessionInfoFlips validationSessionInfoFlips;
  final List<Word> wordsMap;
  final bool simulationMode;
  final Function(ValidationSessionInfoFlips) onSelectFlip;

  EvaluationFlip(
      {this.validationSessionInfoFlips,
      this.onSelectFlip,
      this.simulationMode,
      this.wordsMap});

  _EvaluationFlipState createState() => _EvaluationFlipState();
}

class _EvaluationFlipState extends State<EvaluationFlip> {
  List<Word> listWords;
  String word1Name = "";
  String word2Name = "";
  String word1Desc = "";
  String word2Desc = "";

  @override
  void initState() {
    super.initState();

    loadValidationSessionEvaluationFlip(false);
  }

  Future<void> loadValidationSessionEvaluationFlip(bool force) async {
    if (force ||
        (widget.validationSessionInfoFlips == null ||
            widget.validationSessionInfoFlips.listWords == null)) {
      listWords = await sl.get<ValidationService>().getWordsFromHash(
          widget.validationSessionInfoFlips.hash,
          widget.simulationMode,
          widget.wordsMap);
      print("listWords length : " + listWords.length.toString());
      setState(() {
        if (listWords != null && listWords.length > 0) {
          word1Name = listWords[0] != null ? listWords[0].name : "";
          word1Desc = listWords[0] != null ? listWords[0].desc : "";
          if (listWords.length > 1) {
            word2Name = listWords[1] != null ? listWords[1].name : "";
            word2Desc = listWords[1] != null ? listWords[1].desc : "";
          }
        }
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: Column(
        children: <Widget>[
          Divider(
            height: 2,
            color: StateContainer.of(context).curTheme.text15,
          ),
          // Main Container
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            margin: new EdgeInsetsDirectional.only(start: 12.0, end: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                              AppLocalization.of(context)
                                  .validationQualifyKeywordsQuestion,
                              style:
                                  AppStyles.textStyleParagraphSmall(context)),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            word1Name == ""
                                ? AppLocalization.of(context)
                                    .validationQualifyKeywordsNoAvailable
                                : word1Name,
                            style: AppStyles.textStyleTransactionType(context),
                          ),
                        ),
                        Center(
                          child: Text(
                            word1Desc == "" ? "" : word1Desc,
                            style: AppStyles.textStyleParagraphSmall(context),
                          ),
                        ),
                        SizedBox(width: 1, height: 20),
                        Center(
                          child: Text(
                            word2Name == ""
                                ? AppLocalization.of(context)
                                    .validationQualifyKeywordsNoAvailable
                                : word2Name,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: AppStyles.textStyleTransactionType(context),
                          ),
                        ),
                        Center(
                          child: Text(
                            word2Desc == "" ? "" : word2Desc,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: AppStyles.textStyleParagraphSmall(context),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                  elevation: 5.0,
                                  onPressed: () {
                                    if (widget.validationSessionInfoFlips
                                            .relevanceType !=
                                        RelevantType.RELEVANT) {
                                      setState(() {
                                        widget.validationSessionInfoFlips
                                                .relevanceType =
                                            RelevantType.RELEVANT;
                                      });
                                      widget.onSelectFlip(
                                          widget.validationSessionInfoFlips);
                                    }
                                  },
                                  padding: EdgeInsets.all(5.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  color: widget.validationSessionInfoFlips
                                              .relevanceType ==
                                          RelevantType.RELEVANT
                                      ? Colors.blue
                                      : Colors.white,
                                  child: Text(
                                      AppLocalization.of(context)
                                          .validationQualifyKeywordsRelevant,
                                      style: TextStyle(
                                        color: widget.validationSessionInfoFlips
                                                    .relevanceType ==
                                                RelevantType.RELEVANT
                                            ? Colors.white
                                            : Colors.blue,
                                        letterSpacing: 1.5,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                      )),
                                ),
                                IconButton(
                                  icon: Icon(Icons.refresh),
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary60,
                                  onPressed: () {
                                    loadValidationSessionEvaluationFlip(true);
                                    setState(() {});
                                  },
                                ),
                                RaisedButton(
                                  elevation: 5.0,
                                  onPressed: () {
                                    if (widget.validationSessionInfoFlips
                                            .relevanceType !=
                                        RelevantType.IRRELEVANT) {
                                      setState(() {
                                        widget.validationSessionInfoFlips
                                                .relevanceType =
                                            RelevantType.IRRELEVANT;
                                      });
                                      widget.onSelectFlip(
                                          widget.validationSessionInfoFlips);
                                    }
                                  },
                                  padding: EdgeInsets.all(5.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  color: widget.validationSessionInfoFlips
                                              .relevanceType ==
                                          RelevantType.IRRELEVANT
                                      ? Colors.red
                                      : Colors.white,
                                  child: Text(
                                      AppLocalization.of(context)
                                          .validationQualifyKeywordsIrrelevant,
                                      style: TextStyle(
                                        color: widget.validationSessionInfoFlips
                                                    .relevanceType ==
                                                RelevantType.IRRELEVANT
                                            ? Colors.white
                                            : Colors.red,
                                        letterSpacing: 1.5,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
