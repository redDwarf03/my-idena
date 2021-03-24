// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/util/caseconverter.dart';

class CreationFlipsStep4Page extends StatefulWidget {
  final Image imgToDisplay_1;
  final Image imgToDisplay_2;
  final Image imgToDisplay_3;
  final Image imgToDisplay_4;
  final Image imgToDisplayMixed_1;
  final Image imgToDisplayMixed_2;
  final Image imgToDisplayMixed_3;
  final Image imgToDisplayMixed_4;
  CreationFlipsStep4Page(
      {Key key,
      this.imgToDisplay_1,
      this.imgToDisplay_2,
      this.imgToDisplay_3,
      this.imgToDisplay_4,
      this.imgToDisplayMixed_1,
      this.imgToDisplayMixed_2,
      this.imgToDisplayMixed_3,
      this.imgToDisplayMixed_4})
      : super(key: key);

  @override
  _CreationFlipsStep4PageState createState() => _CreationFlipsStep4PageState();
}

class _CreationFlipsStep4PageState extends State<CreationFlipsStep4Page> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                      AppLocalization.of(context).flipsCreatorStep4Header,
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
                      AppLocalization.of(context).flipsCreatorStep4Info1 +
                          "\n" +
                          AppLocalization.of(context).flipsCreatorStep4Info2,
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
                                  Opacity(
                                      opacity: 0.5,
                                      child: widget.imgToDisplayMixed_1),
                                  Opacity(
                                      opacity: 0.5,
                                      child: widget.imgToDisplayMixed_2),
                                  Opacity(
                                      opacity: 0.5,
                                      child: widget.imgToDisplayMixed_3),
                                  Opacity(
                                      opacity: 0.5,
                                      child: widget.imgToDisplayMixed_4),
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
              ),Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppButton.buildAppButton(
                      context,
                      AppButtonType.PRIMARY,
                      AppLocalization.of(context).flipsCreatorStep4Submit,
                      Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                    AppDialogs.showConfirmDialog(
                        context,
                        AppLocalization.of(context).flipsCreatorStep4Header,
                        AppLocalization.of(context).flipsCreatorStep4Info2 + "\n\n" + 
                        AppLocalization.of(context).flipsCreatorStep4Warning1,
                        CaseChange.toUpperCase(
                            AppLocalization.of(context)
                                .validationUnderstand,
                            context), () {
                      Navigator.of(context).pushNamed('/home');
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
