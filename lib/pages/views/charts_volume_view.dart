import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/coins_price_response.dart';
import 'package:my_idena/backoffice/factory/coins_service.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as charts_common;
import 'package:my_idena/utils/app_localizations.dart';

class ChartsVolumeView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ChartsVolumeView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ChartsVolumeViewState createState() => _ChartsVolumeViewState();
}

class _ChartsVolumeViewState extends State<ChartsVolumeView> {
  CoinsService coinsService = new CoinsService();

  List<charts.Series<Volume, DateTime>> _seriesLineData;

  @override
  initState() {
    super.initState();

    _seriesLineData = List<charts.Series<Volume, DateTime>>();
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
            List<Volume> linePricesData = new List();
            double min = 10000000;
            double max = 0;
            for (int i = 0; i < coinsPriceResponse.totalVolumes.length; i = i + 5) {
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
                                                          height: 150,
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
                                                                      defaultRenderer:
                                                                          new charts
                                                                              .BarRendererConfig(),
                                                                      defaultInteractions:
                                                                          false,
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
                                                                        new charts
                                                                            .SelectNearest(),
                                                                        new charts
                                                                            .DomainHighlighter(),
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
                                                                            AppLocalizations.of(context).translate("Volume") +
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

class Volume {
  DateTime date;
  double value;

  Volume(this.date, this.value);
}
