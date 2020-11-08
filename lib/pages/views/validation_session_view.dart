import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/beans/dictWords.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/backoffice/factory/validation_session_infos.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/pages/views/validation_display_flip_view.dart';
import 'package:my_idena/pages/views/validation_long_session_button_view.dart';
import 'package:my_idena/pages/views/validation_short_session_button_view.dart';
import 'package:my_idena/pages/views/validation_start_checking_keywords_button_view.dart';
import 'package:my_idena/pages/views/validation_thumbnails_view.dart';
import 'package:my_idena/pages/widgets/line_widget.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/enums/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/enums/answer_type.dart' as AnswerType;
import 'package:my_idena/enums/relevance_type.dart' as RelevantType;
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';


HttpService httpService = HttpService();
ValidationSessionInfo validationSessionInfo;
DnaAll dnaAllForValidationSession;
bool checkFlipsQualityProcessForValidationSession;
// 1 = Short Session, 2 = Long session, 3 = Long session + check words, 0 = No sessions
int sessionStep;
bool isLoading = false;

class ValidationSessionView extends StatefulWidget {
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final DnaAll dnaAll;
  final bool simulationMode;
  final String typeLaunchSession;
  final bool checkFlipsQualityProcess;

  const ValidationSessionView(
      {Key key,
      this.animationController,
      this.animation,
      this.simulationMode,
      this.typeLaunchSession,
      this.checkFlipsQualityProcess,
      this.dnaAll})
      : super(key: key);
  @override
  _ValidationSessionViewState createState() =>
      new _ValidationSessionViewState();
}

