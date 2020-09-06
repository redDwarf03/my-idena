import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/bean/dna_identity_response.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/beans/dictWords.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/orderable_stack.dart';
import 'package:my_idena/utils/util_flip.dart';
import 'package:my_idena/utils/util_hexcolor.dart';
import 'package:my_idena/utils/util_img.dart';

class FlipsCreatorView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final DnaAll dnaAll;
  final int step;

  FlipsCreatorView(
      {Key key,
      this.animationController,
      this.animation,
      this.dnaAll,
      this.step})
      : super(key: key);

  @override
  _FlipsCreatorViewState createState() => _FlipsCreatorViewState();
}

class _FlipsCreatorViewState extends State<FlipsCreatorView> {
  final DictWords dictWordsLoad = DictWords();
  HttpService httpService = HttpService();
  DictWords dictWords;
  DnaIdentityResponse dnaIdentityResponse;
  int flipKeyWordPairsNumber;
  DnaAll dnaAll;
  UtilFlip utilFlip = new UtilFlip();
  int step;
  File imgFile_1;
  File imgFile_2;
  File imgFile_3;
  File imgFile_4;
  Image imgToDisplay_1;
  Image imgToDisplay_2;
  Image imgToDisplay_3;
  Image imgToDisplay_4;
  List<Img> imgs;
  File galleryFile;
  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    step = widget.step;

