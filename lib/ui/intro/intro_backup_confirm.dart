// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/security.dart';
import 'package:my_idena/util/sharedprefsutil.dart';

class IntroBackupConfirm extends StatefulWidget {
  @override
  _IntroBackupConfirmState createState() => _IntroBackupConfirmState();
}

class _IntroBackupConfirmState extends State<IntroBackupConfirm> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
              minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                  top: MediaQuery.of(context).size.height * 0.075),
              child: Column(
                children: <Widget>[
                  //A widget that holds the header, the paragraph and Back Button
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                  highlightColor: StateContainer.of(context)
                                      .curTheme
                                      .text15,
                                  splashColor: StateContainer.of(context)
                                      .curTheme
                                      .text15,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(AppIcons.back,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .text,
                                      size: 24)),
                            ),
                          ],
                        ),
                        // The header
                        Container(
                          margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 30 : 40,
                            end: smallScreen(context) ? 30 : 40,
                            top: 10,
                          ),
                          alignment: AlignmentDirectional(-1, 0),
                          child: AutoSizeText(
                            AppLocalization.of(context).ackBackedUp,
                            maxLines: 4,
                            stepGranularity: 0.5,
                            style: AppStyles.textStyleHeaderColored(context),
                          ),
                        ),
                        // The paragraph
                        Container(
                          margin: EdgeInsetsDirectional.only(
                                  start: smallScreen(context) ? 30 : 40,
                                  end: smallScreen(context) ? 30 : 40,
                                  top: 15.0),
                          child: AutoSizeText(
                            AppLocalization.of(context).secretWarning,
                            style: AppStyles.textStyleParagraph(context),
                            maxLines: 5,
                            stepGranularity: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //A column with YES and NO buttons
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // YES Button
                          AppButton.buildAppButton(
                              context,
                              AppButtonType.PRIMARY,
                              AppLocalization.of(context).yes.toUpperCase(),
                              Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                            String pin = await Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new PinScreen(PinOverlayType.NEW_PIN,
                                  );
                            }));
                            if (pin != null && pin.length > 5) {
                              _pinEnteredCallback(pin);
                            }
                          }),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          // NO BUTTON
                          AppButton.buildAppButton(
                              context,
                              AppButtonType.PRIMARY_OUTLINE,
                              AppLocalization.of(context).no.toUpperCase(),
                              Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                            Navigator.of(context).pop();
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }

  void _pinEnteredCallback(String pin) async {
    await sl.get<Vault>().writePin(pin);
    PriceConversion conversion = await sl.get<SharedPrefsUtil>().getPriceConversion();

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false, arguments: conversion);
  }
}
