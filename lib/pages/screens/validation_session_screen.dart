import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/views/title_view.dart';
import 'package:my_idena/pages/views/validation_session_view.dart';
import 'package:my_idena/pages/app_bar_view.dart';

class ValidationSessionScreen extends StatefulWidget {
  const ValidationSessionScreen({Key key, this.animationController, this.typeLaunchSession, this.checkFlipsQualityProcess, this.dnaAll})
      : super(key: key);

  final AnimationController animationController;
  final String typeLaunchSession;
  final bool checkFlipsQualityProcess;
  final DnaAll dnaAll;

  @override
  _ValidationSessionScreenState createState() => _ValidationSessionScreenState();
}

class _ValidationSessionScreenState extends State<ValidationSessionScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: widget.animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData(context);

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 && scrollController.offset >= 0) {
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
    const int count = 8;
    listViews.add(
      TitleView(
        titleTxt: widget.checkFlipsQualityProcess ? "Check flips quality" : "Select meaningful story: left or right",
        animation: Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: widget.animationController, curve: Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      ValidationSessionView(
        typeLaunchSession: widget.typeLaunchSession,
        simulationMode: false,
        dnaAll: widget.dnaAll,
        checkFlipsQualityProcess: widget.checkFlipsQualityProcess,
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: widget.animationController, curve: Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyIdenaAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(scrollController, listViews, widget.animationController),
            getAppBarUI(topBarAnimation, widget.animationController, topBarOpacity),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
