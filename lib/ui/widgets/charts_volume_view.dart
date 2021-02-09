import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as charts_common;
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/available_currency.dart';
import 'package:my_idena/network/model/response/coins_price_response.dart';
import 'package:my_idena/service/coins_service.dart';
import 'package:my_idena/service_locator.dart';

class ChartsVolumeView extends StatefulWidget {
  final AvailableCurrency localCurrency;

  const ChartsVolumeView({Key key, this.localCurrency}) : super(key: key);

  @override
  _ChartsVolumeViewState createState() => _ChartsVolumeViewState();
}

class _ChartsVolumeViewState extends State<ChartsVolumeView> {
  List<charts.Series<Volume, DateTime>> _seriesLineData;

  @override
  initState() {
    super.initState();

    _seriesLineData = List<charts.Series<Volume, DateTime>>();
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
            List<Volume> linePricesData = new List();
            double min = 10000000;
            double max = 0;
            for (int i = 0;
                i < coinsPriceResponse.totalVolumes.length;
                i = i + 5) {
              if (min > coinsPriceResponse.totalVolumes[i][1].toDouble()) {
                min = coinsPriceResponse.totalVolumes[i][1].toDouble();
              }
              if (max < coinsPriceResponse.totalVolumes[i][1].toDouble()) {
                max = coinsPriceResponse.totalVolumes[i][1].toDouble();
              }
              Volume volume = new Volume(
                  DateTime.fromMillisecondsSinceEpoch(
                      coinsPriceResponse.prices[i][0].toInt()),
                  coinsPriceResponse.totalVolumes[i][1].toDouble());
              linePricesData.add(volume);
            }

            _seriesLineData.add(
              charts.Series<Volume, DateTime>(
                colorFn: (__, _) =>
                    charts.ColorUtil.fromDartColor(Color(0xff5D7F99)),
                id: 'Volume',
                data: linePricesData,
                domainFn: (Volume volume, _) => volume.date,
                measureFn: (Volume volume, _) => volume.value,
              ),
            );

            return Container(
                height: 150,
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.0750,
                  right: MediaQuery.of(context).size.width * 0.0750,
                ),
                child: Center(
                    child: Column(children: <Widget>[
                  Expanded(
                      child: charts.TimeSeriesChart(_seriesLineData,
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                            tickProviderSpec:
                                new charts.StaticNumericTickProviderSpec(
                              <charts.TickSpec<num>>[
                                charts.TickSpec<num>(0),
                                charts.TickSpec<num>((max ~/ 2).toInt()),
                                charts.TickSpec<num>(max.toInt()),
                              ],
                            ),
                          ),
                          defaultRenderer: new charts.BarRendererConfig(),
                          defaultInteractions: false,
                          animate: false,
                          dateTimeFactory: const charts.LocalDateTimeFactory(),
                          behaviors: [
                        new charts.SelectNearest(),
                        new charts.DomainHighlighter(),
                        new charts.ChartTitle(
                            AppLocalization.of(context).chartDate,
                            titleStyleSpec: charts_common.TextStyleSpec(
                              fontSize: 12,
                            ),
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                        new charts.ChartTitle(
                            AppLocalization.of(context).chartVolume +
                                " (" +
                                widget.localCurrency.getIso4217Code() +
                                ")",
                            titleStyleSpec: charts_common.TextStyleSpec(
                              fontSize: 12,
                            ),
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleOutsideJustification:
                                charts.OutsideJustification.end),
                      ]))
                ])));
          }
        });
  }
}

class Volume {
  DateTime date;
  double value;

  Volume(this.date, this.value);
}
