import 'package:fleva_icons/fleva_icons.dart';
import 'package:my_idena/enums/epoch_period.dart' as EpochPeriod;
import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/screens/create_flip_screen.dart';
import 'package:my_idena/myIdena_app/tabIcon_data.dart';
import 'package:my_idena/pages/screens/invite_screen.dart';
import 'package:my_idena/pages/screens/market_screen.dart';
import 'package:my_idena/pages/screens/oracle_votings_screen.dart';
import 'package:my_idena/pages/screens/parameters_screen.dart';
import 'package:my_idena/pages/screens/validation_basics_screen.dart';
import 'package:my_idena/pages/screens/validation_session_screen.dart';
import 'package:my_idena/pages/views/bottom_bar_view.dart';
import 'package:my_idena/pages/screens/home_screen.dart';
import 'package:my_idena/pages/screens/about_screen.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_identity.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget tabBody = Container(
    color: MyIdenaAppTheme.background,
  );

  void initTabIconsList(int index) {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    if (index != 0) {
      tabIconsList[index].isSelected = true;
    }
  }

  @override
  void initState() {
    initTabIconsList(1);

    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = HomeScreen(
      animationController: animationController,
      firstState: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: httpService.getDnaAll(),
        builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            dnaAll = snapshot.data;
            return Container(
              color: MyIdenaAppTheme.background,
              child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.transparent,
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              bottomLeft: Radius.circular(48.0),
                              bottomRight: Radius.circular(48.0),
                              topRight: Radius.circular(0.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: MyIdenaAppTheme.grey.withOpacity(0.7), offset: Offset(1.1, 1.1), blurRadius: 10.0),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage('https://robohash.org/${dnaAll.dnaIdentityResponse.result.address}'),
                                radius: 50.0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight + Alignment(0, .3),
                              child: Text(
                                dnaAll.dnaIdentityResponse.result.address.substring(0, 20) + "...",
                                style: TextStyle(
                                  fontFamily: MyIdenaAppTheme.fontName,
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight + Alignment(0, .8),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    new UtilIdentity().mapToFriendlyStatus(dnaAll.dnaIdentityResponse.result.state),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: MyIdenaAppTheme.fontName,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*ListTile(
                        leading: Icon(FlevaIcons.color_palette_outline),
                        title: Text(
                            AppLocalizations.of(context).translate("My flips")),
                        onTap: () {
                          setState(() {
                            initTabIconsList(0);
                            tabBody = CreateFlipScreen(
                                dnaAll: dnaAll,
                                animationController: animationController);
                          });
                          Navigator.of(context).pop();
                        },
                      ),*/
                      ListTile(
                        leading: Icon(Icons.show_chart),
                        title: Text(AppLocalizations.of(context).translate("Market")),
                        onTap: () {
                          setState(() {
                            initTabIconsList(0);
                            tabBody = MarketScreen(animationController: animationController);
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: Icon(FlevaIcons.checkmark_square_2_outline),
                        title: Text(AppLocalizations.of(context).translate("Validation Basics")),
                        onTap: () {
                          setState(() {
                            initTabIconsList(0);
                            tabBody = ValidationBasicsScreen(animationController: animationController);
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      /*ListTile(
                        leading: Icon(Icons.person_add),
                        title: Text(
                            AppLocalizations.of(context).translate("Invite")),
                        onTap: () {
                          setState(() {
                            initTabIconsList(0);
                            tabBody = InviteScreen(
                                animationController: animationController);
                          });
                          Navigator.of(context).pop();
                        },
                      ),*/
                      /*ListTile(
                        leading: Icon(FlevaIcons.eye_outline),
                        title: Text(
                            AppLocalizations.of(context).translate("Oracles")),
                        onTap: () {
                          setState(() {
                            initTabIconsList(0);
                            tabBody = OracleVotingsScreen(
                                animationController: animationController);
                          });
                          Navigator.of(context).pop();
                        },
                      ),*/
                      ListTile(
                        leading: Icon(FlevaIcons.bulb_outline),
                        title: Text(AppLocalizations.of(context).translate("Try a validation session")),
                        onTap: () {
                          setState(() {
                            dnaAll.dnaGetEpochResponse.result.nextValidation = DateTime.now();
                            tabBody = ValidationSessionScreen(
                                dnaAll: dnaAll,
                                simulationMode: true,
                                checkFlipsQualityProcess: false,
                                typeLaunchSession: EpochPeriod.ShortSession,
                                animationController: animationController);
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                body: FutureBuilder<bool>(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    } else {
                      return Stack(
                        children: <Widget>[
                          tabBody,
                          bottomBar(dnaAll),
                        ],
                      );
                    }
                  },
                ),
              ),
            );
          }
        });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar(DnaAll dnaAll) {
    bool displayAll = false;
    return FutureBuilder(
        future: httpService.getDnaAll(),
        builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
          if (snapshot.hasData) {
            dnaAll = snapshot.data;
            if (dnaAll != null && dnaAll.dnaIdentityResponse != null) {
              displayAll = true;
            }
          }

          if (displayAll) {
            return Column(
              children: <Widget>[
                const Expanded(
                  child: SizedBox(),
                ),
                BottomBarView(
                  tabIconsList: tabIconsList,
                  addClick: () {},
                  changeIndex: (int index) {
                    if (index == 0) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          _scaffoldKey.currentState.openDrawer();
                        });
                      });
                    } else if (index == 1) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          tabBody = HomeScreen(animationController: animationController, firstState: true);
                        });
                      });
                    } else if (index == 2) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          tabBody = ParametersScreen(animationController: animationController);
                        });
                      });
                    } else if (index == 3) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          tabBody = AboutScreen(animationController: animationController);
                        });
                      });
                    }
                  },
                ),
              ],
            );
          } else {
            return Column(
              children: <Widget>[
                const Expanded(
                  child: SizedBox(),
                ),
                BottomBarView(
                  tabIconsList: tabIconsList,
                  addClick: () {},
                  changeIndex: (int index) {
                    if (index == 0) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          tabBody = HomeScreen(animationController: animationController, firstState: true);
                        });
                      });
                    } else if (index == 1) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {});
                      });
                    } else if (index == 2) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          tabBody = ParametersScreen(animationController: animationController);
                        });
                      });
                    } else if (index == 3) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          tabBody = AboutScreen(animationController: animationController);
                        });
                      });
                    }
                  },
                ),
              ],
            );
          }
        });
  }
}
