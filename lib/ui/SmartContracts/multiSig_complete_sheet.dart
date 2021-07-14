// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:idena_lib_dart/util/util_number.dart';

// Project imports:
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/util/caseconverter.dart';

class MultiSigCompleteSheet extends StatefulWidget {
  final String amountRaw;
  final int minVotes;
  final int maxVotes;

  MultiSigCompleteSheet(  
      {this.amountRaw, this.minVotes, this.maxVotes})
      : super();

  _MultiSigCompleteSheetState createState() => _MultiSigCompleteSheetState();
}

class _MultiSigCompleteSheetState extends State<MultiSigCompleteSheet> {
  String amount;
  String destinationAltered;

  @override
  void initState() {
    super.initState();
    // Indicate that this is a special amount if some digits are not displayed
    if (NumberUtil.getRawAsUsableString(widget.amountRaw).replaceAll(",", "") ==
        NumberUtil.getRawAsUsableDecimal(widget.amountRaw).toString()) {
      amount = NumberUtil.getRawAsUsableString(widget.amountRaw);
    } else {
      amount = NumberUtil.truncateDecimal(
                  NumberUtil.getRawAsUsableDecimal(widget.amountRaw),
                  digits: 8)
              .toStringAsFixed(8) +
          "~";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            // Sheet handle
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 5,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.text10,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //
                  Container(
                    alignment: AlignmentDirectional(0, 0),
                    margin: EdgeInsets.only(bottom: 25),  
                    child: Icon(FontAwesome5.vote_yea,
                        size: 100,
                        color: StateContainer.of(context).curTheme.success),
                  ),
                  // Container for the Amount Text
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.105,
                        right: MediaQuery.of(context).size.width * 0.105),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          StateContainer.of(context).curTheme.backgroundDarkest,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    // Amount text
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: '',
                        children: [
                          TextSpan(
                            text: "$amount",
                            style: TextStyle(
                              color:
                                  StateContainer.of(context).curTheme.success,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          TextSpan(
                            text: " iDNA",
                            style: TextStyle(
                              color:
                                  StateContainer.of(context).curTheme.success,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: <Widget>[
                        //
                        Container(
                          margin: EdgeInsets.only(
                              top: 10.0,
                              bottom: 0,
                              left: MediaQuery.of(context).size.width * 0.105,
                              right: MediaQuery.of(context).size.width * 0.105),
                          child: Column(
                            children: <Widget>[
                              Text(
                                CaseChange.toUpperCase(
                                    AppLocalization.of(context).maxVotesTitle,
                                    context),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .text60,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 15.0,
                            ),
                            margin: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10,
                                left: MediaQuery.of(context).size.width * 0.105,
                                right:
                                    MediaQuery.of(context).size.width * 0.105),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundDarkest,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              widget.maxVotes.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    StateContainer.of(context).curTheme.primary,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.only(
                              top: 10.0,
                              bottom: 0,
                              left: MediaQuery.of(context).size.width * 0.105,
                              right: MediaQuery.of(context).size.width * 0.105),
                          child: Column(
                            children: <Widget>[
                              Text(
                                CaseChange.toUpperCase(
                                    AppLocalization.of(context).minVotesTitle,
                                    context),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .text60,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 15.0,
                            ),
                            margin: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10,
                                left: MediaQuery.of(context).size.width * 0.105,
                                right:
                                    MediaQuery.of(context).size.width * 0.105),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundDarkest,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              widget.minVotes.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    StateContainer.of(context).curTheme.primary,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // CLOSE Button
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.SUCCESS_OUTLINE,
                          CaseChange.toUpperCase(
                              AppLocalization.of(context).close, context),
                          Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
