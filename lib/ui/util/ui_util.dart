import 'dart:io';
import 'dart:async';
import 'package:event_taxi/event_taxi.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/bus/events.dart';
import 'package:my_idena/ui/util/exceptions.dart';

enum ThreeLineAddressTextType { PRIMARY60, PRIMARY, SUCCESS, SUCCESS_FULL }
enum OneLineAddressTextType { PRIMARY60, PRIMARY, SUCCESS }

class UIUtil {
  static Widget threeLineAddressText(BuildContext context, String address,
      {ThreeLineAddressTextType type = ThreeLineAddressTextType.PRIMARY,
      String? contactName}) {
    String stringPartOne = "";
    String stringPartTwo = "";
    String stringPartThree = "";
    String stringPartFour = "";
    String stringPartFive = "";
    if (address.length >= 12) {
      stringPartOne = address.substring(0, 12);
    } else {
      stringPartOne = address.substring(0, address.length);
    }
    if (address.length >= 22) {
      stringPartTwo = address.substring(12, 22);
    } else {
      if (address.length > 12 && address.length < 22) {
        stringPartTwo = address.substring(12, address.length);
      }
    }
    if (address.length >= 44) {
      stringPartThree = address.substring(22, 44);
    } else {
      if (address.length > 22 && address.length < 44) {
        stringPartThree = address.substring(22, address.length);
      }
    }
    if (address.length >= 59) {
      stringPartFour = address.substring(44, 59);
    } else {
      if (address.length > 44 && address.length < 59) {
        stringPartFour = address.substring(44, address.length);
      } else {}
    }
    if (address.length >= 60) {
      stringPartFive = address.substring(59);
    }

    switch (type) {
      case ThreeLineAddressTextType.PRIMARY60:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleAddressText60(context),
                  ),
                  TextSpan(
                    text: stringPartTwo,
                    style: AppStyles.textStyleAddressText60(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartThree,
                    style: AppStyles.textStyleAddressText60(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartFour,
                    style: AppStyles.textStyleAddressText60(context),
                  ),
                  TextSpan(
                      text: stringPartFive,
                      style: AppStyles.textStyleAddressText60(context)),
                ],
              ),
            )
          ],
        );
      case ThreeLineAddressTextType.PRIMARY:
        Widget contactWidget = contactName != null
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: contactName,
                    style: AppStyles.textStyleAddressText90(context)))
            : SizedBox();
        return Column(
          children: <Widget>[
            contactWidget,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                  TextSpan(
                    text: stringPartTwo,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartThree,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartFour,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                ],
              ),
            )
          ],
        );
      case ThreeLineAddressTextType.SUCCESS:
        Widget contactWidget = contactName != null
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: contactName,
                    style: AppStyles.textStyleAddressSuccess(context)))
            : SizedBox();
        return Column(
          children: <Widget>[
            contactWidget,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                  TextSpan(
                    text: stringPartTwo,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartThree,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartFour,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                ],
              ),
            )
          ],
        );
      case ThreeLineAddressTextType.SUCCESS_FULL:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                  TextSpan(
                    text: stringPartTwo,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartThree,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartFour,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                ],
              ),
            )
          ],
        );
      default:
        throw new UIException("Invalid threeLineAddressText Type $type");
    }
  }

  static Widget oneLineAddressText(BuildContext context, String address,
      {OneLineAddressTextType type = OneLineAddressTextType.PRIMARY}) {
    String stringPartOne = address.substring(0, 12);
    String stringPartFive = address.substring(59);
    switch (type) {
      case OneLineAddressTextType.PRIMARY60:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleAddressText60(context),
                  ),
                  TextSpan(
                    text: "...",
                    style: AppStyles.textStyleAddressText60(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleAddressText60(context),
                  ),
                ],
              ),
            ),
          ],
        );
      case OneLineAddressTextType.PRIMARY:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                  TextSpan(
                    text: "...",
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                ],
              ),
            ),
          ],
        );
      case OneLineAddressTextType.SUCCESS:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleAddressSuccess(context),
                  ),
                  TextSpan(
                    text: "...",
                    style: AppStyles.textStyleAddressText90(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleAddressSuccess(context),
                  ),
                ],
              ),
            ),
          ],
        );
      default:
        throw new UIException("Invalid oneLineAddressText Type $type");
    }
  }

  static Widget threeLineSeedText(BuildContext context, String address,
      {TextStyle? textStyle}) {
    textStyle = textStyle ?? AppStyles.textStyleSeed(context);
    String stringPartOne = address.substring(0, 22);
    String stringPartTwo = address.substring(22, 44);
    String stringPartThree = address.substring(44, 64);
    return Column(
      children: <Widget>[
        Text(
          stringPartOne,
          style: textStyle,
        ),
        Text(
          stringPartTwo,
          style: textStyle,
        ),
        Text(
          stringPartThree,
          style: textStyle,
        ),
      ],
    );
  }

  static Widget showAccountWebview(BuildContext context, String account) {
    cancelLockEvent();
    return WebviewScaffold(
      url: AppLocalization.of(context).getAccountExplorerUrl(account),
      appBar: new AppBar(
        backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
        brightness: StateContainer.of(context).curTheme.brightness,
        iconTheme:
            IconThemeData(color: StateContainer.of(context).curTheme.text),
      ),
    );
  }

  static Widget showFAQ(BuildContext context) {
    cancelLockEvent();
    return WebviewScaffold(
      url: AppLocalization.of(context).getFAQ(),
      appBar: new AppBar(
        backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
        brightness: StateContainer.of(context).curTheme.brightness,
        iconTheme:
            IconThemeData(color: StateContainer.of(context).curTheme.text),
      ),
    );
  }

  static Widget showWebview(BuildContext context, String url) {
    cancelLockEvent();
    return WebviewScaffold(
      resizeToAvoidBottomInset: Platform.isAndroid,
      url: url,
      appBar: new AppBar(
        backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
        brightness: StateContainer.of(context).curTheme.brightness,
        iconTheme:
            IconThemeData(color: StateContainer.of(context).curTheme.text),
      ),
    );
  }

  static double drawerWidth(BuildContext context) {
    if (MediaQuery.of(context).size.width < 375)
      return MediaQuery.of(context).size.width * 0.94;
    else
      return MediaQuery.of(context).size.width * 0.85;
  }

  static void showSnackbar(String content, BuildContext context) {
    showToastWidget(
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.05,
              horizontal: 14),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
            color: StateContainer.of(context).curTheme.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: StateContainer.of(context).curTheme.overlay80,
                  offset: Offset(0, 15),
                  blurRadius: 30,
                  spreadRadius: -5),
            ],
          ),
          child: Text(
            content,
            style: AppStyles.textStyleSnackbar(context),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      dismissOtherToast: true,
      duration: Duration(milliseconds: 3000),
    );
  }

  static StreamSubscription<dynamic>? _lockDisableSub;

  static Future<void> cancelLockEvent() async {
    // Cancel auto-lock event, usually if we are launching another intent
    if (_lockDisableSub != null) {
      _lockDisableSub!.cancel();
    }
    EventTaxiImpl.singleton().fire(DisableLockTimeoutEvent(disable: true));
    Future<dynamic> delayed = Future.delayed(Duration(seconds: 10));
    delayed.then((_) {
      return true;
    });
    _lockDisableSub = delayed.asStream().listen((_) {
      EventTaxiImpl.singleton().fire(DisableLockTimeoutEvent(disable: false));
    });
  }

  static bool smallScreen(BuildContext context) {
    if (MediaQuery.of(context).size.height < 667)
      return true;
    else
      return false;
  }

  static ImageProvider getRobohashURL(String address) {
    if (address == null) {
      return Image.asset('assets/images/icon-help.png').image;
    } else {
      return NetworkImage("https://robohash.org/${address.toLowerCase()}");
    }
  }
}
