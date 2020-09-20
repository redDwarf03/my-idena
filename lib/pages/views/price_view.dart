import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/coins_response.dart';
import 'package:my_idena/backoffice/factory/coins_service.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';

class PriceView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const PriceView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _PriceViewState createState() => _PriceViewState();
}

class _PriceViewState extends State<PriceView> {
  CoinsService coinsService = new CoinsService();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CoinsResponse>(
        future: coinsService.getCoinsResponse(),
        builder: (BuildContext context, AsyncSnapshot<CoinsResponse> snapshot) {
          if (snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator());
          } else {
            CoinsResponse coinsResponse = snapshot.data;

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
                              topRight: Radius.circular(8.0)),
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
                                  top: 0, left: 0, right: 0),
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
                                                left: 4,
                                                right: 4,
                                                top: 8,
                                                bottom: 5),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Table(
                                                        border: TableBorder.all(
                                                            width: 0,
                                                            color:
                                                                Colors.white),
                                                        children: [
                                                          TableRow(
                                                            children: [
                                                              Text(
                                                                "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                              ),
                                                              Text(
                                                                "   " +
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .translate(
                                                                            "Idena Price"),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                "   " +
                                                                    coinsResponse
                                                                        .marketData
                                                                        .currentPrice[
                                                                            'eur']
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          TableRow(
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "Market Cap"),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                coinsResponse
                                                                    .marketData
                                                                    .marketCap[
                                                                        'eur']
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                              ),
                                                              Text(
                                                                "   " +
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .translate(
                                                                            "24h Trad. Vol"),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                coinsResponse
                                                                    .marketData
                                                                    .totalVolume[
                                                                        'eur']
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          TableRow(
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "24h Low"),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                coinsResponse
                                                                    .marketData
                                                                    .low24H[
                                                                        'eur']
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                              ),
                                                              Text(
                                                                "   " +
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .translate(
                                                                            "24h High"),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                coinsResponse
                                                                    .marketData
                                                                    .high24H[
                                                                        'eur']
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          TableRow(
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "ATH"),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                coinsResponse
                                                                    .marketData
                                                                    .ath['eur']
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                              ),
                                                              Text(
                                                                "   " +
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .translate(
                                                                            "ATL"),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                coinsResponse
                                                                    .marketData
                                                                    .atl['eur']
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      MyIdenaAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: MyIdenaAppTheme
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
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
        });
  }
}
