// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/dictWords.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/util/util_img.dart';

class CreationFlipsStep2Page extends StatefulWidget {
  final Word word1;
  final Word word2;

  CreationFlipsStep2Page({Key key, this.word1, this.word2}) : super(key: key);

  @override
  _CreationFlipsStep2PageState createState() => _CreationFlipsStep2PageState();
}

class _CreationFlipsStep2PageState extends State<CreationFlipsStep2Page> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Asset> images = List<Asset>();
  Image imgToDisplay_1;
  Image imgToDisplay_2;
  Image imgToDisplay_3;
  Image imgToDisplay_4;
  List<Img> imgs;

  @override
  void initState() {
    super.initState();

    imgToDisplay_1 = null;
    imgToDisplay_2 = null;
    imgToDisplay_3 = null;
    imgToDisplay_4 = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // Back Button
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 15 : 20),
                        height: 50,
                        width: 50,
                        child: FlatButton(
                            highlightColor:
                                StateContainer.of(context).curTheme.text15,
                            splashColor:
                                StateContainer.of(context).curTheme.text15,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Icon(AppIcons.back,
                                color: StateContainer.of(context).curTheme.text,
                                size: 24)),
                      ),
                      Text(
                        AppLocalization.of(context).flipsCreatorHeader,
                        style: AppStyles.textStyleSettingsHeader(context),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        start: smallScreen(context) ? 30 : 40,
                        end: smallScreen(context) ? 30 : 40,
                        top: 16.0),
                    child: AutoSizeText(
                      AppLocalization.of(context).flipsCreatorStep2Header,
                      style: AppStyles.textStyleParagraphPrimary(context),
                      maxLines: 5,
                      stepGranularity: 0.5,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: smallScreen(context) ? 30 : 40,
                        vertical: 20),
                    child: AutoSizeText(
                      AppLocalization.of(context).flipsCreatorStep2Info1 +
                          " \"" +
                          widget.word1.name +
                          "\" / \"" +
                          widget.word2.name +
                          "\" " +
                          AppLocalization.of(context).flipsCreatorStep2Info2,
                      style: AppStyles.textStyleParagraph(context),
                      maxLines: 4,
                      stepGranularity: 0.5,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 405,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new SizedBox(
                            child: FutureBuilder<Widget>(
                                future: getImage(1),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Widget> snapshot) {
                                  if (snapshot.hasData == false) {
                                    return Center(
                                        child: Container(
                                            child: Icon(
                                                Icons.add_a_photo_outlined)));
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
                                    AsyncSnapshot<Widget> snapshot) {
                                  if (snapshot.hasData == false) {
                                    return Center(
                                        child: Container(
                                            child: Icon(
                                                Icons.add_a_photo_outlined)));
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
                                    AsyncSnapshot<Widget> snapshot) {
                                  if (snapshot.hasData == false) {
                                    return Center(
                                        child: Container(
                                            child: Icon(
                                                Icons.add_a_photo_outlined)));
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
                                    AsyncSnapshot<Widget> snapshot) {
                                  if (snapshot.hasData == false) {
                                    return Center(
                                        child: Container(
                                            child: Icon(
                                                Icons.add_a_photo_outlined)));
                                  } else {
                                    return snapshot.data;
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppButton.buildAppButton(
                      context,
                      AppButtonType.PRIMARY,
                      AppLocalization.of(context).flipsCreatorStep2PickImages,
                      Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                    loadAssets();
                  }),
                  AppButton.buildAppButton(
                      context,
                      images.length == 4
                          ? AppButtonType.PRIMARY
                          : AppButtonType.TEXT_OUTLINE,
                      AppLocalization.of(context).flipsCreatorStep1NextStep,
                      Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                    if (images.length == 4) {
                      uploadPic(context);
                      Navigator.of(context).pushNamed('/creation_flips_step_3', arguments: {
                      'imgToDisplay_1': imgToDisplay_1,
                      'imgToDisplay_2': imgToDisplay_2,
                      'imgToDisplay_3': imgToDisplay_3,
                      'imgToDisplay_4': imgToDisplay_4
                    });
                    }
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
}
