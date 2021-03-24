// @dart=2.9
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';

class ValidationBasics extends StatefulWidget {
  final AnimationController ValidationBasicsController;
  bool ValidationBasicsOpen;

  ValidationBasics(this.ValidationBasicsController, this.ValidationBasicsOpen);

  _ValidationBasicsState createState() => _ValidationBasicsState();
}

class _ValidationBasicsState extends State<ValidationBasics> {
  final Logger log = sl.get<Logger>();

  final List<String> imgListGoodFlip = [
    'assets/images/MLxLbPf.png',
    'assets/images/JjSbN82.png',
    'assets/images/kfesVk9.png',
    'assets/images/8W1F0vx.png',
    'assets/images/c0CTFVj.png'
  ];

  final List<String> imgListBadFlip = [
    'assets/images/oDjyU6n.png',
    'assets/images/Jdn57tT.jpg',
    'assets/images/nV3UqZY.jpg',
    'assets/images/t2yZ6g5.jpg',
    'assets/images/Ax39IvJ.jpg',
    'assets/images/1CTnBFo.jpg',
  ];

  int _currentGoodFlip = 0;
  int _currentBadFlip = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDark,
          boxShadow: [
            BoxShadow(
                color: StateContainer.of(context).curTheme.overlay30,
                offset: Offset(-5, 0),
                blurRadius: 20),
          ],
        ),
        child: SafeArea(
          minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.035,
            top: 60,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10.0, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          //Back button
                          Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: FlatButton(
                                highlightColor:
                                    StateContainer.of(context).curTheme.text15,
                                splashColor:
                                    StateContainer.of(context).curTheme.text15,
                                onPressed: () {
                                  setState(() {
                                    widget.ValidationBasicsOpen = false;
                                  });
                                  widget.ValidationBasicsController.reverse();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                padding: EdgeInsets.all(8.0),
                                child: Icon(AppIcons.back,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .text,
                                    size: 24)),
                          ),
                          // Header Text
                          Text(
                            AppLocalization.of(context).validationBasicsHeader,
                            style: AppStyles.textStyleSettingsHeader(context),
                          ),
                        ],
                      ),
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
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    AppLocalization.of(context)
                                                        .validationBasicsGoodFlipRewardHeader,
                                                    style: AppStyles
                                                        .textStyleParagraphPrimary(
                                                            context)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.green,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsGoodFlipItem1,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.green,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsGoodFlipItem2,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.green,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsGoodFlipItem3,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.green,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsGoodFlipItem4,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.green,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsGoodFlipItem5,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.green,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsGoodFlipItem6,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.green,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsGoodFlipItem7,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.green,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsGoodFlipItem8,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                                child: CarouselSlider(
                                              options: CarouselOptions(
                                                  aspectRatio: 1.0,
                                                  enlargeCenterPage: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  onPageChanged:
                                                      (index, reason) {
                                                    setState(() {
                                                      _currentGoodFlip = index;
                                                    });
                                                  }),
                                              items: imgListGoodFlip
                                                  .map((item) => Container(
                                                        child: Center(
                                                            child: Image.asset(
                                                                item)),
                                                      ))
                                                  .toList(),
                                            )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children:
                                                  imgListGoodFlip.map((url) {
                                                int index = imgListGoodFlip
                                                    .indexOf(url);
                                                return Container(
                                                  width: 8.0,
                                                  height: 8.0,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 2.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _currentGoodFlip ==
                                                            index
                                                        ? Color.fromRGBO(
                                                            0, 0, 0, 0.9)
                                                        : Color.fromRGBO(
                                                            0, 0, 0, 0.4),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 700,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    AppLocalization.of(context)
                                                        .validationBasicsBadFlipRewardHeader,
                                                    style: AppStyles
                                                        .textStyleParagraphPrimary(
                                                            context)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsBadFlipItem1,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsBadFlipItem2,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsBadFlipItem3,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsBadFlipItem4,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsBadFlipItem5,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  FlevaIcons
                                                      .checkmark_square_2_outline,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsBadFlipItem6,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [

                                                Expanded(
                                                  child: Text(
                                                      AppLocalization.of(
                                                              context)
                                                          .validationBasicsBadFlipItem7,
                                                      style: AppStyles
                                                          .textStyleParagraph(
                                                              context)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                                child: CarouselSlider(
                                              options: CarouselOptions(
                                                  aspectRatio: 1.0,
                                                  enlargeCenterPage: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  onPageChanged:
                                                      (index, reason) {
                                                    setState(() {
                                                      _currentBadFlip = index;
                                                    });
                                                  }),
                                              items: imgListBadFlip
                                                  .map((item) => Container(
                                                        child: Center(
                                                            child: Image.asset(
                                                                item)),
                                                      ))
                                                  .toList(),
                                            )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children:
                                                  imgListBadFlip.map((url) {
                                                int index =
                                                    imgListBadFlip.indexOf(url);
                                                return Container(
                                                  width: 8.0,
                                                  height: 8.0,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 2.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        _currentBadFlip == index
                                                            ? Color.fromRGBO(
                                                                0, 0, 0, 0.9)
                                                            : Color.fromRGBO(
                                                                0, 0, 0, 0.4),
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
              ],
            ),
          ),
        ));
  }
}
