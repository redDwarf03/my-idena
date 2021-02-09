import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as charts_common;
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/available_currency.dart';
import 'package:my_idena/network/model/response/coins_price_response.dart';
import 'package:my_idena/service/coins_service.dart';
import 'package:my_idena/service_locator.dart';

class ChartsPriceView extends StatefulWidget {
  final AvailableCurrency localCurrency;

  const ChartsPriceView({Key key, this.localCurrency}) : super(key: key);

  @override
  _ChartsPriceViewState createState() => _ChartsPriceViewState();
}

class _ChartsPriceViewState extends State<ChartsPriceView> {
  List<charts.Series<Price, DateTime>> _seriesLineData;

  @override
  initState() {
    super.initState();
    _seriesLineData = List<charts.Series<Price, DateTime>>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CoinsPriceResponse>(
        future: sl
            .get<CoinsService>()
            .getCoinsChart(widget.localCurrency.getIso4217Code(), 7),
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

            return Container(
                height: 200,
                child: Center(
                    child: Column(children: <Widget>[
                  Expanded(
                      child: charts.TimeSeriesChart(_seriesLineData,
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                            tickProviderSpec:
                                new charts.StaticNumericTickProviderSpec(
                              <charts.TickSpec<num>>[
                                charts.TickSpec<num>(min),
                                charts.TickSpec<num>(min + ((max - min) / 4)),
                                charts.TickSpec<num>(
                                    min + ((max - min) / 4) * 2),
                                charts.TickSpec<num>(
                                    min + ((max - min) / 4) * 3),
                                charts.TickSpec<num>(max),
                              ],
                            ),
                          ),
                          defaultRenderer: new charts.LineRendererConfig(
                              includeArea: true, stacked: true),
                          animate: false,
                          dateTimeFactory: const charts.LocalDateTimeFactory(),
                          behaviors: [
                        new charts.ChartTitle(AppLocalization.of(context).chartDate,
                            titleStyleSpec: charts_common.TextStyleSpec(
                              fontSize: 12,
                            ),
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                        new charts.ChartTitle(
                            AppLocalization.of(context).chartPrice + " (" +
                                widget.localCurrency.getIso4217Code() +
                                ")",
                            titleStyleSpec: charts_common.TextStyleSpec(
                              fontSize: 12,
                            ),
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                      ]))
                ])));
          }
        });
  }
}

class Price {
  DateTime dateVal;
  double priceVal;

  Price(this.dateVal, this.priceVal);
}
