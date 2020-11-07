import 'package:flutter/material.dart';
import 'package:my_idena/utils/app_localizations.dart';

Widget demoModeClipWidget(BuildContext _context, bool _simulationMode) {
  return _simulationMode
      ? Chip(
          backgroundColor: Colors.orange[600],
          padding: EdgeInsets.all(0),
          label: Text(AppLocalizations.of(_context).translate("Demo mode"),
              style: TextStyle(fontSize: 12, color: Colors.white)),
        )
      : SizedBox(
          height: 1,
        );
}