class _ValidationSessionViewState extends State<ValidationSessionView>
    with TickerProviderStateMixin {
  bool initStateOk;
  int endTime;
  String currentPeriod;
  int index = 0;

  @override
  void initState() {
    print("initState session view");


    dnaAllForValidationSession = widget.dnaAll;

    checkFlipsQualityProcessForValidationSession =
        widget.checkFlipsQualityProcess;
    super.initState();

    currentPeriod = widget.typeLaunchSession;

    // Init choice
    if (currentPeriod == EpochPeriod.ShortSession) {
      validationSessionInfo = null;

      sessionStep = 1;
      checkFlipsQualityProcessForValidationSession = false;
      endTime = dnaAllForValidationSession.dnaGetEpochResponse.result
              .nextValidation.millisecondsSinceEpoch +
          (dnaAllForValidationSession
                  .dnaCeremonyIntervalsResponse.result.shortSessionDuration *
              1000);
    }
    if (currentPeriod == EpochPeriod.LongSession) {
      if (checkFlipsQualityProcessForValidationSession == false) {
        validationSessionInfo = null;
        sessionStep = 2;
      } else {
        sessionStep = 3;
      }

      endTime = dnaAllForValidationSession.dnaGetEpochResponse.result
              .nextValidation.millisecondsSinceEpoch +
          (dnaAllForValidationSession
                  .dnaCeremonyIntervalsResponse.result.shortSessionDuration *
              1000) +
          (dnaAllForValidationSession
                  .dnaCeremonyIntervalsResponse.result.longSessionDuration *
              1000);
    }
  }

  _refreshAction() async {
    setState(() {
      isLoading = true;
    });
    try {
      validationSessionInfo = await getValidationSessionFlipsList(
          currentPeriod, null, widget.simulationMode);
    } catch (e) {} finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build session view");
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return FutureBuilder(
        future: getValidationSessionFlipsList(
            currentPeriod, validationSessionInfo, widget.simulationMode),
        builder: (BuildContext context,
            AsyncSnapshot<ValidationSessionInfo> snapshot) {
          if (snapshot.hasData) {
            validationSessionInfo = snapshot.data;
            if (validationSessionInfo == null ||
                validationSessionInfo.listSessionValidationFlips == null) {
              return wakeUp();
            } else {
              List<ValidationSessionInfoFlips> listSessionValidationFlip =
                  validationSessionInfo.listSessionValidationFlips;

              return AnimatedBuilder(
                  animation: widget.animationController,
                  builder: (BuildContext context, Widget child) {
                    return FadeTransition(
                      opacity: widget.animation,
                      child: new Transform(
                        transform: new Matrix4.translationValues(
                            0.0, 30 * (1.0 - widget.animation.value), 0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 18),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                300,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                30,
                                            child: ListView.builder(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    bottom: 0,
                                                    right: 16,
                                                    left: 16),
                                                itemCount:
                                                    listSessionValidationFlip
                                                        .length,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return SizedBox(
                                                    child: Column(
                                                      children: [
                                                        FutureBuilder<
                                                                ValidationSessionInfoFlips>(
                                                            future: getValidationSessionFlipDetail(
                                                                listSessionValidationFlip[
                                                                    index],
                                                                widget
                                                                    .simulationMode),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        ValidationSessionInfoFlips>
                                                                    snapshotFlip) {
                                                              if (snapshotFlip
                                                                      .hasData ==
                                                                  false) {
                                                                return Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                              } else {
                                                                ValidationSessionInfoFlips
                                                                    validationSessionInfoFlips =
                                                                    snapshotFlip
                                                                        .data;
                                                                if (currentPeriod ==
                                                                        EpochPeriod
                                                                            .LongSession &&
                                                                    checkFlipsQualityProcessForValidationSession ==
                                                                        true) {
                                                                  return FutureBuilder<
                                                                          List<
                                                                              Word>>(
                                                                      future: getWordsFromHash(
                                                                          validationSessionInfoFlips
                                                                              .hash,
                                                                          widget
                                                                              .simulationMode),
                                                                      builder: (BuildContext
                                                                              context,
                                                                          AsyncSnapshot<List<Word>>
                                                                              snapshotWords) {
                                                                        if (snapshotWords.hasData ==
                                                                            false) {
                                                                          return Column(
                                                                            children: [
                                                                              displayFlips(validationSessionInfoFlips),
                                                                              Center(
                                                                                  child: CircularProgressIndicator(
                                                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                                                              ))
                                                                            ],
                                                                          );
                                                                        } else {
                                                                          List<Word>
                                                                              wordsList =
                                                                              snapshotWords.data;
                                                                          return Column(
                                                                            children: [
                                                                              displayFlips(validationSessionInfoFlips),
                                                                              checkWords(validationSessionInfoFlips, wordsList)
                                                                            ],
                                                                          );
                                                                        }
                                                                      });
                                                                } else {
                                                                  return displayFlips(
                                                                      validationSessionInfoFlips);
                                                                }
                                                              }
                                                            }),
                                                        lineWidget(
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                80),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    new ValidationThumbnailsView(
                                      listSessionValidationFlip:
                                          listSessionValidationFlip,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(child: getChrono()),
                                        Container(
                                            child: getCheckingKeywordsButton(
                                                currentPeriod,
                                                widget.checkFlipsQualityProcess,
                                                listSessionValidationFlip)),
                                        Container(
                                            child: getShortSessionButton(
                                                currentPeriod,
                                                listSessionValidationFlip)),
                                        Container(
                                            child: getLongSessionButton(
                                                currentPeriod,
                                                widget.checkFlipsQualityProcess,
                                                listSessionValidationFlip)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ));
          }
        });
  }

  Widget getCheckingKeywordsButton(
      String _currentPeriod,
      bool _checkFlipsQualityProcess,
      List<ValidationSessionInfoFlips> _listSessionValidationFlip) {
    if (_currentPeriod == EpochPeriod.LongSession &&
        _checkFlipsQualityProcess == false) {
      for (int i = 0; i < _listSessionValidationFlip.length; i++) {
        if (_listSessionValidationFlip[i].answerType == AnswerType.NONE) {
          return SizedBox();
        }
      }
      return ValidationStartCheckingKeywordsButtonView(
        simulationMode: widget.simulationMode,
        dnaAll: dnaAllForValidationSession,
        animationController: widget.animationController,
      );
    } else {
      return SizedBox();
    }
  }

  Widget getShortSessionButton(String _currentPeriod,
      List<ValidationSessionInfoFlips> _listSessionValidationFlip) {
    if (_currentPeriod == EpochPeriod.ShortSession) {
      for (int i = 0; i < _listSessionValidationFlip.length; i++) {
        if (_listSessionValidationFlip[i].answerType == AnswerType.NONE) {
          return SizedBox();
        }
      }
      return ValidationShortSessionButtonView(
          simulationMode: widget.simulationMode,
          currentPeriod: currentPeriod,
          dnaAll: dnaAllForValidationSession,
          animationController: widget.animationController,
          validationSessionInfo: validationSessionInfo,
          goLongSession: (bool goLongSession) {
            if (goLongSession) {
              Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => ValidationSessionScreen(
                      simulationMode: widget.simulationMode,
                      animationController: widget.animationController,
                      dnaAll: widget.dnaAll,
                      typeLaunchSession: EpochPeriod.LongSession,
                      checkFlipsQualityProcess: false,
                    ),
                  ));
            }
          });
    } else {
      return SizedBox();
    }
  }

  Widget getLongSessionButton(
      String _currentPeriod,
      bool _checkFlipsQualityProcess,
      List<ValidationSessionInfoFlips> _listSessionValidationFlip) {
    if (_currentPeriod == EpochPeriod.LongSession &&
        _checkFlipsQualityProcess) {
      for (int i = 0; i < _listSessionValidationFlip.length; i++) {
        if (_listSessionValidationFlip[i].relevanceType ==
            RelevantType.NO_INFO) {
          return SizedBox();
        }
      }
      return ValidationLongSessionButtonView(
          validationSessionInfo: validationSessionInfo,
          simulationMode: widget.simulationMode,
          goHome: (bool goHome) {
            if (goHome) {
              sessionStep = 0;
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }
          });
    } else {
      return SizedBox();
    }
  }

  Widget getChrono() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.access_time, color: Colors.red),
        CountdownTimer(
          endTime: endTime,
          widgetBuilder: (_, CurrentRemainingTime time) {
            if (time == null) {
              return Text("");
            } else {
              return Row(
                children: [
                  Text(time.min != null ? "${time.min} m " : "0 m ",
                      style: TextStyle(
                        fontFamily: MyIdenaAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.2,
                        color: Colors.red,
                      )),
                  Text(time.sec != null ? "${time.sec} s " : "0 s ",
                      style: TextStyle(
                        fontFamily: MyIdenaAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.2,
                        color: Colors.red,
                      )),
                ],
              );
            }
          },
          onEnd: () {
            print("end");
            if (sessionStep != 0) {
              if (currentPeriod == EpochPeriod.ShortSession) {
                if (widget.simulationMode == false) {
                  submitShortAnswers(validationSessionInfo);
                }

                Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          ValidationSessionScreen(
                              simulationMode: widget.simulationMode,
                              animationController: widget.animationController,
                              dnaAll: dnaAllForValidationSession,
                              checkFlipsQualityProcess: false,
                              typeLaunchSession: EpochPeriod.LongSession),
                    ));
              }
              if (currentPeriod == EpochPeriod.LongSession) {
                if (widget.simulationMode == false &&
                    checkFlipsQualityProcessForValidationSession == true) {
                  submitLongAnswers(validationSessionInfo);
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }
            }
          },
        ),
      ],
    );
  }

  Widget displayFlips(ValidationSessionInfoFlips validationSessionInfoFlips) {
    return new ValidationDisplayFlipView(
        validationSessionInfoFlips: validationSessionInfoFlips,
        onSelectFlip: (ValidationSessionInfoFlips _validationSessionInfoFlips) {
          setState(() {
            validationSessionInfoFlips = _validationSessionInfoFlips;
          });
        });
  }

  Widget wakeUp() {
    return Column(
      children: [
        SizedBox(
          width: 10,
          height: 30,
        ),
        Text(
          AppLocalizations.of(context)
              .translate("Hey oh! Idena ! Wake up !\nPlease refresh..."),
          style: TextStyle(
            fontFamily: MyIdenaAppTheme.fontName,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.red,
          ),
        ),
        SizedBox(
          width: 10,
          height: 10,
        ),
        FloatingActionButton(
          onPressed: _refreshAction,
          backgroundColor: Colors.red,
          child: new Icon(Icons.refresh, color: Colors.white),
        ),
      ],
    );
  }

  Widget checkWords(ValidationSessionInfoFlips validationSessionInfoFlips,
      List<Word> listWords) {
    if (currentPeriod == EpochPeriod.LongSession &&
        widget.checkFlipsQualityProcess) {
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
                            if (validationSessionInfoFlips.relevanceType !=
                                RelevantType.RELEVANT) {
                              setState(() {
                                validationSessionInfoFlips.relevanceType =
                                    RelevantType.RELEVANT;
                              });
                            }
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: validationSessionInfoFlips.relevanceType ==
                                  RelevantType.RELEVANT
                              ? Colors.blue
                              : Colors.white,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Both relevant"),
                              style: TextStyle(
                                color:
                                    validationSessionInfoFlips.relevanceType ==
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
                            if (validationSessionInfoFlips.relevanceType !=
                                RelevantType.IRRELEVANT) {
                              setState(() {
                                validationSessionInfoFlips.relevanceType =
                                    RelevantType.IRRELEVANT;
                              });
                            }
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: validationSessionInfoFlips.relevanceType ==
                                  RelevantType.IRRELEVANT
                              ? Colors.red
                              : Colors.white,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Irrelevant"),
                              style: TextStyle(
                                color:
                                    validationSessionInfoFlips.relevanceType ==
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
