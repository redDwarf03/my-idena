// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/util/orderable_stack.dart';
import 'package:my_idena/util/util_img.dart';

class CreationFlipsStep3Page extends StatefulWidget {
  final Image imgToDisplay_1;
  final Image imgToDisplay_2;
  final Image imgToDisplay_3;
  final Image imgToDisplay_4;

  CreationFlipsStep3Page(
      {Key key,
      this.imgToDisplay_1,
      this.imgToDisplay_2,
      this.imgToDisplay_3,
      this.imgToDisplay_4})
      : super(key: key);

  @override
  _CreationFlipsStep3PageState createState() => _CreationFlipsStep3PageState();
}

class _CreationFlipsStep3PageState extends State<CreationFlipsStep3Page> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  ValueNotifier<List<Img>> orderNotifier = ValueNotifier<List<Img>>(null);
  List<Img> imgs;
  bool isMixed;

  @override
  void initState() {
    super.initState();

    setState(() {
      isMixed = true;
      imgs = [
        Img(widget.imgToDisplay_1, 1),
        Img(widget.imgToDisplay_2, 2),
        Img(widget.imgToDisplay_3, 3),
        Img(widget.imgToDisplay_4, 4),
      ];
    });
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
                      AppLocalization.of(context).flipsCreatorStep3Header,
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
                      AppLocalization.of(context).flipsCreatorStep3Info1,
                      style: AppStyles.textStyleParagraph(context),
                      maxLines: 4,
                      stepGranularity: 0.5,
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
                                      child: widget.imgToDisplay_1),
                                  Opacity(
                                      opacity: 0.5,
                                      child: widget.imgToDisplay_2),
                                  Opacity(
                                      opacity: 0.5,
                                      child: widget.imgToDisplay_3),
                                  Opacity(
                                      opacity: 0.5,
                                      child: widget.imgToDisplay_4),
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
                                      onChange: (List<Img> orderedList) {
                                        Future.delayed(Duration.zero, () async {
                                          orderNotifier.value = orderedList;
                                          isImagesMixed(orderedList);
                                        });
                                      }),
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
              Expanded(
                child: Stack(
                  children: <Widget>[],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppButton.buildAppButton(
                      context,
                      isMixed
                          ? AppButtonType.PRIMARY
                          : AppButtonType.TEXT_OUTLINE,
                      AppLocalization.of(context).flipsCreatorStep1NextStep,
                      Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                    if (isMixed) {
                      Navigator.of(context).pushNamed('/creation_flips_step_4', arguments: {
                      'imgToDisplay_1': widget.imgToDisplay_1,
                      'imgToDisplay_2': widget.imgToDisplay_2,
                      'imgToDisplay_3': widget.imgToDisplay_3,
                      'imgToDisplay_4': widget.imgToDisplay_4,
                      'imgToDisplayMixed_1': orderNotifier.value[0].image,
                      'imgToDisplayMixed_2': orderNotifier.value[1].image,
                      'imgToDisplayMixed_3': orderNotifier.value[2].image,
                      'imgToDisplayMixed_4': orderNotifier.value[3].image,
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

  void isImagesMixed(List<Img> orderedList) {
    bool m;
    (orderedList[0].image == widget.imgToDisplay_1 &&
            orderedList[1].image == widget.imgToDisplay_2 &&
            orderedList[2].image == widget.imgToDisplay_3 &&
            orderedList[3].image == widget.imgToDisplay_4)
        ? m = false
        : m = true;

    setState(() {
      isMixed = m;
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
