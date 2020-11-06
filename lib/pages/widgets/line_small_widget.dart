import 'package:flutter/material.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';

Widget smallLineWidget() {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
    child: Container(
      height: 2,
      decoration: BoxDecoration(
        color: MyIdenaAppTheme.background,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    ),
  );
}
