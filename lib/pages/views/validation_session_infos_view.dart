import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/views/validation_session_countdown_view.dart';

import 'package:my_idena/utils/util_hexcolor.dart';

class ValidationSessionInfosView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ValidationSessionInfosView(
      {Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ValidationSessionInfosViewState createState() =>
      _ValidationSessionInfosViewState();
}

class _ValidationSessionInfosViewState
    extends State<ValidationSessionInfosView> {
  HttpService httpService = new HttpService();
  DnaAll dnaAll;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: httpService.getDnaAll(),
        builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
          if (snapshot.hasData) {
            dnaAll = snapshot.data;
            if (dnaAll == null || dnaAll.dnaIdentityResponse == null) {
              return Text("");
            } else {
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
                                    gradient: LinearGradient(
                                        colors: [
                                          HexColor("#FFEAC9"),
                                          HexColor("#FFC971")
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.circular(8.0),
                                        topRight: Radius.circular(68.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: MyIdenaAppTheme.grey
                                              .withOpacity(0.2),
                                          offset: Offset(1.1, 1.1),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 16,
                                            bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new ValidationSessionCountdownText(
                                                    nextValidation: dnaAll
                                                                .dnaGetEpochResponse !=
                                                            null
                                                        ? dnaAll
                                                            .dnaGetEpochResponse
                                                            .result
                                                            .nextValidation
                                                        : null,
                                                    animationController: widget
                                                        .animationController,
                                                    dnaAll: dnaAll,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))));
                  });
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
