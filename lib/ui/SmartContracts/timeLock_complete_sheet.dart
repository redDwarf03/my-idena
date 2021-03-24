// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/numberutil.dart';

class TimeLockCompleteSheet extends StatefulWidget {
  final String amountRaw;
  final String localAmount;
  final DateTime dateUnlock;

  TimeLockCompleteSheet(
      {this.amountRaw,
      this.localAmount,
      this.dateUnlock})
      : super();

  _TimeLockCompleteSheetState createState() => _TimeLockCompleteSheetState();
}

class _TimeLockCompleteSheetState extends State<TimeLockCompleteSheet> {
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
            //A main container that holds the amount, address and "LOCK" texts
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //
                  Container(
                    alignment: AlignmentDirectional(0, 0),
                    margin: EdgeInsets.only(bottom: 25),
                    child: Icon(AppIcons.lock,
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
                          TextSpan(
                            text: widget.localAmount != null
                                ? " (${widget.localAmount})"
                                : "",
                            style: TextStyle(
                              color:
                                  StateContainer.of(context).curTheme.success,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
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
                        Text(
                          CaseChange.toUpperCase(
                              AppLocalization.of(context).unlockTimeTitle, context),
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w700,
                            color: StateContainer.of(context).curTheme.success,
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
                          right: MediaQuery.of(context).size.width * 0.105),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: StateContainer.of(context)
                            .curTheme
                            .backgroundDarkest,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        DateFormat.yMEd(
                                Localizations.localeOf(context).languageCode)
                            .add_Hm()
                            .format(widget.dateUnlock.toLocal())
                            .toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: StateContainer.of(context).curTheme.primary,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                        ),
                      )),
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
