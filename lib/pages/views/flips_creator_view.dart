import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/backoffice/bean/dna_identity_response.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:my_idena/pages/widgets/line_widget.dart';
import 'package:my_idena/pages/widgets/text_above_line_widget.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/orderable_stack.dart';
import 'package:my_idena/utils/util_flip.dart';
import 'package:my_idena/utils/util_img.dart';
import 'package:my_idena/enums/identity_status.dart' as IdentityStatus;

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
  List<Asset> images = List<Asset>();

  HttpService httpService = HttpService();
  DnaIdentityResponse dnaIdentityResponse;
  int flipKeyWordPairsNumber;
  DnaAll dnaAll;
  UtilFlip utilFlip = new UtilFlip();
  int step;
  Image imgToDisplay_1;
  Image imgToDisplay_2;
  Image imgToDisplay_3;
  Image imgToDisplay_4;
  List<Img> imgs;

  ValueNotifier<List<Img>> orderNotifier = ValueNotifier<List<Img>>(null);
  Image imgToDisplayMix_1;
  Image imgToDisplayMix_2;
  Image imgToDisplayMix_3;
  Image imgToDisplayMix_4;

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
          imgToDisplay_1 = null;
          imgToDisplay_2 = null;
          imgToDisplay_3 = null;
          imgToDisplay_4 = null;
          return buildStep1(context);
        }
        break;
      case 2:
        {
          imgToDisplay_1 = null;
          imgToDisplay_2 = null;
          imgToDisplay_3 = null;
          imgToDisplay_4 = null;
          return buildStep2(context);
        }
        break;
      case 3:
        {
          imgToDisplayMix_1 = imgToDisplay_1;
          imgToDisplayMix_2 = imgToDisplay_2;
          imgToDisplayMix_3 = imgToDisplay_3;
          imgToDisplayMix_4 = imgToDisplay_4;
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
                                            textAboveLineWidget(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        "Think up a story"),
                                                14),
                                            lineWidget(70),
                                            SizedBox(height: 10.0),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      "Think up a short story about someone/something related to the two key words below according to the template"),
                                              style: TextStyle(
                                                fontFamily:
                                                    MyIdenaAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                color: MyIdenaAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            SizedBox(height: 10.0),
                                            new Container(
                                              height: 200,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 3,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                              dictWords
                                                                      .words[dnaAll
                                                                          .dnaIdentityResponse
                                                                          .result
                                                                          .flipKeyWordPairs
                                                                          .elementAt(
                                                                              flipKeyWordPairsNumber)
                                                                          .words[0]]
                                                                      .name +
                                                                  " : ",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      -0.1,
                                                                  color: MyIdenaAppTheme
                                                                      .darkText),
                                                            ),
                                                            Text(
                                                              dictWords
                                                                  .words[dnaAll
                                                                      .dnaIdentityResponse
                                                                      .result
                                                                      .flipKeyWordPairs
                                                                      .elementAt(
                                                                          flipKeyWordPairsNumber)
                                                                      .words[0]]
                                                                  .desc,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      -0.1,
                                                                  color: MyIdenaAppTheme
                                                                      .darkText),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                              dictWords
                                                                      .words[dnaAll
                                                                          .dnaIdentityResponse
                                                                          .result
                                                                          .flipKeyWordPairs
                                                                          .elementAt(
                                                                              flipKeyWordPairsNumber)
                                                                          .words[1]]
                                                                      .name +
                                                                  " : ",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      -0.1,
                                                                  color: MyIdenaAppTheme
                                                                      .darkText),
                                                            ),
                                                            Text(
                                                              dictWords
                                                                  .words[dnaAll
                                                                      .dnaIdentityResponse
                                                                      .result
                                                                      .flipKeyWordPairs
                                                                      .elementAt(
                                                                          flipKeyWordPairsNumber)
                                                                      .words[1]]
                                                                  .desc,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      -0.1,
                                                                  color: MyIdenaAppTheme
                                                                      .darkText),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RaisedButton(
                                                      elevation: 5.0,
                                                      onPressed: () async {
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
                                                                .circular(20.0),
                                                      ),
                                                      color: Colors.white,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.autorenew,
                                                              color:
                                                                  Colors.black,
                                                              size: 18,
                                                            ),
                                                            Text(
                                                              AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "Change words") +
                                                                  " (#" +
                                                                  (flipKeyWordPairsNumber +
                                                                          1)
                                                                      .toString() +
                                                                  ")",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                letterSpacing:
                                                                    1.5,
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    MyIdenaAppTheme
                                                                        .fontName,
                                                              ),
                                                            ),
                                                          ])),
                                                  SizedBox(height: 10.0),
                                                  RaisedButton(
                                                    elevation: 5.0,
                                                    onPressed: () async {
                                                      setState(() {
                                                        step = 2;
                                                      });
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    ),
                                                    color: Colors.white,
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "Next step"),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          letterSpacing: 1.5,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              MyIdenaAppTheme
                                                                  .fontName,
                                                        )),
                                                  ),
                                                  SizedBox(height: 10.0),
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
                                textAboveLineWidget(
                                    AppLocalizations.of(context).translate(
                                        "Select 4 images to tell your story"),
                                    16),
                                lineWidget(70),
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
                                Align(
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                    elevation: 5.0,
                                    onPressed: loadAssets,
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("Pick images"),
                                      style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 1.5,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: MyIdenaAppTheme.fontName,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    height: 405,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new SizedBox(
                                          child: FutureBuilder<Widget>(
                                              future: getImage(1),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Widget>
                                                      snapshot) {
                                                if (snapshot.hasData == false) {
                                                  return Center(
                                                      child: Container(
                                                          child: Icon(Icons
                                                              .add_a_photo_outlined)));
                                                } else {
                                                  return snapshot.data;
                                                }
                                              }),
                                        ),
                                        SizedBox(height: 5.0),
                                        new SizedBox(
                                          child: FutureBuilder<Widget>(
                                              future: getImage(2),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Widget>
                                                      snapshot) {
                                                if (snapshot.hasData == false) {
                                                  return Center(
                                                      child: Container(
                                                          child: Icon(Icons
                                                              .add_a_photo_outlined)));
                                                } else {
                                                  return snapshot.data;
                                                }
                                              }),
                                        ),
                                        SizedBox(height: 5.0),
                                        new SizedBox(
                                          child: FutureBuilder<Widget>(
                                              future: getImage(3),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Widget>
                                                      snapshot) {
                                                if (snapshot.hasData == false) {
                                                  return Center(
                                                      child: Container(
                                                          child: Icon(Icons
                                                              .add_a_photo_outlined)));
                                                } else {
                                                  return snapshot.data;
                                                }
                                              }),
                                        ),
                                        SizedBox(height: 5.0),
                                        new SizedBox(
                                          child: FutureBuilder<Widget>(
                                              future: getImage(4),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Widget>
                                                      snapshot) {
                                                if (snapshot.hasData == false) {
                                                  return Center(
                                                      child: Container(
                                                          child: Icon(Icons
                                                              .add_a_photo_outlined)));
                                                } else {
                                                  return snapshot.data;
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
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
                                        images != null && images.length == 4
                                            ? RaisedButton(
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
                                                      BorderRadius.circular(
                                                          30.0),
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
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 1,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                textAboveLineWidget(
                                    AppLocalizations.of(context)
                                        .translate("Shuffle images"),
                                    16),
                                lineWidget(70),
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
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 390,
                                    child: Column(
                                      children: <Widget>[
                                        Opacity(
                                            opacity: 0.5,
                                            child: imgToDisplay_1),
                                        Opacity(
                                            opacity: 0.5,
                                            child: imgToDisplay_2),
                                        Opacity(
                                            opacity: 0.5,
                                            child: imgToDisplay_3),
                                        Opacity(
                                            opacity: 0.5,
                                            child: imgToDisplay_4),
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
                              padding: const EdgeInsets.only(top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 390,
                                    child: Column(
                                      children: <Widget>[
                                        OrderableStack<Img>(
                                            items: imgs,
                                            itemSize: Size(130, 97.5),
                                            margin: 0.0,
                                            direction: Direction.Vertical,
                                            itemBuilder: imgItemBuilder,
                                            onChange: (List<Img> orderedList) =>
                                                orderNotifier.value =
                                                    orderedList),
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
                              if (isMixed(orderNotifier.value)) {
                                showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                          contentPadding: EdgeInsets.zero,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "Please, mix your images"),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                        fontSize: 20.0,
                                                      )),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  new Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      FlatButton(
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    "Ok"),
                                                          ),
                                                          color:
                                                              Colors.grey[200],
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          onPressed: () {
                                                            setState(() {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          })
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ));
                              } else {
                                setState(() {
                                  setImgToDisplayMix(orderNotifier.value);
                                  step = 4;
                                });
                              }
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
                                textAboveLineWidget(
                                    AppLocalizations.of(context)
                                        .translate("Submit flip"),
                                    16),
                                lineWidget(70),
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
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 390,
                                    child: Column(
                                      children: <Widget>[
                                        imgToDisplay_1,
                                        imgToDisplay_2,
                                        imgToDisplay_3,
                                        imgToDisplay_4,
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
                              padding: const EdgeInsets.only(top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 390,
                                    child: Column(
                                      children: <Widget>[
                                        imgToDisplayMix_1,
                                        imgToDisplayMix_2,
                                        imgToDisplayMix_3,
                                        imgToDisplayMix_4,
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
                              if (dnaAll.dnaIdentityResponse.result.state ==
                                  IdentityStatus.Newbie) {
                                showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                          contentPadding: EdgeInsets.zero,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                      "Are you sure that you want to submit this flip ?",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                        fontSize: 20.0,
                                                      )),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "If you make BAD flip, you will lose all iDNA rewards !"),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                        fontSize: 15.0,
                                                      )),
                                                  SizedBox(height: 20.0),
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "The cost of deleting a flip is about 8 iDNA"),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                        fontSize: 15.0,
                                                      )),
                                                                SizedBox(height: 20.0),
                                                  new Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      FlatButton(
                                                          child: Text(
                                                            "Yes",
                                                          ),
                                                          color:
                                                              Colors.grey[200],
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          onPressed: () {
                                                            setState(() {
                                                              httpService.submitFlip(images);
                                                              Navigator
                                                                  .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Home()),
                                                              );
                                                            });
                                                          }),
                                                      FlatButton(
                                                          child: Text(
                                                            "No",
                                                          ),
                                                          color:
                                                              Colors.grey[200],
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          onPressed: () {
                                                            setState(() {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          }),
                                                
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ));
                              } else {
                                setState(() {
                                  httpService.submitFlip(images);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                });
                              }
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

  Future<Widget> getImage(int numImage) async {
    Image imgToDisplay;
    if (images.length > 0 && images[numImage - 1] != null) {
      ByteData byteData = await images[numImage - 1].getByteData();
      imgToDisplay = resizeImgByteData(byteData);
      if (numImage == 1) {
        imgToDisplay_1 = imgToDisplay;
      } else {
        if (numImage == 2) {
          imgToDisplay_2 = imgToDisplay;
        } else {
          if (numImage == 3) {
            imgToDisplay_3 = imgToDisplay;
          } else {
            if (numImage == 4) {
              imgToDisplay_4 = imgToDisplay;
            }
          }
        }
      }

      return Container(child: imgToDisplay);
    } else {
      return Container();
    }
  }

  Future uploadPic(BuildContext context) async {
    setState(() {
      imgs = [
        Img(imgToDisplay_1, 1),
        Img(imgToDisplay_2, 2),
        Img(imgToDisplay_3, 3),
        Img(imgToDisplay_4, 4),
      ];
    });
  }

  bool isMixed(List<Img> orderedList) {
    bool isMixed;
    (orderedList[0].image == imgToDisplayMix_1 &&
            orderedList[1].image == imgToDisplayMix_2 &&
            orderedList[2].image == imgToDisplayMix_3 &&
            orderedList[3].image == imgToDisplayMix_4)
        ? isMixed = true
        : isMixed = false;
    return isMixed;
  }

  void setImgToDisplayMix(List<Img> orderedList) {
    if (orderedList != null) {
      for (int i = 0; i < orderedList.length; i++) {
        if (i == 0) {
          if (orderedList[i].numOrder == 1) {
            imgToDisplayMix_1 = orderedList[i].image;
          } else {
            if (orderedList[i].numOrder == 2) {
              imgToDisplayMix_1 = orderedList[i].image;
            } else {
              if (orderedList[i].numOrder == 3) {
                imgToDisplayMix_1 = orderedList[i].image;
              } else {
                if (orderedList[i].numOrder == 4) {
                  imgToDisplayMix_1 = orderedList[i].image;
                }
              }
            }
          }
        }
        if (i == 1) {
          if (orderedList[i].numOrder == 1) {
            imgToDisplayMix_2 = orderedList[i].image;
          } else {
            if (orderedList[i].numOrder == 2) {
              imgToDisplayMix_2 = orderedList[i].image;
            } else {
              if (orderedList[i].numOrder == 3) {
                imgToDisplayMix_2 = orderedList[i].image;
              } else {
                if (orderedList[i].numOrder == 4) {
                  imgToDisplayMix_2 = orderedList[i].image;
                }
              }
            }
          }
        }
        if (i == 2) {
          if (orderedList[i].numOrder == 1) {
            imgToDisplayMix_3 = orderedList[i].image;
          } else {
            if (orderedList[i].numOrder == 2) {
              imgToDisplayMix_3 = orderedList[i].image;
            } else {
              if (orderedList[i].numOrder == 3) {
                imgToDisplayMix_3 = orderedList[i].image;
              } else {
                if (orderedList[i].numOrder == 4) {
                  imgToDisplayMix_3 = orderedList[i].image;
                }
              }
            }
          }
        }
        if (i == 3) {
          if (orderedList[i].numOrder == 1) {
            imgToDisplayMix_4 = orderedList[i].image;
          } else {
            if (orderedList[i].numOrder == 2) {
              imgToDisplayMix_4 = orderedList[i].image;
            } else {
              if (orderedList[i].numOrder == 3) {
                imgToDisplayMix_4 = orderedList[i].image;
              } else {
                if (orderedList[i].numOrder == 4) {
                  imgToDisplayMix_4 = orderedList[i].image;
                }
              }
            }
          }
        }
      }
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "my Idena",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  Widget imgItemBuilder({Orderable<Img> data, Size itemSize}) => Container(
        color: data != null && !data.selected
            ? data.dataIndex == data.visibleIndex
                ? Colors.grey
                : Colors.grey
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
