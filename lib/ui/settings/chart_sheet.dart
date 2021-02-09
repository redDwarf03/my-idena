import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/available_currency.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/widgets/charts_price_view.dart';
import 'package:my_idena/ui/widgets/charts_volume_view.dart';
import 'package:my_idena/util/caseconverter.dart';

class ChartSheet extends StatefulWidget {
  final AvailableCurrency localCurrency;

  ChartSheet({
    @required this.localCurrency,
  }) : super();

  _ChartSheetState createState() => _ChartSheetState();
}

enum AddressStyle { TEXT60, TEXT90, PRIMARY }

class _ChartSheetState extends State<ChartSheet> {

  @override
  Widget build(BuildContext context) {
    // The main column that holds everything
    return SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            // A row for the header of the sheet, balance text and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Empty SizedBox
                SizedBox(
                  width: 60,
                  height: 60,
                ),

                // Container for the header, address and balance text
                Column(
                  children: <Widget>[
                    // Sheet handle
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: StateContainer.of(context).curTheme.text10,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 140),
                      child: Column(
                        children: <Widget>[
                          // Header
                          AutoSizeText(
                            CaseChange.toUpperCase(
                                AppLocalization.of(context).chartHeader,
                                context),
                            style: AppStyles.textStyleHeader(context),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            stepGranularity: 0.1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //Empty SizedBox
                SizedBox(
                  width: 60,
                  height: 60,
                ),
              ],
            ),
            SizedBox(height: 30),
            ChartsPriceView(localCurrency: widget.localCurrency,),
            ChartsVolumeView(localCurrency: widget.localCurrency,)
          ],
        ));
  }
}
