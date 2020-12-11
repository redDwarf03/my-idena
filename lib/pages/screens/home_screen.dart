import 'package:flutter/material.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/views/mining_view.dart';
import 'package:my_idena/pages/views/portofolio_view.dart';
import 'package:my_idena/pages/views/profile_view.dart';
import 'package:my_idena/pages/views/title_view.dart';
import 'package:my_idena/pages/views/transactions_view.dart';
import 'package:my_idena/pages/views/validation_session_infos_view.dart';
import 'package:my_idena/pages/widgets/app_bar_widget.dart';
import 'package:my_idena/utils/util_public_node.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.animationController, this.firstState})
      : super(key: key);

  final AnimationController animationController;
  final bool firstState;

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
    if (idenaAddress.isNotEmpty) {
      const int count = 10;
      listViews.add(
        TitleView(
          titleTxt: "Portofolio",
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 0, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      );

      listViews.add(
        PortofolioView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 1, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      );

      if (getPublicNode() == false) {
        listViews.add(
          TitleView(
            titleTxt: "Online mining status",
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 2, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
        );

        listViews.add(
          MiningView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 3, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
            firstState: widget.firstState,
          ),
        );
      }
      listViews.add(
        TitleView(
          titleTxt: "Validation",
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 4, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      );

      listViews.add(
        ValidationSessionInfosView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 5, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      );

      listViews.add(
        TitleView(
          titleTxt: "Profile",
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 6, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      );

      listViews.add(
        ProfileView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 7, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      );

      if (getPublicNode() == false) {
        listViews.add(
          TitleView(
            titleTxt: "Recent transactions",
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 8, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
        );

        listViews.add(
          TransactionsView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 9, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
        );
      }
    } else {
      const int count = 1;
      listViews.add(
        TitleView(
          titleTxt: "You are not connected.\nPlease, go to the settings tab",
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 0, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyIdenaAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(
                scrollController, listViews, widget.animationController),
            getAppBarUI(topBarAnimation, widget.animationController,
                topBarOpacity, false),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
