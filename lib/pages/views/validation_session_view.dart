import 'dart:async';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/backoffice/factory/validation,_session_infos.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/pages/views/validation_long_session_button_view.dart';
import 'package:my_idena/pages/views/validation_short_session_button_view.dart';
import 'package:my_idena/pages/views/validation_start_checking_keywords_button_view.dart';
import 'package:my_idena/pages/views/validation_thumbnails_view.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/enums/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/enums/answer_type.dart' as AnswerType;
import 'package:my_idena/enums/relevance_type.dart' as RelevantType;
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/util_hexcolor.dart';

HttpService httpService = HttpService();
ValidationSessionInfo validationSessionInfo;
DnaAll dnaAllForValidationSession;
bool checkFlipsQualityProcessForValidationSession;
List selectionFlipList = new List();
List relevantFlipList = new List();
List<Widget> iconList = new List();
int controllerChronoValue;

// 0 = no selection, 1 = selected, 2 = relevant, 3 = no relevant,
List<int> selectedIconList = new List();

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
  _ValidationSessionViewState createState() => _ValidationSessionViewState();
}

class _ValidationSessionViewState extends State<ValidationSessionView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController controllerChrono;
  bool initStateOk;
  String currentPeriod;
  String get timerString {
    Duration duration = controllerChrono.duration * controllerChrono.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  int index = 0;

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
    print("validationSessionView: " + currentPeriod);

    // Init choice
    if (currentPeriod ==
        EpochPeriod.ShortSession) {
      validationSessionInfo = null;
      selectionFlipList = new List();
      relevantFlipList = new List();
      iconList = new List();
      selectedIconList = new List();
      checkFlipsQualityProcessForValidationSession = false;
      Duration duree = (dnaAllForValidationSession
              .dnaGetEpochResponse.result.nextValidation
              .add(new Duration(
                  seconds: dnaAllForValidationSession
                      .dnaCeremonyIntervalsResponse
                      .result
                      .shortSessionDuration)))
          .difference(DateTime.now());
      controllerChrono = AnimationController(
          vsync: this, duration: Duration(seconds: duree.inSeconds));
    }
    if (currentPeriod ==
        EpochPeriod.LongSession) {
      if (checkFlipsQualityProcessForValidationSession == false) {
        validationSessionInfo = null;
        selectionFlipList = new List();
        relevantFlipList = new List();
        iconList = new List();
        selectedIconList = new List();
        Duration duree = (dnaAllForValidationSession
                .dnaGetEpochResponse.result.nextValidation
                .add(new Duration(
                    seconds: dnaAllForValidationSession
                        .dnaCeremonyIntervalsResponse
                        .result
                        .shortSessionDuration))
                .add(new Duration(
                    seconds: dnaAllForValidationSession
                        .dnaCeremonyIntervalsResponse
                        .result
                        .longSessionDuration)))
            .difference(DateTime.now());
        controllerChrono = AnimationController(
            vsync: this,
            duration: Duration(
                seconds: duree.inSeconds));
      } else {
        controllerChrono = AnimationController(
            vsync: this, duration: Duration(seconds: controllerChronoValue));
      }
    }
  }

  @override
  void dispose() {
    if (controllerChrono != null) {
      controllerChrono.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getValidationSessionInfo(
            currentPeriod,
            validationSessionInfo,
            widget.simulationMode),
        builder: (BuildContext context,
            AsyncSnapshot<ValidationSessionInfo> snapshot) {
          if (snapshot.hasData) {
            validationSessionInfo = snapshot.data;
            if (validationSessionInfo == null) {
              return Text("");
            } else {
              if (validationSessionInfo.listSessionValidationFlip == null) {
                return Text("");
              } else {
                List<ValidationSessionInfoFlips> listSessionValidationFlip =
                    validationSessionInfo.listSessionValidationFlip;
                if (initStateOk) {
                  if (checkFlipsQualityProcessForValidationSession == false) {
                    selectionFlipList = new List();
                    for (int i = 0;
                        i <
                            validationSessionInfo
                                .listSessionValidationFlip.length;
                        i++) {
                      selectionFlipList.add(AnswerType.NONE);
                      selectedIconList.add(0);
                    }
                  } else {
                    for (int i = 0;
                        i <
                            validationSessionInfo
                                .listSessionValidationFlip.length;
                        i++) {
                      relevantFlipList.add(RelevantType.RELEVANT);
                      selectedIconList.add(0);
                    }
                  }
                  initStateOk = false;
                }
                return AnimatedBuilder(
                    animation: widget.mainScreenAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return Container(
                        width: MediaQuery.of(context).size.width - 25,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      FadeTransition(
                                        opacity: widget.mainScreenAnimation,
                                        child: Transform(
                                            transform: Matrix4.translationValues(
                                                0.0,
                                                30 *
                                                    (1.0 -
                                                        widget
                                                            .mainScreenAnimation
                                                            .value),
                                                0.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  300,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  30,
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          bottom: 0,
                                                          right: 16,
                                                          left: 16),
                                                  itemCount:
                                                      selectionFlipList.length,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final int count =
                                                        selectionFlipList
                                                                    .length >
                                                                25
                                                            ? 30
                                                            : selectionFlipList
                                                                .length;
                                                    final Animation<
                                                        double> animation = Tween<
                                                                double>(
                                                            begin: 0.0,
                                                            end: 1.0)
                                                        .animate(CurvedAnimation(
                                                            parent:
                                                                animationController,
                                                            curve: Interval(
                                                                (1 / count) *
                                                                    index,
                                                                1.0,
                                                                curve: Curves
                                                                    .fastOutSlowIn)));
                                                    animationController
                                                        .forward();
                                                    return AnimatedBuilder(
                                                        animation:
                                                            animationController,
                                                        builder: (BuildContext
                                                                context,
                                                            Widget child) {
                                                          return FadeTransition(
                                                              opacity:
                                                                  animation,
                                                              child: Transform(
                                                                transform: Matrix4
                                                                    .translationValues(
                                                                        100 *
                                                                            (1.0 -
                                                                                animation.value),
                                                                        0.0,
                                                                        0.0),
                                                                child: SizedBox(
                                                                  width: 400,
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            height:
                                                                                ((MediaQuery.of(context).size.height - 340)).toDouble(),
                                                                            decoration: selectionFlipList[index] == AnswerType.LEFT
                                                                                ? new BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10.0), border: new Border.all(color: Colors.green, width: 5))
                                                                                : new BoxDecoration(border: new Border.all(color: Color.fromRGBO(255, 255, 255, 0), width: 5)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  selectedIconList[index] = 1;
                                                                                  selectionFlipList[index] = AnswerType.LEFT;
                                                                                });
                                                                              },
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Image(image: ResizeImage(MemoryImage(listSessionValidationFlip[index].listImagesLeft[0]), height: ((MediaQuery.of(context).size.height - 350) ~/ 4).toInt())),
                                                                                  Image(image: ResizeImage(MemoryImage(listSessionValidationFlip[index].listImagesLeft[1]), height: ((MediaQuery.of(context).size.height - 350) ~/ 4).toInt())),
                                                                                  Image(image: ResizeImage(MemoryImage(listSessionValidationFlip[index].listImagesLeft[2]), height: ((MediaQuery.of(context).size.height - 350) ~/ 4).toInt())),
                                                                                  Image(image: ResizeImage(MemoryImage(listSessionValidationFlip[index].listImagesLeft[3]), height: ((MediaQuery.of(context).size.height - 350) ~/ 4).toInt())),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                ((MediaQuery.of(context).size.height - 340)).toDouble(),
                                                                            decoration: selectionFlipList[index] == AnswerType.RIGHT
                                                                                ? new BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10.0), border: new Border.all(color: Colors.green, width: 5))
                                                                                : new BoxDecoration(border: new Border.all(color: Color.fromRGBO(255, 255, 255, 0), width: 5)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  selectedIconList[index] = 1;
                                                                                  selectionFlipList[index] = AnswerType.RIGHT;
                                                                                });
                                                                              },
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Image(image: ResizeImage(MemoryImage(listSessionValidationFlip[index].listImagesRight[0]), height: ((MediaQuery.of(context).size.height - 350) ~/ 4).toInt())),
                                                                                  Image(image: ResizeImage(MemoryImage(listSessionValidationFlip[index].listImagesRight[1]), height: ((MediaQuery.of(context).size.height - 350) ~/ 4).toInt())),
                                                                                  Image(image: ResizeImage(MemoryImage(listSessionValidationFlip[index].listImagesRight[2]), height: ((MediaQuery.of(context).size.height - 350) ~/ 4).toInt())),
                                                                                  Image(image: ResizeImage(MemoryImage(listSessionValidationFlip[index].listImagesRight[3]), height: ((MediaQuery.of(context).size.height - 350) ~/ 4).toInt())),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      checkWords(
                                                                          listSessionValidationFlip[
                                                                              index],
                                                                          index),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                5,
                                                                            bottom:
                                                                                15),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              4,
                                                                          width:
                                                                              MediaQuery.of(context).size.width - 80,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                HexColor('#000000').withOpacity(0.2),
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(4.0)),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: <Widget>[
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width - 80,
                                                                                height: 4,
                                                                                decoration: BoxDecoration(
                                                                                  gradient: LinearGradient(colors: [
                                                                                    HexColor('#000000').withOpacity(0.1),
                                                                                    HexColor('#000000'),
                                                                                  ]),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                        });
                                                  }),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                new ValidationThumbnailsView(
                                  iconList: iconList,
                                  nbFlips: listSessionValidationFlip.length,
                                  selectedIconList: selectedIconList,
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
                                        child:
                                            ValidationStartCheckingKeywordsButtonView(
                                      controllerChrono: controllerChrono,
                                      selectionFlipList: selectionFlipList,
                                      dnaAll: dnaAllForValidationSession,
                                      currentPeriod: currentPeriod,
                                      animationController: animationController,
                                      checkFlipsQualityProcess:
                                          checkFlipsQualityProcessForValidationSession,
                                    )),
                                    Container(
                                        child: ValidationShortSessionButtonView(
                                      selectedIconList: selectedIconList,
                                      selectionFlipList: selectionFlipList,
                                      currentPeriod: currentPeriod,
                                      dnaAll: dnaAllForValidationSession,
                                      animationController: animationController,
                                      validationSessionInfo:
                                          validationSessionInfo,
                                    )),
                                    Container(
                                        child:
                                            new ValidationLongSessionButtonView(
                                      relevantFlipList: relevantFlipList,
                                      selectedIconList: selectedIconList,
                                      selectionFlipList: selectionFlipList,
                                      currentPeriod: currentPeriod,
                                      dnaAll: dnaAllForValidationSession,
                                      checkFlipsQualityProcess:
                                          checkFlipsQualityProcessForValidationSession,
                                      validationSessionInfo:
                                          validationSessionInfo,
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget getChrono() {
    controllerChrono.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if (currentPeriod ==
            EpochPeriod.ShortSession) {
          submitShortAnswers(selectionFlipList, validationSessionInfo);
          Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => ValidationSessionScreen(
                    animationController: animationController,
                    dnaAll: dnaAllForValidationSession,
                    checkFlipsQualityProcess: false,
                    typeLaunchSession: EpochPeriod.LongSession),
              ));
        }
        if (currentPeriod ==
            EpochPeriod.LongSession) {
          submitLongAnswers(
              selectionFlipList, relevantFlipList, validationSessionInfo);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      }
    });
    controllerChrono.reverse(
        from: controllerChrono.value == 0.0 ? 1.0 : controllerChrono.value);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.access_time, color: Colors.red),
        AnimatedBuilder(
            animation: controllerChrono,
            builder: (BuildContext context, Widget child) {
              return Text(
                timerString,
                style: TextStyle(
                  fontFamily: MyIdenaAppTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: -0.1,
                  color: Colors.red,
                ),
              );
            }),
      ],
    );
  }

  Widget checkWords(
      ValidationSessionInfoFlips validationSessionInfoFlips, int index) {
    if (currentPeriod ==
            EpochPeriod.LongSession &&
        widget.checkFlipsQualityProcess) {
      String word1Name = "";
      String word2Name = "";
      String word1Desc = "";
      String word2Desc = "";

      if (validationSessionInfoFlips.listWords != null &&
          validationSessionInfoFlips.listWords.length > 0) {
        word1Name = validationSessionInfoFlips.listWords[0] != null
            ? validationSessionInfoFlips.listWords[0].name
            : "";
        word1Desc = validationSessionInfoFlips.listWords[0] != null
            ? validationSessionInfoFlips.listWords[0].desc
            : "";
        if (validationSessionInfoFlips.listWords.length > 1) {
          word2Name = validationSessionInfoFlips.listWords[1] != null
              ? validationSessionInfoFlips.listWords[1].name
              : "";
          word2Desc = validationSessionInfoFlips.listWords[1] != null
              ? validationSessionInfoFlips.listWords[1].desc
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
                              relevantFlipList[index] = RelevantType.RELEVANT;
                              selectedIconList[index] = 2;
                            });
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: selectedIconList[index] == 2
                              ? Colors.blue
                              : Colors.white,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Both relevant"),
                              style: TextStyle(
                                color: selectedIconList[index] == 2
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
                              relevantFlipList[index] = RelevantType.IRRELEVANT;
                              selectedIconList[index] = 3;
                            });
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: selectedIconList[index] == 3
                              ? Colors.red
                              : Colors.white,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Irrelevant"),
                              style: TextStyle(
                                color: selectedIconList[index] == 3
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
