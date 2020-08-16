import 'package:flutter/material.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: MyIdenaAppTheme.fontName,
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: MyIdenaAppTheme.fontName,
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.grey[800],
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.white12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

