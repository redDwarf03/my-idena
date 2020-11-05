import 'package:flutter/material.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class AboutView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const AboutView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: MyIdenaAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: MyIdenaAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, top: 4),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24, right: 24, top: 8, bottom: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        "Thanks for help"),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.2,
                                                  color:
                                                      MyIdenaAppTheme.darkText,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Container(
                                                  height: 4,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#000000')
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 70,
                                                        height: 4,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                HexColor(
                                                                        '#000000')
                                                                    .withOpacity(
                                                                        0.1),
                                                                HexColor(
                                                                    '#000000'),
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.0)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  "Mahmoud !!!, Cryptomatrix, Andrew, Rioda, Bus, JaymenChou, Gutalean, Tony, Dont Ramp, Qsvtr, Ludiveen, Set Animals, Rados, Alek, Shadowcrypto, Kazunori, Bingbinglee, gσѕϯ111, Neotame, Toni.dev, Orizhial, Kevin G., Marko, Martin Grabarz, CoinDrix, ...",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                    color: MyIdenaAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 0, bottom: 0),
                                    child: Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: MyIdenaAppTheme.background,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24, right: 24, top: 8, bottom: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate("Release"),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.2,
                                                  color:
                                                      MyIdenaAppTheme.darkText,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Container(
                                                  height: 4,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#000000')
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 70,
                                                        height: 4,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                HexColor(
                                                                        '#000000')
                                                                    .withOpacity(
                                                                        0.1),
                                                                HexColor(
                                                                    '#000000'),
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.0)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              FutureBuilder(
                                                  future: rootBundle.loadString(
                                                      "pubspec.yaml"),
                                                  builder: (context, snapshot) {
                                                    String version = "Unknown";
                                                    if (snapshot.hasData) {
                                                      var yaml = loadYaml(
                                                          snapshot.data);
                                                      version = yaml["version"];
                                                    }

                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6),
                                                      child: Text(
                                                        '${version.split("+")[0]}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              MyIdenaAppTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13,
                                                          color: MyIdenaAppTheme
                                                              .grey
                                                              .withOpacity(0.5),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 0, bottom: 0),
                                    child: Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: MyIdenaAppTheme.background,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24, right: 24, top: 8, bottom: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate("Created by"),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.2,
                                                  color:
                                                      MyIdenaAppTheme.darkText,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Container(
                                                  height: 4,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#000000')
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 70,
                                                        height: 4,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                HexColor(
                                                                        '#000000')
                                                                    .withOpacity(
                                                                        0.1),
                                                                HexColor(
                                                                    '#000000'),
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.0)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Image.asset(
                                                    'assets/images/reddwarf.jpg',
                                                    width: 70),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
