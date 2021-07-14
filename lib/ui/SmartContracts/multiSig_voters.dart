// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:idena_lib_dart/factory/smart_contract_service.dart';
import 'package:idena_lib_dart/model/response/contract/contract_iterate_map_response.dart';
import 'package:idena_lib_dart/util/crypto/utils_crypto.dart';
import 'package:logger/logger.dart';

// Project imports:
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/util/caseconverter.dart';

class MultiSigVoters extends StatefulWidget {
  final String contractAddress;

  MultiSigVoters(this.contractAddress);

  _MultiSigVotersState createState() => _MultiSigVotersState();
}

class _MultiSigVotersState extends State<MultiSigVoters> {
  final Logger log = sl.get<Logger>();
  bool loaded;

  List<ContractIterateMapResponseItem> _contractIterateMapResponseItems =
      new List<ContractIterateMapResponseItem>();
  List<ContractIterateMapResponseItem>
      _contractIterateMapResponseItemsForDisplay =
      new List<ContractIterateMapResponseItem>();
  List<ContractIterateMapResponseItem> contractIterateMapResponseAmountList =
      new List<ContractIterateMapResponseItem>();

  @override
  void initState() {
    //
    loaded = false;

    loadVotersList().then((value) {
      setState(() {
        _contractIterateMapResponseItems.addAll(value);
        _contractIterateMapResponseItemsForDisplay =
            _contractIterateMapResponseItems;
        loaded = true;
      });
    });
    super.initState();
  }

  String getAmount(String address) {
    double amount = 0;
    try {
      for (int i = 0; i < contractIterateMapResponseAmountList.length; i++) {
        if (address == contractIterateMapResponseAmountList[i].key) {
          if (remove0x(contractIterateMapResponseAmountList[i].value) != "") {
            amount = double.parse((Decimal.parse(int.parse(
                            remove0x(
                                contractIterateMapResponseAmountList[i].value),
                            radix: 16)
                        .toString()) /
                    Decimal.parse("1000000000000000000"))
                .toString());
            break;
          }
        }
      }
    } catch (e) {}

    return amount.toString();
  }

  Future<List<ContractIterateMapResponseItem>> loadVotersList() async {
    contractIterateMapResponseAmountList = await loadDonationsList();

    ContractIterateMapResponse contractIterateMapResponse = await sl
        .get<SmartContractService>()
        .getContractIterateMapAddr(widget.contractAddress, null);
    if (contractIterateMapResponse != null &&
        contractIterateMapResponse.result != null) {
      return contractIterateMapResponse.result.items;
    } else {
      return null;
    }
  }

  Future<List<ContractIterateMapResponseItem>> loadDonationsList() async {
    ContractIterateMapResponse contractIterateMapResponse = await sl
        .get<SmartContractService>()
        .getContractIterateMapAmount(widget.contractAddress, null);
    if (contractIterateMapResponse != null &&
        contractIterateMapResponse.result != null) {
      return contractIterateMapResponse.result.items;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
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
                                AppLocalization.of(context).listOfVoters,
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

            // A main container that holds everything
            Expanded(
              child: Stack(
                children: <Widget>[
                  loaded == true
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 15.0, bottom: 15),
                          itemCount:
                              _contractIterateMapResponseItemsForDisplay.length,
                          itemBuilder: (context, index) {
                            // Build
                            return buildSingleVote(
                                context,
                                _contractIterateMapResponseItemsForDisplay[
                                    index]);
                          },
                        )
                      : Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ));
  }

  Widget buildSingleVote(BuildContext context,
      ContractIterateMapResponseItem contractIterateMapResponseItem) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: Column(children: <Widget>[
        Divider(
          height: 2,
          color: StateContainer.of(context).curTheme.text15,
        ),
        // Main Container
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          margin: new EdgeInsetsDirectional.only(start: 12.0, end: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        contractIterateMapResponseItem.key,
                        style: AppStyles.textStyleTransactionAddress(
                          context,
                        ),
                      ),
                      getAmount(contractIterateMapResponseItem.key) != "0.0"
                          ? Row(children: [
                              Icon(FontAwesome5.vote_yea,
                                  size: 14,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary),
                              SizedBox(width: 10),
                              Text(
                                contractIterateMapResponseItem.value,
                                style: AppStyles.textStyleTransactionAddress(
                                  context,
                                ),
                              ),
                            ])
                          : Row(children: [
                              Icon(AppIcons.info,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  size: 14),
                              SizedBox(width: 10),
                              Text(
                                AppLocalization.of(context).notVoteYet,
                                style: TextStyle(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ]),
                      getAmount(contractIterateMapResponseItem.key) != "0.0"
                          ? Row(children: [
                              Icon(AppIcons.export_icon,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  size: 14),
                              SizedBox(width: 10),
                              Text(
                                AppLocalization.of(context)
                                    .approvedUnlockContract
                                    .replaceAll(
                                        "%1",
                                        getAmount(contractIterateMapResponseItem
                                            .key)),
                                style: TextStyle(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ])
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
