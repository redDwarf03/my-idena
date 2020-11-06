import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/beans/dictWords.dart';
import 'package:my_idena/beans/validation_item.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/backoffice/factory/validation_session_infos.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/pages/views/validation_display_flip.dart';
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
import 'package:my_idena/utils/util_hexcolor.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

int controllerChronoValue;
HttpService httpService = HttpService();
ValidationSessionInfo validationSessionInfo;
DnaAll dnaAllForValidationSession;
bool checkFlipsQualityProcessForValidationSession;
List<ValidationItem> validationItemList;

bool isLoading = false;

class ValidationSessionView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final DnaAll dnaAll;
  final bool simulationMode;
  final String typeLaunchSession;
  final bool checkFlipsQualityProcess;

  const ValidationSessionView(
      {Key key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
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
  AnimationController animationController;
  bool initStateOk;
  int endTime;
  String currentPeriod;
  int index = 0;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initStateOk = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    dnaAllForValidationSession = widget.dnaAll;

    checkFlipsQualityProcessForValidationSession =
        widget.checkFlipsQualityProcess;
    super.initState();

    currentPeriod = widget.typeLaunchSession;

    // Init choice
    if (currentPeriod == EpochPeriod.ShortSession) {
      validationSessionInfo = null;
      validationItemList = new List();
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
        validationItemList = new List();
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
                validationSessionInfo.listSessionValidationFlip == null) {
              return wakeUp();
            } else {
              List<ValidationSessionInfoFlips> listSessionValidationFlip =
                  validationSessionInfo.listSessionValidationFlip;
              if (initStateOk) {
                if (checkFlipsQualityProcessForValidationSession == false) {
                  validationItemList = new List();
                  for (int i = 0;
                      i <
                          validationSessionInfo
                              .listSessionValidationFlip.length;
                      i++) {
                    validationItemList.add(new ValidationItem(
                        answerType: AnswerType.NONE,
                        relevanceType: RelevantType.NO_INFO));
                  }
                }
                initStateOk = false;
              }
              return AnimatedBuilder(
                  animation: widget.mainScreenAnimationController,
                  builder: (BuildContext context, Widget child) {
                    return Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    widget.simulationMode
                                        ? Chip(
                                            backgroundColor: Colors.orange[600],
                                            padding: EdgeInsets.all(0),
                                            label: Text(
                                                AppLocalizations.of(context)
                                                    .translate("Demo mode"),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                          )
                                        : SizedBox(
                                            height: 1,
                                          ),
                                    Container(
                                      height: widget.simulationMode
                                          ? MediaQuery.of(context).size.height -
                                              400
                                          : MediaQuery.of(context).size.height -
                                              300,
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.only(
                                              top: 0,
                                              bottom: 0,
                                              right: 16,
                                              left: 16),
                                          itemCount: validationItemList.length,
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final int count =
                                                validationItemList.length;

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
                                                                  CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors.red),
                                                          ));
                                                        } else {
                                                          ValidationSessionInfoFlips
                                                              validationSessionInfoFlips =
                                                              snapshotFlip.data;
                                                          if (currentPeriod ==
                                                                  EpochPeriod
                                                                      .LongSession &&
                                                              checkFlipsQualityProcessForValidationSession ==
                                                                  true) {
                                                            return FutureBuilder<
                                                                    List<Word>>(
                                                                future: getWordsFromHash(
                                                                    validationSessionInfoFlips
                                                                        .hash,
                                                                    widget
                                                                        .simulationMode),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            List<Word>>
                                                                        snapshotWords) {
                                                                  if (snapshotWords
                                                                          .hasData ==
                                                                      false) {
                                                                    return Column(
                                                                      children: [
                                                                        displayFlips(
                                                                            validationSessionInfoFlips,
                                                                            index),
                                                                        Center(
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(Colors.green),
                                                                        ))
                                                                      ],
                                                                    );
                                                                  } else {
                                                                    List<Word>
                                                                        wordsList =
                                                                        snapshotWords
                                                                            .data;
                                                                    return Column(
                                                                      children: [
                                                                        displayFlips(
                                                                            validationSessionInfoFlips,
                                                                            index),
                                                                        checkWords(
                                                                            wordsList,
                                                                            index)
                                                                      ],
                                                                    );
                                                                  }
                                                                });
                                                          } else {
                                                            return displayFlips(
                                                                validationSessionInfoFlips,
                                                                index);
                                                          }
                                                        }
                                                      }),
                                                  lineWidget(MediaQuery.of(context).size.width - 80),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              new ValidationThumbnailsView(
                                validationItemList: validationItemList,
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
                                          validationItemList)),
                                  Container(
                                      child: getShortSessionButton(
                                          currentPeriod, validationItemList)),
                                  Container(
                                      child: getLongSessionButton(
                                          currentPeriod,
                                          widget.checkFlipsQualityProcess,
                                          validationItemList)),
                                ],
                              ),
                            ],
                          ),
                        ],
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
      List<ValidationItem> _validationItemList) {
    if (_currentPeriod == EpochPeriod.LongSession &&
        _checkFlipsQualityProcess == false) {
      for (int i = 0; i < _validationItemList.length; i++) {
        if (_validationItemList[i].answerType == AnswerType.NONE) {
          return SizedBox();
        }
      }
      return ValidationStartCheckingKeywordsButtonView(
        simulationMode: widget.simulationMode,
        dnaAll: dnaAllForValidationSession,
        animationController: animationController,
      );
    } else {
      return SizedBox();
    }
  }

  Widget getShortSessionButton(
      String _currentPeriod, List<ValidationItem> _validationItemList) {
    if (_currentPeriod == EpochPeriod.ShortSession) {
      for (int i = 0; i < _validationItemList.length; i++) {
        if (_validationItemList[i].answerType == AnswerType.NONE) {
          return SizedBox();
        }
      }
      return ValidationShortSessionButtonView(
        validationItemList: _validationItemList,
        simulationMode: widget.simulationMode,
        currentPeriod: currentPeriod,
        dnaAll: dnaAllForValidationSession,
        animationController: animationController,
        validationSessionInfo: validationSessionInfo,
      );
    } else {
      return SizedBox();
    }
  }

  Widget getLongSessionButton(
      String _currentPeriod,
      bool _checkFlipsQualityProcess,
      List<ValidationItem> _validationItemList) {
    if (_currentPeriod == EpochPeriod.LongSession &&
        _checkFlipsQualityProcess) {
      for (int i = 0; i < _validationItemList.length; i++) {
        if (_validationItemList[i].relevanceType == RelevantType.NO_INFO) {
          return SizedBox();
        }
      }
      return ValidationLongSessionButtonView(
        validationItemList: _validationItemList,
        validationSessionInfo: validationSessionInfo,
        simulationMode: widget.simulationMode,
      );
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
            if (currentPeriod == EpochPeriod.ShortSession) {
              if (widget.simulationMode == false) {
                submitShortAnswers(validationItemList, validationSessionInfo);
              }
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          ValidationSessionScreen(
                              simulationMode: widget.simulationMode,
                              animationController: animationController,
                              dnaAll: dnaAllForValidationSession,
                              checkFlipsQualityProcess: false,
                              typeLaunchSession: EpochPeriod.LongSession),
                    ));
              });
            }
            if (currentPeriod == EpochPeriod.LongSession) {
              if (widget.simulationMode == false &&
                  checkFlipsQualityProcessForValidationSession == true) {
                submitLongAnswers(validationItemList, validationSessionInfo);
              }
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              });
            }
          },
        ),
      ],
    );
  }

  Widget displayFlips(
      ValidationSessionInfoFlips validationSessionInfoFlips, int index) {
    return new ValidationDisplayFlipView(
        validationItem: validationItemList[index],
        validationSessionInfoFlips: validationSessionInfoFlips,
        onSelectFlip: (ValidationItem _validationItem) {
          setState(() {
            validationItemList[index] = _validationItem;
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

  Widget checkWords(List<Word> listWords, int index) {
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
                            setState(() {
                              validationItemList[index].relevanceType =
                                  RelevantType.RELEVANT;
                            });
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: validationItemList[index].relevanceType ==
                                  RelevantType.RELEVANT
                              ? Colors.blue
                              : Colors.white,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Both relevant"),
                              style: TextStyle(
                                color:
                                    validationItemList[index].relevanceType ==
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
                            setState(() {
                              validationItemList[index].relevanceType =
                                  RelevantType.IRRELEVANT;
                            });
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: validationItemList[index].relevanceType ==
                                  RelevantType.IRRELEVANT
                              ? Colors.red
                              : Colors.white,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Irrelevant"),
                              style: TextStyle(
                                color:
                                    validationItemList[index].relevanceType ==
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
