import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/dna_getEpoch_response.dart';
import 'package:my_idena/backoffice/bean/dna_identity_response.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/widgets/line_small_widget.dart';
import 'package:my_idena/pages/widgets/line_widget.dart';
import 'package:my_idena/pages/widgets/text_above_line_widget.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_identity.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ProfileView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  HttpService httpService = new HttpService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: httpService.getDnaIdentity(
            Uri.parse(idenaSharedPreferences.apiUrl),
            idenaSharedPreferences.keyApp),
        builder: (BuildContext context,
            AsyncSnapshot<DnaIdentityResponse> _dnaIdentityResponse) {
          if (_dnaIdentityResponse.hasData) {
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
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 16, bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          textAboveLineWidget(
                                              AppLocalizations.of(context)
                                                  .translate("Address"),
                                              14),
                                          lineWidget(90),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: SelectableText(
                                              idenaAddress,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    MyIdenaAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                color: MyIdenaAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: new GestureDetector(
                                              onTap: () async {
                                                String url =
                                                    'https://scan.idena.io/address/' +
                                                        idenaAddress;
                                                await launch(url);
                                              },
                                              child: new Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        "Open in blockchain explorer >"),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: MyIdenaAppTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              smallLineWidget(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8, bottom: 16),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          textAboveLineWidget(
                                              AppLocalizations.of(context)
                                                  .translate("Age"),
                                              14),
                                          lineWidget(90),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              _dnaIdentityResponse
                                                  .data.result.age
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    MyIdenaAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: MyIdenaAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              textAboveLineWidget(
                                                  AppLocalizations.of(context)
                                                      .translate("Epoch"),
                                                  14),
                                              lineWidget(90),
                                              FutureBuilder(
                                                  future: httpService
                                                      .getDnaGetEpoch(
                                                          Uri.parse(
                                                              idenaSharedPreferences
                                                                  .apiUrl),
                                                          idenaSharedPreferences
                                                              .keyApp),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<
                                                              DnaGetEpochResponse>
                                                          _dnaGetEpochResponse) {
                                                    if (_dnaGetEpochResponse
                                                        .hasData) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6),
                                                        child: Text(
                                                          (_dnaGetEpochResponse
                                                                          .data
                                                                          .result
                                                                          .epoch -
                                                                      _dnaIdentityResponse
                                                                          .data
                                                                          .result
                                                                          .age)
                                                                  .toString() +
                                                              " - " +
                                                              _dnaGetEpochResponse
                                                                  .data
                                                                  .result
                                                                  .epoch
                                                                  .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                MyIdenaAppTheme
                                                                    .fontName,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12,
                                                            color:
                                                                MyIdenaAppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return Center(child: SizedBox(width: 10, height: 10,  
                                                          child:
                                                              CircularProgressIndicator(strokeWidth: 1)));
                                                    }
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              textAboveLineWidget(
                                                  AppLocalizations.of(context)
                                                      .translate("State"),
                                                  14),
                                              lineWidget(90),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  new UtilIdentity()
                                                      .mapToFriendlyStatus(
                                                          _dnaIdentityResponse
                                                              .data
                                                              .result
                                                              .state),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: MyIdenaAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8, bottom: 16),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          textAboveLineWidget(
                                              AppLocalizations.of(context)
                                                  .translate("Score"),
                                              14),
                                          lineWidget(90),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: Text(
                                              _dnaIdentityResponse.data.result
                                                      .totalShortFlipPoints
                                                      .toString() +
                                                  " / " +
                                                  _dnaIdentityResponse
                                                      .data
                                                      .result
                                                      .totalQualifiedFlips
                                                      .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    MyIdenaAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: MyIdenaAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              textAboveLineWidget(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          "Required flips"),
                                                  14),
                                              lineWidget(90),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  _dnaIdentityResponse
                                                      .data.result.requiredFlips
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: MyIdenaAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              textAboveLineWidget(
                                                  AppLocalizations.of(context)
                                                      .translate("Made flips"),
                                                  14),
                                              lineWidget(90),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  _dnaIdentityResponse
                                                      .data.result.madeFlips
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: MyIdenaAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
