import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'assets/images/MLxLbPf.png',
  'assets/images/JjSbN82.png',
  'assets/images/kfesVk9.png',
  'assets/images/8W1F0vx.png',
  'assets/images/c0CTFVj.png'
];

class GoodFlipView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const GoodFlipView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _GoodFlipViewState createState() => _GoodFlipViewState();
}

class _GoodFlipViewState extends State<GoodFlipView> {
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
                                                              "A good flip earns you rewards in iDNA",
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
                                                                color: Colors.green
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              FlevaIcons
                                                                  .checkmark_square_2_outline,
                                                              color:
                                                                  Colors.green,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "A good flip tells a story, assembled chronologically, to represent an event or a process from beginning to end.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                ),
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
                                                                  .checkmark_square_2_outline,
                                                              color:
                                                                  Colors.green,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "A good flip is EASY to solve for humans, but hard for robots.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                ),
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
                                                                  .checkmark_square_2_outline,
                                                              color:
                                                                  Colors.green,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "A good flip uses clear, simple images, and lets the story be obvious, with no ambiguity.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                ),
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
                                                                  .checkmark_square_2_outline,
                                                              color:
                                                                  Colors.green,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "A good flip uses no text.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                ),
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
                                                                  .checkmark_square_2_outline,
                                                              color:
                                                                  Colors.green,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "A good flip uses simple concepts that ANYONE IN THE WORLD will easily understand, regardless of their native language or culture.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                ),
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
                                                                  .checkmark_square_2_outline,
                                                              color:
                                                                  Colors.green,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "A good flip should be relevant to both of the seed words.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                ),
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
                                                                  .checkmark_square_2_outline,
                                                              color:
                                                                  Colors.green,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "A good flip makes use of the tools available including DRAWING and COLLAGE to help battle against AI and add creativity.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                ),
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
                                                                  .checkmark_square_2_outline,
                                                              color:
                                                                  Colors.green,
                                                              size: 18,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "A good flip uses the shuffle to create a 100% non logical alternative.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
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
