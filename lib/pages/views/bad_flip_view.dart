import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'assets/images/oDjyU6n.png',
  'assets/images/Jdn57tT.jpg',
  'assets/images/nV3UqZY.jpg',
  'assets/images/t2yZ6g5.jpg',
  'assets/images/Ax39IvJ.jpg',
  'assets/images/1CTnBFo.jpg',
];

class BadFlipView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const BadFlipView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _BadFlipViewState createState() => _BadFlipViewState();
}

class _BadFlipViewState extends State<BadFlipView> {
  int _current = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      topRight: Radius.circular(8.0)),
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
                      padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, top: 4),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4, top: 8, bottom: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 700,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .translate(
                                                                      "A bad flip penalizes you in iDNA"),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              FlevaIcons
                                                                  .close_square_outline,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "A bad flip has NO logical story, even if it uses both keywords."),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        MyIdenaAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    color: MyIdenaAppTheme
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              FlevaIcons
                                                                  .close_square_outline,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "A bad flip contains numbers or letters on images."),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        MyIdenaAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    color: MyIdenaAppTheme
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              FlevaIcons
                                                                  .close_square_outline,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "A bad flip is hard to understand."),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        MyIdenaAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    color: MyIdenaAppTheme
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              FlevaIcons
                                                                  .close_square_outline,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "A bad flip contains hateful, inappropriate or NSFW content."),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        MyIdenaAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    color: MyIdenaAppTheme
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              FlevaIcons
                                                                  .close_square_outline,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "A bad flip does NOT USE BOTH keywords in the story."),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        MyIdenaAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    color: MyIdenaAppTheme
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              FlevaIcons
                                                                  .close_square_outline,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "A bad flip uses objects in images in sequence (1-2-3-4)."),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        MyIdenaAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    color: MyIdenaAppTheme
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(width: 10, height: 10,),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "If even one of your submitted flips are reported during validation, you loose 100% of your rewards including invitation rewards for that validation"),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        MyIdenaAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    color: MyIdenaAppTheme
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Expanded(
                                                            child:
                                                                CarouselSlider(
                                                          options:
                                                              CarouselOptions(
                                                                  aspectRatio:
                                                                      1.0,
                                                                  enlargeCenterPage:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  onPageChanged:
                                                                      (index,
                                                                          reason) {
                                                                    setState(
                                                                        () {
                                                                      _current =
                                                                          index;
                                                                    });
                                                                  }),
                                                          items: imgList
                                                              .map(
                                                                  (item) =>
                                                                      Container(
                                                                        child: Center(
                                                                            child:
                                                                                Image.asset(item)),
                                                                      ))
                                                              .toList(),
                                                        )),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: imgList
                                                              .map((url) {
                                                            int index = imgList
                                                                .indexOf(url);
                                                            return Container(
                                                              width: 8.0,
                                                              height: 8.0,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10.0,
                                                                      horizontal:
                                                                          2.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: _current ==
                                                                        index
                                                                    ? Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.9)
                                                                    : Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.4),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ],
                                                    ),
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
}