    switch (step) {
      case 1:
        {
          flipKeyWordPairsNumber =
              utilFlip.getFirstFlipKeyWordPairsNotUsed(widget.dnaAll);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (step) {
      case 1:
        {
          return buildStep1(context);
        }
        break;
      case 2:
        {
          return buildStep2(context);
        }
        break;
      case 3:
        {
          return buildStep3(context);
        }
        break;
      case 4:
        {
          return buildStep4(context);
        }
        break;
      default:
        {
          return buildStep1(context);
        }
    }
  }

  Widget buildStep1(BuildContext context) {
    return FutureBuilder(
        future: httpService.getDnaAll(),
        builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
          if (snapshot.hasData) {
            dnaAll = snapshot.data;
            if (dnaAll == null || dnaAll.dnaIdentityResponse == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return FutureBuilder(
                  future: dictWordsLoad.getDictWords(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DictWords> snapshot) {
                    if (snapshot.hasData) {
                      dictWords = snapshot.data;

                      return AnimatedBuilder(
                        animation: widget.animationController,
                        builder: (BuildContext context, Widget child) {
                          return FadeTransition(
                            opacity: widget.animation,
                            child: new Transform(
                              transform: new Matrix4.translationValues(0.0,
                                  30 * (1.0 - widget.animation.value), 0.0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, top: 16, bottom: 18),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: MyIdenaAppTheme.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.circular(8.0),
                                        topRight: Radius.circular(68.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: MyIdenaAppTheme.grey
                                              .withOpacity(0.2),
                                          offset: Offset(1.1, 1.1),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, left: 16, right: 16),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8, top: 4),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "Think up a story"),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        letterSpacing: -0.2,
                                                        color: MyIdenaAppTheme
                                                            .darkText,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      child: Container(
                                                        height: 4,
                                                        width: 70,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: HexColor(
                                                                  '#000000')
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.0)),
                                                        ),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              width: 70,
                                                              height: 4,
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                        colors: [
                                                                      HexColor(
                                                                              '#000000')
                                                                          .withOpacity(
                                                                              0.1),
                                                                      HexColor(
                                                                          '#000000'),
                                                                    ]),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4.0)),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "Think up a short story about someone/something related to the two key words below according to the template"),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 13,
                                                        color: MyIdenaAppTheme
                                                            .grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    new Container(
                                                      height: 200,
                                                      child: Column(
                                                        children: [
                                                          Flexible(
                                                            flex: 3,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      dictWords
                                                                              .words[dnaAll.dnaIdentityResponse.result.flipKeyWordPairs.elementAt(flipKeyWordPairsNumber).words[0]]
                                                                              .name +
                                                                          " : ",
                                                                      style: TextStyle(
                                                                          fontFamily: MyIdenaAppTheme
                                                                              .fontName,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              -0.1,
                                                                          color:
                                                                              MyIdenaAppTheme.darkText),
                                                                    ),
                                                                    Text(
                                                                      dictWords
                                                                          .words[dnaAll
                                                                              .dnaIdentityResponse
                                                                              .result
                                                                              .flipKeyWordPairs
                                                                              .elementAt(flipKeyWordPairsNumber)
                                                                              .words[0]]
                                                                          .desc,
                                                                      style: TextStyle(
                                                                          fontFamily: MyIdenaAppTheme
                                                                              .fontName,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              -0.1,
                                                                          color:
                                                                              MyIdenaAppTheme.darkText),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      dictWords
                                                                              .words[dnaAll.dnaIdentityResponse.result.flipKeyWordPairs.elementAt(flipKeyWordPairsNumber).words[1]]
                                                                              .name +
                                                                          " : ",
                                                                      style: TextStyle(
                                                                          fontFamily: MyIdenaAppTheme
                                                                              .fontName,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              -0.1,
                                                                          color:
                                                                              MyIdenaAppTheme.darkText),
                                                                    ),
                                                                    Text(
                                                                      dictWords
                                                                          .words[dnaAll
                                                                              .dnaIdentityResponse
                                                                              .result
                                                                              .flipKeyWordPairs
                                                                              .elementAt(flipKeyWordPairsNumber)
                                                                              .words[1]]
                                                                          .desc,
                                                                      style: TextStyle(
                                                                          fontFamily: MyIdenaAppTheme
                                                                              .fontName,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              -0.1,
                                                                          color:
                                                                              MyIdenaAppTheme.darkText),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RaisedButton(
                                                              elevation: 5.0,
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  flipKeyWordPairsNumber =
                                                                      utilFlip.findNextFlipKeyWordPairsNotUsed(
                                                                          dnaAll,
                                                                          flipKeyWordPairsNumber +
                                                                              1);
                                                                });
                                                              },
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .autorenew,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 18,
                                                                    ),
                                                                    Text(
                                                                      AppLocalizations.of(context).translate(
                                                                              "Change words") +
                                                                          " (#" +
                                                                          (flipKeyWordPairsNumber + 1)
                                                                              .toString() +
                                                                          ")",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        letterSpacing:
                                                                            1.5,
                                                                        fontSize:
                                                                            12.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            MyIdenaAppTheme.fontName,
                                                                      ),
                                                                    ),
                                                                  ])),
                                                          SizedBox(
                                                              height: 10.0),
                                                          RaisedButton(
                                                            elevation: 5.0,
                                                            onPressed:
                                                                () async {
                                                              setState(() {
                                                                step = 2;
                                                              });
                                                            },
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                            color: Colors.white,
                                                            child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "Next step"),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  letterSpacing:
                                                                      1.5,
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                )),
                                                          ),
                                                          SizedBox(
                                                              height: 10.0),
                                                        ],
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
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildStep2(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: MyIdenaAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: MyIdenaAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context).translate(
                                      "Select 4 images to tell your story"),
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: MyIdenaAppTheme.darkText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                    height: 4,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color:
                                          HexColor('#000000').withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 70,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              HexColor('#000000')
                                                  .withOpacity(0.1),
                                              HexColor('#000000'),
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  AppLocalizations.of(context).translate(
                                          "Use keywords for the story") +
                                      " \"" +
                                      dictWords
                                          .words[dnaAll.dnaIdentityResponse
                                              .result.flipKeyWordPairs
                                              .elementAt(flipKeyWordPairsNumber)
                                              .words[0]]
                                          .name +
                                      "\" / \"" +
                                      dictWords
                                          .words[dnaAll.dnaIdentityResponse
                                              .result.flipKeyWordPairs
                                              .elementAt(flipKeyWordPairsNumber)
                                              .words[1]]
                                          .name +
                                      "\" " +
                                      AppLocalizations.of(context).translate(
                                          "and template \"Before – Something happens – After\""),
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color:
                                        MyIdenaAppTheme.grey.withOpacity(0.5),
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context).translate(
                                      "Please no text on images to explain your story"),
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color:
                                        MyIdenaAppTheme.grey.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 500,
                                    child: ListView(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.0),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.camera_enhance,
                                                  size: 30.0,
                                                ),
                                                onPressed: () {
                                                  getImage_1();
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: new SizedBox(
                                                  height: 120.0,
                                                  child:
                                                      (imgToDisplay_1 != null)
                                                          ? imgToDisplay_1
                                                          : Icon(Icons.image,
                                                              size: 70.0)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.0),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.camera_enhance,
                                                  size: 30.0,
                                                ),
                                                onPressed: () {
                                                  getImage_2();
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: new SizedBox(
                                                  height: 120.0,
                                                  child:
                                                      (imgToDisplay_2 != null)
                                                          ? imgToDisplay_2
                                                          : Icon(Icons.image,
                                                              size: 70.0)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.0),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.camera_enhance,
                                                  size: 30.0,
                                                ),
                                                onPressed: () {
                                                  getImage_3();
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: new SizedBox(
                                                  height: 120.0,
                                                  child:
                                                      (imgToDisplay_3 != null)
                                                          ? imgToDisplay_3
                                                          : Icon(Icons.image,
                                                              size: 70.0)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.0),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.camera_enhance,
                                                  size: 30.0,
                                                ),
                                                onPressed: () {
                                                  getImage_4();
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: new SizedBox(
                                                  height: 120.0,
                                                  child:
                                                      (imgToDisplay_4 != null)
                                                          ? imgToDisplay_4
                                                          : Icon(Icons.image,
                                                              size: 70.0)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RaisedButton(
                                          elevation: 5.0,
                                          onPressed: () async {
                                            setState(() {
                                              step = 1;
                                            });
                                          },
                                          padding: EdgeInsets.all(15.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          color: Colors.white,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("Previous step"),
                                            style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 1.5,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  MyIdenaAppTheme.fontName,
                                            ),
                                          ),
                                        ),
                                        RaisedButton(
                                          elevation: 5.0,
                                          onPressed: () async {
                                            uploadPic(context);
                                            setState(() {
                                              step = 3;
                                            });
                                          },
                                          padding: EdgeInsets.all(15.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          color: Colors.white,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("Next step"),
                                            style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 1.5,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  MyIdenaAppTheme.fontName,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
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
            ),
          ),
        );
      },
    );
  }

  Widget buildStep3(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: MyIdenaAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: MyIdenaAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("Shuffle images"),
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: MyIdenaAppTheme.darkText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                    height: 4,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color:
                                          HexColor('#000000').withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 70,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              HexColor('#000000')
                                                  .withOpacity(0.1),
                                              HexColor('#000000'),
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  AppLocalizations.of(context).translate(
                                      "Shuffle images in order to make a nonsense sequence of images"),
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color:
                                        MyIdenaAppTheme.grey.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 390,
                                    child: ListView(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Opacity(
                                                opacity: 0.5,
                                                child: imgToDisplay_1),
                                            SizedBox(height: 5.0),
                                            Opacity(
                                                opacity: 0.5,
                                                child: imgToDisplay_2),
                                            SizedBox(height: 5.0),
                                            Opacity(
                                                opacity: 0.5,
                                                child: imgToDisplay_3),
                                            SizedBox(height: 5.0),
                                            Opacity(
                                                opacity: 0.5,
                                                child: imgToDisplay_4),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 390,
                                    child: ListView(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Center(
                                                child: OrderableStack<Img>(
                                                    items: imgs,
                                                    itemSize: Size(135, 102),
                                                    margin: 0.0,
                                                    direction:
                                                        Direction.Vertical,
                                                    itemBuilder: imgItemBuilder,
                                                    onChange: (List<Object>
                                                            orderedList) =>
                                                        orderNotifier.value =
                                                            orderedList
                                                                .toString())),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            elevation: 5.0,
                            onPressed: () async {
                              setState(() {
                                step = 2;
                              });
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("Previous step"),
                              style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1.5,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: MyIdenaAppTheme.fontName,
                              ),
                            ),
                          ),
                          RaisedButton(
                            elevation: 5.0,
                            onPressed: () async {
                              setState(() {
                                step = 4;
                              });
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("Next step"),
                              style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1.5,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: MyIdenaAppTheme.fontName,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildStep4(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: MyIdenaAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: MyIdenaAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("Submit flip"),
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: MyIdenaAppTheme.darkText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                    height: 4,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color:
                                          HexColor('#000000').withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 70,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              HexColor('#000000')
                                                  .withOpacity(0.1),
                                              HexColor('#000000'),
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  AppLocalizations.of(context).translate(
                                      "Make sure it is not possible to read the shuffled images as a meaningful story"),
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color:
                                        MyIdenaAppTheme.grey.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 390,
                                    child: ListView(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            imgToDisplay_1,
                                            SizedBox(height: 5.0),
                                            imgToDisplay_2,
                                            SizedBox(height: 5.0),
                                            imgToDisplay_3,
                                            SizedBox(height: 5.0),
                                            imgToDisplay_4,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 390,
                                    child: ListView(
                                      children: <Widget>[],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            elevation: 5.0,
                            onPressed: () async {
                              setState(() {
                                step = 3;
                              });
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("Previous step"),
                              style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1.5,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: MyIdenaAppTheme.fontName,
                              ),
                            ),
                          ),
                          RaisedButton(
                            elevation: 5.0,
                            onPressed: () async {
                              setState(() {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              });
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Text(
                              AppLocalizations.of(context).translate("Submit"),
                              style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1.5,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: MyIdenaAppTheme.fontName,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future getImage_1() async {
    imgFile_1 = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgToDisplay_1 = resizeImg(imgFile_1);
    });
  }

  Future getImage_2() async {
    imgFile_2 = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgToDisplay_2 = resizeImg(imgFile_2);
    });
  }

  Future getImage_3() async {
    imgFile_3 = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgToDisplay_3 = resizeImg(imgFile_3);
    });
  }

  Future getImage_4() async {
    imgFile_4 = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgToDisplay_4 = resizeImg(imgFile_4);
    });
  }

  Future uploadPic(BuildContext context) async {
    setState(() {
      imgs = [
        Img(imgToDisplay_1, "1"),
        Img(imgToDisplay_2, "2"),
        Img(imgToDisplay_3, "3"),
        Img(imgToDisplay_4, "4"),
      ];
    });
  }

  Widget imgItemBuilder({Orderable<Img> data, Size itemSize}) => Container(
        color: data != null && !data.selected
            ? data.dataIndex == data.visibleIndex ? Colors.grey : Colors.grey
            : Colors.green[400],
        height: 97,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              data.value.image,
            ])),
      );
}
