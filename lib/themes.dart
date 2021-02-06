import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseTheme {
  Color primary;
  Color primary60;
  Color primary45;
  Color primary30;
  Color primary20;
  Color primary15;
  Color primary10;

  Color icon;
  Color icon45;
  Color icon60;

  Color success;
  Color success60;
  Color success30;
  Color success15;
  Color successDark;
  Color successDark30;

  Color background;
  Color background40;
  Color background00;

  Color backgroundDark;
  Color backgroundDark00;

  Color backgroundDarkest;

  Color text;
  Color text60;
  Color text45;
  Color text30;
  Color text20;
  Color text15;
  Color text10;
  Color text05;
  Color text03;

  Color overlay20;
  Color overlay30;
  Color overlay50;
  Color overlay70;
  Color overlay80;
  Color overlay85;
  Color overlay90;
  Color overlay;
  
  Color animationOverlayMedium;
  Color animationOverlayStrong;

  Brightness brightness;
  SystemUiOverlayStyle statusBar;

  BoxShadow boxShadow;
  BoxShadow boxShadowButton;

  // QR scanner theme
  OverlayTheme qrScanTheme;
  // App icon (iOS only)
  AppIconEnum appIcon;

  String fontFamily;
}

class IdenaTheme extends BaseTheme {
  static const teal = Color(0xFF5890FF);

  static const orange = Color(0xFF5890FF);

  static const orangeDark = Color(0xFF5890FF);

  static const purpleDark = Color(0xFFF5F6F7);

  static const purpleLight = Color(0xFFFFFFFF);

  static const purpleDarkest = Color(0xFFF5F6F7);

  static const white = Color(0xFFFFFFFF);

  static const black = Color(0xFF474C53);

  static const blue = Color(0xFF2196F3);

  Color primary = teal;
  Color primary60 = teal.withOpacity(0.6);
  Color primary45 = teal.withOpacity(0.45);
  Color primary30 = teal.withOpacity(0.3);
  Color primary20 = teal.withOpacity(0.2);
  Color primary15 = teal.withOpacity(0.15);
  Color primary10 = teal.withOpacity(0.1);

  Color icon = blue;
  Color icon45 = blue.withOpacity(0.45);
  Color icon60 = blue.withOpacity(0.60);

  Color success = orange;
  Color success60 = orange.withOpacity(0.6);
  Color success30 = orange.withOpacity(0.3);
  Color success15 = orange.withOpacity(0.15);

  Color successDark = orangeDark;
  Color successDark30 = orangeDark.withOpacity(0.3);

  Color background = purpleDark;
  Color background40 = purpleDark.withOpacity(0.4);
  Color background00 = purpleDark.withOpacity(0.0);

  Color backgroundDark = purpleLight;
  Color backgroundDark00 = purpleLight.withOpacity(0.0);

  Color backgroundDarkest = purpleDarkest;

  Color text = black.withOpacity(0.9);
  Color text60 = black.withOpacity(0.6);
  Color text45 = black.withOpacity(0.45);
  Color text30 = black.withOpacity(0.3);
  Color text20 = black.withOpacity(0.2);
  Color text15 = black.withOpacity(0.15);
  Color text10 = black.withOpacity(0.1);
  Color text05 = black.withOpacity(0.05);
  Color text03 = black.withOpacity(0.03);

  Color overlay = white;
  Color overlay90 = white.withOpacity(0.9);
  Color overlay85 = white.withOpacity(0.85);
  Color overlay80 = white.withOpacity(0.8);
  Color overlay70 = white.withOpacity(0.7);
  Color overlay50 = white.withOpacity(0.5);
  Color overlay30 = white.withOpacity(0.3);
  Color overlay20 = white.withOpacity(0.2);

  Color animationOverlayMedium = white.withOpacity(0.7);
  Color animationOverlayStrong = white.withOpacity(0.85);

  Brightness brightness = Brightness.light;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: teal);

  BoxShadow boxShadow = BoxShadow(color: Colors.transparent);
  BoxShadow boxShadowButton = BoxShadow(color: Colors.transparent);

  OverlayTheme qrScanTheme = OverlayTheme.IDENA;
  AppIconEnum appIcon = AppIconEnum.IDENA;

  String fontFamily = 'Roboto';
}

class IdenaDarkTheme extends BaseTheme {
  static const teal = Color(0xFF5c92bf);

  static const orange = Color(0xFF145e9c);

  static const orangeDark = Color(0xFF1c1c1c);

  static const purpleDark = Color(0xFF1c1c1c);

  static const purpleLight = Color(0xFF000000);

  static const purpleDarkest = Color(0xFF242424);

  static const white = Color(0xFF000000);

  static const black = Color(0xFF7d8591);

  static const blue = Color(0xFF5c92bf);

  Color primary = teal;
  Color primary60 = teal.withOpacity(0.6);
  Color primary45 = teal.withOpacity(0.45);
  Color primary30 = teal.withOpacity(0.3);
  Color primary20 = teal.withOpacity(0.2);
  Color primary15 = teal.withOpacity(0.15);
  Color primary10 = teal.withOpacity(0.1);

  Color icon = blue;
  Color icon45 = blue.withOpacity(0.45);
  Color icon60 = blue.withOpacity(0.60);

  Color success = orange;
  Color success60 = orange.withOpacity(0.6);
  Color success30 = orange.withOpacity(0.3);
  Color success15 = orange.withOpacity(0.15);

  Color successDark = orangeDark;
  Color successDark30 = orangeDark.withOpacity(0.3);

  Color background = purpleDark;
  Color background40 = purpleDark.withOpacity(0.4);
  Color background00 = purpleDark.withOpacity(0.0);

  Color backgroundDark = purpleLight;
  Color backgroundDark00 = purpleLight.withOpacity(0.0);

  Color backgroundDarkest = purpleDarkest;

  Color text = black.withOpacity(0.9);
  Color text60 = black.withOpacity(0.6);
  Color text45 = black.withOpacity(0.45);
  Color text30 = black.withOpacity(0.3);
  Color text20 = black.withOpacity(0.2);
  Color text15 = black.withOpacity(0.15);
  Color text10 = black.withOpacity(0.1);
  Color text05 = black.withOpacity(0.05);
  Color text03 = black.withOpacity(0.03);

  Color overlay = white;
  Color overlay90 = white.withOpacity(0.9);
  Color overlay85 = white.withOpacity(0.85);
  Color overlay80 = white.withOpacity(0.8);
  Color overlay70 = white.withOpacity(0.7);
  Color overlay50 = white.withOpacity(0.5);
  Color overlay30 = white.withOpacity(0.3);
  Color overlay20 = white.withOpacity(0.2);

  Color animationOverlayMedium = white.withOpacity(0.7);
  Color animationOverlayStrong = white.withOpacity(0.85);

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: teal);

  BoxShadow boxShadow = BoxShadow(color: Colors.transparent);
  BoxShadow boxShadowButton = BoxShadow(color: Colors.transparent);

  OverlayTheme qrScanTheme = OverlayTheme.IDENA;
  AppIconEnum appIcon = AppIconEnum.IDENA;

  String fontFamily = 'Roboto';
}

enum AppIconEnum { IDENA }
class AppIcon {
  static const _channel = const MethodChannel('fappchannel');

  static Future<void> setAppIcon() async {
    if (!Platform.isIOS) {
      return null;
    }
    final Map<String, dynamic> params = <String, dynamic>{
     'icon': "idena",
    };
    return await _channel.invokeMethod('changeIcon', params);
  }
}