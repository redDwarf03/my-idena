import 'package:flutter/material.dart';
import 'package:my_idena/localization.dart';

Widget demoModeClipWidget(BuildContext context, bool simulationMode) {
  return Center(child: simulationMode
      ? Chip(
          backgroundColor: Colors.orange[600],
          padding: EdgeInsets.all(0),
          label: Text(AppLocalization.of(context).demoMode,
              style: TextStyle(fontSize: 12, color: Colors.white)),
        )
      : SizedBox(
          height: 1,
        ));
}
