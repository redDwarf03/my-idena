import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/dictWords.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/util/util_flip.dart';

class CreationFlipsStep1Page extends StatefulWidget {
  final List flipKeyWordPairs;

  CreationFlipsStep1Page({Key key, this.flipKeyWordPairs}) : super(key: key);

  @override
  _CreationFlipsStep1PageState createState() => _CreationFlipsStep1PageState();
}

class _CreationFlipsStep1PageState extends State<CreationFlipsStep1Page> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _flipKeyWordPairsNumber = 0;
  UtilFlip utilFlip = new UtilFlip();

  @override
  void initState() {
    super.initState();

    loadProfileInfos();
  }

  Future<void> loadProfileInfos() async {
    int f = utilFlip.getFirstFlipKeyWordPairsNotUsed(widget.flipKeyWordPairs);

    setState(() {
      _flipKeyWordPairsNumber = f;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Word> listWords = StateContainer.of(context).dictWords.words;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                      AppLocalization.of(context).flipsCreatorStep1Header,
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
                      AppLocalization.of(context).flipsCreatorStep1Info,
                      style: AppStyles.textStyleParagraph(context),
                      maxLines: 4,
                      stepGranularity: 0.5,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: smallScreen(context) ? 30 : 40,
                        vertical: 20),
                    child: AutoSizeText(
                      listWords[widget.flipKeyWordPairs
                                  .elementAt(_flipKeyWordPairsNumber)
                                  .words[0]]
                              .name +
                          " - " +
                          listWords[widget.flipKeyWordPairs
                                  .elementAt(_flipKeyWordPairsNumber)
                                  .words[0]]
                              .desc,
                      style: AppStyles.textStyleParagraphPrimary(context),
                      maxLines: 4,
                      stepGranularity: 0.5,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: smallScreen(context) ? 30 : 40,
                        vertical: 20),
                    child: AutoSizeText(
                      listWords[widget.flipKeyWordPairs
                                  .elementAt(_flipKeyWordPairsNumber)
                                  .words[1]]
                              .name +
                          " - " +
                          listWords[widget.flipKeyWordPairs
                                  .elementAt(_flipKeyWordPairsNumber)
                                  .words[1]]
                              .desc,
                      maxLines: 4,
                      stepGranularity: 0.5,
                      style: AppStyles.textStyleParagraphPrimary(context),
                    ),
                  ),
                ],
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
                      AppButtonType.PRIMARY,
                      AppLocalization.of(context).flipsCreatorStep1ChangeWords +
                          " (#" +
                          (_flipKeyWordPairsNumber + 1).toString() +
                          ")",
                      Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                    setState(() {
                      _flipKeyWordPairsNumber =
                          utilFlip.findNextFlipKeyWordPairsNotUsed(
                              widget.flipKeyWordPairs,
                              _flipKeyWordPairsNumber + 1);
                    });
                  }),
                  AppButton.buildAppButton(
                      context,
                      AppButtonType.PRIMARY,
                      AppLocalization.of(context).flipsCreatorStep1NextStep,
                      Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/creation_flips_step_2', arguments: {
                      'word1': listWords[widget.flipKeyWordPairs
                          .elementAt(_flipKeyWordPairsNumber)
                          .words[0]],
                      'word2': listWords[widget.flipKeyWordPairs
                          .elementAt(_flipKeyWordPairsNumber)
                          .words[1]]
                    });
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
