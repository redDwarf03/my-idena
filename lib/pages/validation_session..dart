import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_idena/beans/rpc/dna_flipShortHashesRequest.dart';
import 'package:my_idena/beans/rpc/dna_flipShortHashesResponse.dart';
import 'package:my_idena/beans/rpc/dna_getFlipRaw_response.dart';
import 'package:my_idena/beans/rpc/flip_get_response.dart';
import 'package:my_idena/beans/rpc/httpService.dart';
import 'package:my_idena/beans/test/flip_example_1..dart';
import 'package:my_idena/beans/test/flip_example_2.dart';
import 'package:my_idena/beans/test/flip_example_3.dart';
import 'package:my_idena/beans/test/flip_example_4.dart';
import 'package:my_idena/beans/test/flip_example_5.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;
import 'package:ethereum_util/src/rlp.dart' as Rlp;
import 'package:ethereum_util/ethereum_util.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/beans/rpc/dna_all.dart';
import 'package:my_idena/constants/bottomNavigationBarMyIdena.dart';
import 'package:my_idena/constants/containerMyIdena.dart';
import 'package:my_idena/utils/util_timer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ValidationSession extends StatefulWidget {
  final DnaAll dnaAll;

  ValidationSession({Key key, this.dnaAll}) : super(key: key);

  @override
  _ValidationSessionState createState() => _ValidationSessionState();
}

FlipShortHashesRequest flipShortHashesRequest;
FlipShortHashesResponse flipShortHashesResponse;

class _ValidationSessionState extends State<ValidationSession> {
  final HttpService httpService = HttpService();
  List selectionFlipList = new List(5);
  List flipList = new List(5);
  int bottomSelectedIndex = 0;
  List base64String = new List(4);
  List base64StringList = new List(5);

  /* RLP Part start */
  List<dynamic> images = new List(2);

  Uint8List _image;
  Uint8List _image2;
  var __image;

  /*
  Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          image: new DecorationImage(
              fit: BoxFit.cover, image: MemoryImage(_image, scale: 0.5)),
        ),),
   */
  /* RLP Part end */


  @override
  void initState() {
    super.initState();

    /* RPL Part start */
    Future<FlipShortHashesResponse> flipShortHashesResponse = httpService.getFlipShortHashes();

    var orders;
    var toto = [];
    var encoded = "";
    Decoded decoded = Rlp.decode(Uint8List.fromList(toBuffer(encoded)), true);
    images = decoded.data[0];
    _image = images[0];
    _image2 = images[1];

    /* RPL Part end */


    //Future<GetFlipRawResponse> getFlipRawResponse = httpService.getFlipRaw("bafkreibes2fqhsbfnmg4fgh3ltozoxc3rbxpifonkmd7x6vmmvmfmteu4q");

    base64StringList[0] = new FlipExample1().base64String;
    base64StringList[1] = new FlipExample2().base64String;
    base64StringList[2] = new FlipExample3().base64String;
    base64StringList[3] = new FlipExample4().base64String;
    base64StringList[4] = new FlipExample5().base64String;

    for (int i = 0; i < selectionFlipList.length; i++) {
      selectionFlipList[i] = 0;
    }

    for (int i = 0; i < flipList.length; i++) {
      List imageFlipList = new List(4);

      imageFlipList[0] = Image.memory(
        base64Decode(base64StringList[i][0]),
        height: 100,
      );
      imageFlipList[1] = Image.memory(
        base64Decode(base64StringList[i][1]),
        height: 100,
      );
      imageFlipList[2] = Image.memory(
        base64Decode(base64StringList[i][2]),
        height: 100,
      );
      imageFlipList[3] = Image.memory(
        base64Decode(base64StringList[i][3]),
        height: 100,
      );

      flipList[i] = imageFlipList;
    }

    // TODO on force la short session
    widget.dnaAll.dnaGetEpochResponse.result.currentPeriod =
        EpochPeriod.ShortSession;
    if (widget.dnaAll.dnaGetEpochResponse.result.currentPeriod ==
        EpochPeriod.ShortSession) {
      _startTimerCurrentPeriod(widget
          .dnaAll.dnaCeremonyIntervalsResponse.result.shortSessionDuration);
    } else {
      if (widget.dnaAll.dnaGetEpochResponse.result.currentPeriod ==
          EpochPeriod.LongSession) {
        _startTimerCurrentPeriod(widget
            .dnaAll.dnaCeremonyIntervalsResponse.result.longSessionDuration);
      }
    }
  }

  int _counter = 10;
  Timer _timer;

  void _startTimerCurrentPeriod(int duration) {
    _counter = duration;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
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
    return new Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      bottomNavigationBar: BottomNavigationBarMyIdena(indexInit: 2),
      body: FutureBuilder(
          future: httpService.getFlipShortHashes(),
          builder: (BuildContext context,
              AsyncSnapshot<FlipShortHashesResponse> snapshot) {
            if (snapshot.hasData) {
              flipShortHashesResponse = snapshot.data;
              if (flipShortHashesResponse != null) {
                return SafeArea(
                  child: Stack(
                    children: <Widget>[
                      ContainerMyIdena(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)
                                  .translate("my Idena"),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 50,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (index) {
                            pageChanged(index);
                          },
                          children: <Widget>[
                            for (var item in selectionFlipList)
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 9.0, horizontal: 21.0),
                                child: ListView(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            decoration: selectionFlipList[
                                                        bottomSelectedIndex] ==
                                                    1
                                                ? new BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: new Border.all(
                                                        color: Colors.green,
                                                        width: 5))
                                                : new BoxDecoration(
                                                    border: new Border.all(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 0),
                                                        width: 5)),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectionFlipList[
                                                      bottomSelectedIndex] = 1;
                                                });
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  flipList[bottomSelectedIndex]
                                                      [0],
                                                  flipList[bottomSelectedIndex]
                                                      [1],
                                                  flipList[bottomSelectedIndex]
                                                      [2],
                                                  flipList[bottomSelectedIndex]
                                                      [3],
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: selectionFlipList[
                                                        bottomSelectedIndex] ==
                                                    2
                                                ? new BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: new Border.all(
                                                        color: Colors.green,
                                                        width: 5))
                                                : new BoxDecoration(
                                                    border: new Border.all(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 0),
                                                        width: 5)),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectionFlipList[
                                                      bottomSelectedIndex] = 2;
                                                });
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  flipList[bottomSelectedIndex]
                                                      [1],
                                                  flipList[bottomSelectedIndex]
                                                      [3],
                                                  flipList[bottomSelectedIndex]
                                                      [0],
                                                  flipList[bottomSelectedIndex]
                                                      [2],
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 480,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 9.0, horizontal: 21.0),
                              padding: EdgeInsets.all(3),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SmoothPageIndicator(
                                      controller:
                                          pageController, // PageController
                                      count: 5,
                                      effect: ExpandingDotsEffect(
                                        dotColor: Colors.white,
                                        activeDotColor: Colors.blue[800],
                                      ), // your preferred effect
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 520,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 9.0, horizontal: 21.0),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  children: <Widget>[
                                    (_counter > 0)
                                        ? Text(
                                            widget.dnaAll.dnaGetEpochResponse
                                                    .result.currentPeriod +
                                                " : " +
                                                constructTime(_counter),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                          )
                                        : Text("")
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
              } else {
                return Center(child: CircularProgressIndicator());
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
