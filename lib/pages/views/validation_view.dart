import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/backoffice/factory/validation,_session_infos.dart';
import 'package:my_idena/pages/screens/home_screen.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/pages/views/validation_long_session_button_view.dart';
import 'package:my_idena/pages/views/validation_short_session_button_view.dart';
import 'package:my_idena/pages/views/validation_start_checking_keywords_button_view.dart';
import 'package:my_idena/pages/views/validation_thumbnails_view.dart';
import 'package:my_idena/pages/views/validation_words_view.dart';
import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/utils/answer_type.dart' as AnswerType;
import 'package:my_idena/utils/relevance_type.dart' as RelevantType;
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/util_hexcolor.dart';

HttpService httpService = HttpService();
ValidationSessionInfo validationSessionInfo;
DnaAll dnaAllForValidationSession;
String typeLaunchSessionForValidationSession;
int nbFlips = 0;
List selectionFlipList = new List();
List relevantFlipList = new List();
List<Widget> iconList = new List();
int controllerChronoValue;

// 0 = no selection, 1 = selected, 2 = relevant, 3 = relevant,
List<int> selectedIconList = new List();

class ValidationListView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final DnaAll dnaAll;
  final bool simulationMode;
  final String typeLaunchSession;

  const ValidationListView(
      {Key key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      this.simulationMode,
      this.typeLaunchSession,
      this.dnaAll})
      : super(key: key);

  @override
  _ValidationListViewState createState() => _ValidationListViewState();
}

class _ValidationListViewState extends State<ValidationListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController controllerChrono;

  String get timerString {
    Duration duration = controllerChrono.duration * controllerChrono.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  int index = 0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    dnaAllForValidationSession = widget.dnaAll;
    typeLaunchSessionForValidationSession = widget.typeLaunchSession;

    super.initState();

    if (widget.simulationMode) {
      dnaAllForValidationSession.dnaGetEpochResponse.result.currentPeriod =
          typeLaunchSessionForValidationSession;
    } else {
      if (typeLaunchSessionForValidationSession == EpochPeriod.LongSession) {
        dnaAllForValidationSession.dnaGetEpochResponse.result.currentPeriod =
            typeLaunchSessionForValidationSession;
      }
    }

    // Init choice
    if (dnaAllForValidationSession.dnaGetEpochResponse.result.currentPeriod ==
        EpochPeriod.ShortSession) {
      validationSessionInfo = null;
      selectionFlipList = new List();
      relevantFlipList = new List();
      iconList = new List();
      selectedIconList = new List();
      nbFlips = 5;
      checkFlipsQualityProcess = false;
      controllerChrono = AnimationController(
          vsync: this,
          duration: Duration(
              seconds: dnaAllForValidationSession
                  .dnaCeremonyIntervalsResponse.result.shortSessionDuration));
    }
    if (dnaAllForValidationSession.dnaGetEpochResponse.result.currentPeriod ==
        EpochPeriod.LongSession) {
      nbFlips = 17;
      if (checkFlipsQualityProcess == false) {
        controllerChrono = AnimationController(
            vsync: this,
            duration: Duration(
                seconds: dnaAllForValidationSession
                    .dnaCeremonyIntervalsResponse.result.longSessionDuration));
      } else {
        controllerChrono = AnimationController(
            vsync: this, duration: Duration(seconds: controllerChronoValue));
      }
    }

    if (checkFlipsQualityProcess == false) {
      selectionFlipList = new List();
      for (int i = 0; i < nbFlips; i++) {
        selectionFlipList.add(AnswerType.NONE);
        selectedIconList.add(0);
      }
    } else {
      for (int i = 0; i < nbFlips; i++) {
        relevantFlipList.add(RelevantType.RELEVANT);
        selectedIconList.add(0);
      }
    }
  }

  @override
  void dispose() {
    controllerChrono.dispose();
    validationSessionInfo = null;
    selectionFlipList = new List();
    relevantFlipList = new List();
    iconList = new List();
    selectedIconList = new List();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getValidationSessionInfo(
            dnaAllForValidationSession.dnaGetEpochResponse.result.currentPeriod,
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
                                                                      new ValidationWordsView(
                                                                        index:
                                                                            index,
                                                                        relevantFlipList:
                                                                            relevantFlipList,
                                                                        selectedIconList:
                                                                            selectedIconList,
                                                                        validationSessionInfoFlips:
                                                                            listSessionValidationFlip[index],
                                                                      ),
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
                                  nbFlips: nbFlips,
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
                                      checkFlipsQualityProcess:
                                          checkFlipsQualityProcess,
                                    )),
                                    Container(
                                        child: ValidationShortSessionButtonView(
                                      selectedIconList: selectedIconList,
                                      selectionFlipList: selectionFlipList,
                                      dnaAll: dnaAllForValidationSession,
                                      validationSessionInfo:
                                          validationSessionInfo,
                                    )),
                                    Container(
                                        child:
                                            new ValidationLongSessionButtonView(
                                      relevantFlipList: relevantFlipList,
                                      selectedIconList: selectedIconList,
                                      selectionFlipList: selectionFlipList,
                                      dnaAll: dnaAllForValidationSession,
                                      checkFlipsQualityProcess:
                                          checkFlipsQualityProcess,
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
        if (dnaAllForValidationSession
                .dnaGetEpochResponse.result.currentPeriod ==
            EpochPeriod.ShortSession) {
          submitShortAnswers(selectionFlipList, validationSessionInfo);
          typeLaunchSessionForValidationSession = EpochPeriod.LongSession;
          validationSessionInfo = null;
          checkFlipsQualityProcess = false;
          selectedIconList.clear();
          Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => ValidationSessionScreen(
                    animationController: animationController),
              ));
        }
        if (dnaAllForValidationSession
                .dnaGetEpochResponse.result.currentPeriod ==
            EpochPeriod.LongSession) {
          submitLongAnswers(
              selectionFlipList, relevantFlipList, validationSessionInfo);
          typeLaunchSessionForValidationSession = EpochPeriod.ShortSession;
          validationSessionInfo = null;
          checkFlipsQualityProcess = false;
          selectedIconList.clear();
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
}
