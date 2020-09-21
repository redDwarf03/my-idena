import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/coins_price_response.dart';
import 'package:my_idena/backoffice/factory/coins_service.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as charts_common;
import 'package:my_idena/utils/app_localizations.dart';

class ChartsPriceView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ChartsPriceView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ChartsPriceViewState createState() => _ChartsPriceViewState();
}

class _ChartsPriceViewState extends State<ChartsPriceView> {
  CoinsService coinsService = new CoinsService();

  List<charts.Series<Price, DateTime>> _seriesLineData;

  @override
  initState() {
    super.initState();
    _seriesLineData = List<charts.Series<Price, DateTime>>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CoinsPriceResponse>(
        future: coinsService.getCoinsChart("eur", 7),
        builder:
            (BuildContext context, AsyncSnapshot<CoinsPriceResponse> snapshot) {
          if (snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator());
          } else {
            CoinsPriceResponse coinsPriceResponse = snapshot.data;
            List<Price> linePricesData = new List();
            double min = 10;
            double max = 0;
            for (int i = 0; i < coinsPriceResponse.prices.length; i++) {
              if (min > coinsPriceResponse.prices[i][1].toDouble()) {
                min = coinsPriceResponse.prices[i][1].toDouble();
              }
              if (max < coinsPriceResponse.prices[i][1].toDouble()) {
                max = coinsPriceResponse.prices[i][1].toDouble();
              }
              Price price = new Price(
                  DateTime.fromMillisecondsSinceEpoch(
                      coinsPriceResponse.prices[i][0].toInt()),
                  coinsPriceResponse.prices[i][1].toDouble());
              linePricesData.add(price);
            }

            _seriesLineData.add(
              charts.Series<Price, DateTime>(
                colorFn: (__, _) =>
                    charts.ColorUtil.fromDartColor(Color(0xff990099)),
                id: 'Price',
                data: linePricesData,
                domainFn: (Price price, _) => price.dateVal,
                measureFn: (Price price, _) => price.priceVal,
              ),
            );

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
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Container(
                                                          height: 200,
                                                          child: Center(
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child: charts.TimeSeriesChart(
                                                                      _seriesLineData,
                                                                      primaryMeasureAxis:
                                                                          new charts
                                                                              .NumericAxisSpec(
                                                                        tickProviderSpec:
                                                                            new charts.StaticNumericTickProviderSpec(
                                                                          <charts.TickSpec<num>>[
                                                                            charts.TickSpec<num>(0),
                                                                            charts.TickSpec<num>(min),
                                                                            charts.TickSpec<num>(max),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      defaultRenderer: new charts.LineRendererConfig(
                                                                          includeArea:
                                                                              true,
                                                                          stacked:
                                                                              true),
                                                                      animate:
                                                                          true,
                                                                      animationDuration:
                                                                          Duration(
                                                                              seconds:
                                                                                  2),
                                                                      dateTimeFactory:
                                                                          const charts
                                                                              .LocalDateTimeFactory(),
                                                                      behaviors: [
                                                                        new charts.ChartTitle(
                                                                            AppLocalizations.of(context).translate(
                                                                                "Date"),
                                                                            titleStyleSpec:
                                                                                charts_common.TextStyleSpec(
                                                                              fontFamily: MyIdenaAppTheme.fontName,
                                                                              fontSize: 12,
                                                                            ),
                                                                            behaviorPosition: charts.BehaviorPosition.bottom,
                                                                            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                                                                        new charts.ChartTitle(
                                                                            AppLocalizations.of(context).translate("Price") +
                                                                                " " +
                                                                                "(EUR)",
                                                                            titleStyleSpec:
                                                                                charts_common.TextStyleSpec(
                                                                              fontFamily: MyIdenaAppTheme.fontName,
                                                                              fontSize: 12,
                                                                            ),
                                                                            behaviorPosition: charts.BehaviorPosition.start,
                                                                            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                                                                      ]),
                                                                ),
                                                              ],
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

class Price {
  DateTime dateVal;
  double priceVal;

  Price(this.dateVal, this.priceVal);
}
