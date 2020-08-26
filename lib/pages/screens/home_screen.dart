import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/beans/deepLinkParam.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/views/portofolio_view.dart';
import 'package:my_idena/pages/views/profile_view.dart';
import 'package:my_idena/pages/views/title_view.dart';
import 'package:my_idena/pages/views/transactions_view.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_deepLinks.dart';
import 'package:url_launcher/url_launcher.dart';

HttpService httpService = HttpService();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData(context);

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData(BuildContext context) {
    const int count = 6;
    listViews.add(
      TitleView(
        titleTxt: "Portofolio",
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      PortofolioView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: "Profile",
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      ProfileView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: "Recent transactions",
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      TransactionsView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: httpService.getDnaAll(),
        builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
          if (snapshot.hasData) {
            dnaAll = snapshot.data;
            if (dnaAll == null || dnaAll.dnaIdentityResponse == null) {
              return SizedBox();
            } else {
              return Container(
                color: MyIdenaAppTheme.background,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: <Widget>[
                      getMainListViewUI(),
                      getAppBarUI(),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom,
                      ),
                    ],
                  ),
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  void onAfterBuild(BuildContext context) {
    if (deepLinkParam != null) {
      showDialog(
          context: context,
          builder: (context) => SimpleDialog(
                contentPadding: EdgeInsets.zero,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)
                              .translate("Login confirmation"),
                          style: TextStyle(
                              fontFamily: MyIdenaAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.1,
                              color: MyIdenaAppTheme.darkText),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(AppLocalizations.of(context).translate(
                                "Please confirm that you want to use your public address for the website login")),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Website: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: MyIdenaAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: MyIdenaAppTheme.darkText,
                              ),
                            ),
                            Text(deepLinkParam.nonce_endpoint != null
                                ? UtilDeepLinks()
                                    .getHostname(deepLinkParam.nonce_endpoint)
                                : ""),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Address: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: MyIdenaAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: MyIdenaAppTheme.darkText,
                              ),
                            ),
                            Text(
                              dnaAll.dnaIdentityResponse.result.address != null
                                  ? dnaAll.dnaIdentityResponse.result.address
                                  : "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: MyIdenaAppTheme.fontName,
                                fontSize: 13,
                                letterSpacing: -0.2,
                                color: MyIdenaAppTheme.darkText,
                              ),
                            ),
                            Image.network(
                              'https://robohash.org/${dnaAll.dnaIdentityResponse.result.address}',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Token: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: MyIdenaAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: MyIdenaAppTheme.darkText,
                              ),
                            ),
                            Text(deepLinkParam.token != null
                                ? deepLinkParam.token
                                : ""),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FlatButton(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("Submit"),
                                    ),
                                    color: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    onPressed: () {
                                      deepLinkParam.address = dnaAll
                                          .dnaIdentityResponse.result.address;
                                      _launchDeepLink(deepLinkParam);
                                      deepLinkParam = null;
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    }),
                                FlatButton(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("Cancel"),
                                    ),
                                    color: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    onPressed: () {
                                      deepLinkParam = null;
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    })
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ));
    }
  }

  _launchDeepLink(deepLinkParam) async {
    deepLinkParam = await UtilDeepLinks().getNonce(deepLinkParam);
    deepLinkParam = await httpService.signin(deepLinkParam);
    deepLinkParam = await UtilDeepLinks().authenticate(deepLinkParam);
    if (await canLaunch(deepLinkParam.callback_url)) {
      await launch(deepLinkParam.callback_url);
    } else {
      logger.e('Could not  launch $deepLinkParam.callback_url');
    }
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyIdenaAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: MyIdenaAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate("my Idena"),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: MyIdenaAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
