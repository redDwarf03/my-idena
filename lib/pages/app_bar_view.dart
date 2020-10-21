import 'dart:async';

import 'package:flutter/material.dart';

import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/views/sync_info_view.dart';
import 'package:my_idena/utils/app_localizations.dart';

Widget getAppBarUI(
    Animation<double> topBarAnimation,
    AnimationController animationController,
    double topBarOpacity) {
  return Column(
    children: <Widget>[
      AnimatedBuilder(
        animation: animationController,
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
                          right: 0,
                          top: 16 - 8.0 * topBarOpacity,
                          bottom: 12 - 8.0 * topBarOpacity),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(child: 
                                SyncInfoView()
                                ,)),
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

Future<bool> getData() async {
  await Future<dynamic>.delayed(const Duration(milliseconds: 50));
  return true;
}

Widget getMainListViewUI(ScrollController scrollController,
    List<Widget> listViews, AnimationController animationController) {
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
            animationController.forward();
            return listViews[index];
          },
        );
      }
    },
  );
}
