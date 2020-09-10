import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/screens/create_flip_screen.dart';
import 'package:my_idena/myIdena_app/tabIcon_data.dart';
import 'package:my_idena/pages/screens/parameters_screen.dart';
import 'package:my_idena/pages/views/bottom_bar_view.dart';
import 'package:my_idena/pages/screens/home_screen.dart';
import 'package:my_idena/pages/screens/about_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: MyIdenaAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
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
    return Container(
      color: MyIdenaAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
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
                          tabBody = HomeScreen(
                              animationController: animationController,
                              firstState: true);
                        });
                      });
                    } else if (index == 1) {
                      /*animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          tabBody = CreateFlipScreen(
                              dnaAll: dnaAll,
                              animationController: animationController);
                        });
                      });*/
                    } else if (index == 2) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          tabBody = ParametersScreen(
                              animationController: animationController);
                        });
                      });
                    } else if (index == 3) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          tabBody = AboutScreen(
                              animationController: animationController);
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
                          tabBody = HomeScreen(
                              animationController: animationController,
                              firstState: true);
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
                          tabBody = ParametersScreen(
                              animationController: animationController);
                        });
                      });
                    } else if (index == 3) {
                      animationController.reverse().then<dynamic>((data) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          tabBody = AboutScreen(
                              animationController: animationController);
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
