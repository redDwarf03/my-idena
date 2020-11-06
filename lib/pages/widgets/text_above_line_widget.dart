import 'package:flutter/material.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';

Widget textAboveLineWidget(String _text, double _fontSize) {
  return Text(
    _text,
    textAlign: TextAlign.left,
    style: TextStyle(
      fontFamily: MyIdenaAppTheme.fontName,
      fontWeight: FontWeight.w500,
      fontSize: _fontSize,
      letterSpacing: -0.2,
      color: MyIdenaAppTheme.darkText,
    ),
  );
}
