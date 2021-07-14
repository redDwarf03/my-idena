// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:idena_lib_dart/model/address.dart';

// Project imports:
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/util/user_data_util.dart';

class AppPopupButton extends StatefulWidget {
  @override
  _AppPopupButtonState createState() => _AppPopupButtonState();
}

class _AppPopupButtonState extends State<AppPopupButton> {
  double scanButtonSize = 0;
  double popupMarginBottom = 0;
  bool isScrolledUpEnough = false;
  bool firstTime = true;
  bool isSendButtonColorPrimary = true;
  Color popupColor = Colors.transparent;

  bool animationOpen;

  @override
  void initState() {
    super.initState();
    animationOpen = false;
  }

  Future<void> scanAndHandlResult() async {
    dynamic scanResult = await Navigator.pushNamed(context, '/before_scan_screen');
    // Parse scan data and route appropriately
    if (scanResult == null) {
      UIUtil.showSnackbar(AppLocalization.of(context).qrInvalidAddress, context);
    } else if (!QRScanErrs.ERROR_LIST.contains(scanResult)) {
      // Is a URI
      Address address = Address(scanResult);
      if (address.address == null) {
        UIUtil.showSnackbar(AppLocalization.of(context).qrInvalidAddress, context);
      } else {

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Hero(
          tag: 'scanButton',
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            curve: Curves.easeOut,
            height: scanButtonSize,
            width: scanButtonSize,
            decoration: BoxDecoration(
              color: popupColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              AppIcons.scan,
              size: scanButtonSize < 60 ? scanButtonSize / 1.8 : 33,
              color: StateContainer.of(context).curTheme.background,
            ),
          ),
        ),
       
      ],
    );
  }
}
