import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/pages/about.dart';
import 'package:my_idena/pages/flip_words.dart';
import 'package:my_idena/pages/home.dart';
import 'package:my_idena/pages/validation_session..dart';
import 'package:my_idena/utils/app_localizations.dart';

class BottomNavigationBarMyIdena extends StatefulWidget {
  final int indexInit;
  const BottomNavigationBarMyIdena({Key key, this.indexInit}) : super(key: key);

  @override
  _BottomNavigationBarMyIdenaState createState() =>
      _BottomNavigationBarMyIdenaState();
}

class _BottomNavigationBarMyIdenaState
    extends State<BottomNavigationBarMyIdena> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: Colors.grey[800],
      items: [
        TabItem(
          icon: Icon(Icons.home),
          title: AppLocalizations.of(context).translate("Home"),
        ),
        TabItem(
          icon: Icon(Icons.burst_mode),
          title: AppLocalizations.of(context).translate("Flips"),
        ),
        TabItem(
          icon: Icon(Icons.av_timer),
          title: AppLocalizations.of(context).translate("Validation"),
        ),
        TabItem(
          icon: Icon(Icons.settings_system_daydream),
          title: AppLocalizations.of(context).translate("Param"),
        ),
        TabItem(
          icon: Icon(Icons.contacts),
          title: AppLocalizations.of(context).translate("About"),
        ),
      ],
      initialActiveIndex: widget.indexInit,
      onTap: (index) {
        setState(() {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/home');
              break;
            case 1:
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new FlipWords(dnaAll: dnaAll),
                ),
              );
              break;
            case 2:
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new ValidationSession(dnaAll: dnaAll),
                ),);
              break;
            case 3:
              Navigator.of(context).pushReplacementNamed('/paramRPC');
              break;
            case 4:
              Navigator.of(context).pushReplacementNamed('/about');
              break;
          }
        });
      },
    );
  }
}
