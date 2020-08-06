import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_idena/beans/rpc/dna_getBalance_response.dart';
import 'package:my_idena/beans/rpc/flip_shortHashes_response.dart';
import 'package:my_idena/beans/rpc/httpService.dart';
import 'package:my_idena/beans/validation,_session_infos.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/main.dart';

import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

DnaGetBalanceResponse dnaGetBalanceResponse;
HttpService httpService = HttpService();
ValidationSessionInfo validationSessionInfo;

FlipShortHashesResponse flipShortHashesResponse;

class ValidationListView extends StatefulWidget {
  const ValidationListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

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

  List selectionFlipList = new List(7);
  int bottomSelectedIndex = 0;

  SharedPreferences sharedPreferences;
  bool simulationMode;

  void getSimulationMode() async {
    simulationMode = true;
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (sharedPreferences.getBool("simulation_mode") != null) {
        simulationMode = sharedPreferences.getBool("simulation_mode");
      }
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    super.initState();

    // Init choice
    for (int i = 0; i < selectionFlipList.length; i++) {
      selectionFlipList[i] = 0;
    }

    getSimulationMode();
    if (simulationMode) {
      dnaAll.dnaGetEpochResponse.result.currentPeriod =
          EpochPeriod.ShortSession;
      controllerChrono = AnimationController(
          vsync: this,
          duration: Duration(
              seconds: dnaAll
                  .dnaCeremonyIntervalsResponse.result.shortSessionDuration));
    } else {
      if (dnaAll.dnaGetEpochResponse.result.currentPeriod ==
          EpochPeriod.ShortSession) {
        controllerChrono = AnimationController(
            vsync: this,
            duration: Duration(
                seconds: dnaAll
                    .dnaCeremonyIntervalsResponse.result.shortSessionDuration));
      } else {
        if (dnaAll.dnaGetEpochResponse.result.currentPeriod ==
            EpochPeriod.LongSession) {
          controllerChrono = AnimationController(
              vsync: this,
              duration: Duration(
                  seconds: dnaAll.dnaCeremonyIntervalsResponse.result
                      .longSessionDuration));
        }
      }
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    controllerChrono.dispose();
    super.dispose();
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return Column(
          children: <Widget>[
            FadeTransition(
              opacity: widget.mainScreenAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
                child: Container(
                  height: 450,
                  width: 1000,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 16, left: 16),
                    itemCount: selectionFlipList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = selectionFlipList.length > 10
                          ? 20
                          : selectionFlipList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return ValidationView(
                        selectionFlipList: selectionFlipList,
                        animation: animation,
                        animationController: animationController,
                        bottomSelectedIndex: index,
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(width: double.infinity, child: getChrono()),
          ],
        );
      },
    );
  }

  Widget getChrono() {
    controllerChrono.reverse(
        from: controllerChrono.value == 0.0 ? 1.0 : controllerChrono.value);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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

class ValidationView extends StatefulWidget {
  final List selectionFlipList;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final int bottomSelectedIndex;

  const ValidationView(
      {Key key,
      this.selectionFlipList,
      this.animationController,
      this.animation,
      this.bottomSelectedIndex})
      : super(key: key);
  @override
  _ValidationViewState createState() => _ValidationViewState();
}

class _ValidationViewState extends State<ValidationView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FutureBuilder(
            future: getValidationSessionInfo(EpochPeriod.ShortSession, validationSessionInfo),
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
                        shortSessionCharged = true;
                    return FadeTransition(
                      opacity: widget.animation,
                      child: Transform(
                        transform: Matrix4.translationValues(
                            100 * (1.0 - widget.animation.value), 0.0, 0.0),
                        child: SizedBox(
                          width: 400,
                          child: displayFlips(listSessionValidationFlip),
                        ),
                      ),
                    );
                  }
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });
      },
    );
  }

  Widget displayFlips (
      List<ValidationSessionInfoFlips> listSessionValidationFlip) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: widget.selectionFlipList[widget.bottomSelectedIndex] == 1
              ? new BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                  border: new Border.all(color: Colors.green, width: 5))
              : new BoxDecoration(
                  border: new Border.all(
                      color: Color.fromRGBO(255, 255, 255, 0), width: 5)),
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.selectionFlipList[widget.bottomSelectedIndex] = 1;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: ResizeImage(
                        MemoryImage(listSessionValidationFlip[
                                widget.bottomSelectedIndex]
                            .listImages1[0]),
                        width: 145)),
                Image(
                    image: ResizeImage(
                        MemoryImage(listSessionValidationFlip[
                                widget.bottomSelectedIndex]
                            .listImages1[1]),
                        width: 145)),
                Image(
                    image: ResizeImage(
                        MemoryImage(listSessionValidationFlip[
                                widget.bottomSelectedIndex]
                            .listImages1[2]),
                        width: 145)),
                Image(
                    image: ResizeImage(
                        MemoryImage(listSessionValidationFlip[
                                widget.bottomSelectedIndex]
                            .listImages1[3]),
                        width: 145)),
              ],
            ),
          ),
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              child: Text(
                (widget.bottomSelectedIndex + 1).toString() +
                    "/" +
                    listSessionValidationFlip.length.toString(),
                style: TextStyle(
                    fontFamily: MyIdenaAppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: -0.1,
                    color: MyIdenaAppTheme.darkText),
              ),
              foregroundColor: Colors.red,
            )
          ],
        )),
        Container(
          decoration: widget.selectionFlipList[widget.bottomSelectedIndex] == 2
              ? new BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                  border: new Border.all(color: Colors.green, width: 5))
              : new BoxDecoration(
                  border: new Border.all(
                      color: Color.fromRGBO(255, 255, 255, 0), width: 5)),
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.selectionFlipList[widget.bottomSelectedIndex] = 2;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: ResizeImage(
                        MemoryImage(listSessionValidationFlip[
                                widget.bottomSelectedIndex]
                            .listImages2[0]),
                        width: 145)),
                Image(
                    image: ResizeImage(
                        MemoryImage(listSessionValidationFlip[
                                widget.bottomSelectedIndex]
                            .listImages2[1]),
                        width: 145)),
                Image(
                    image: ResizeImage(
                        MemoryImage(listSessionValidationFlip[
                                widget.bottomSelectedIndex]
                            .listImages2[2]),
                        width: 145)),
                Image(
                    image: ResizeImage(
                        MemoryImage(listSessionValidationFlip[
                                widget.bottomSelectedIndex]
                            .listImages2[3]),
                        width: 145)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
