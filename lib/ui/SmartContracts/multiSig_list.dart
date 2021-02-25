import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/model/smartContractMultiSig.dart';
import 'package:my_idena/network/model/request/contract/api_contract_balance_updates_response.dart';
import 'package:my_idena/network/model/request/contract/api_contract_txs_response.dart';
import 'package:my_idena/network/model/response/contract/contract_get_stake_response.dart';
import 'package:my_idena/network/model/response/dna_getBalance_response.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service/smart_contract_service.dart';
import 'package:my_idena/ui/SmartContracts/multiSig_detail.dart';
import 'package:my_idena/ui/SmartContracts/multiSig_sheet.dart';
import 'package:my_idena/ui/widgets/sheet_util.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/util/caseconverter.dart';

class MultiSigList extends StatefulWidget {
  String address;

  MultiSigList(this.address);

  _MultiSigListState createState() => _MultiSigListState();
}

class _MultiSigListState extends State<MultiSigList> {
  final Logger log = sl.get<Logger>();

  List<SmartContractMultiSig> smartContractMultiSigList =
      new List<SmartContractMultiSig>();

  @override
  void initState() {
    super.initState();
    // Initial list
    loadMultiSigContracts();
  }

  void loadMultiSigContracts() async {
    ApiContractTxsResponse apiContractTxsResponse = await sl
        .get<SmartContractService>()
        .getContractTxs(widget.address, 100, "Multisig");
    if (apiContractTxsResponse != null &&
        apiContractTxsResponse.result != null) {
      for (int i = 0; i < apiContractTxsResponse.result.length; i++) {
        SmartContractMultiSig smartContractMultiSig =
            new SmartContractMultiSig();
        smartContractMultiSig.type = "Multisig";
        smartContractMultiSig.owner = apiContractTxsResponse.result[i].from;
        smartContractMultiSig.contractAddress =
            apiContractTxsResponse.result[i].to;

        ApiContractBalanceUpdatesResponse apiContractBalanceUpdatesResponse =
            await sl.get<SmartContractService>().getContractBalanceUpdates(
                smartContractMultiSig.owner,
                apiContractTxsResponse.result[i].to,
                100);
        if (apiContractBalanceUpdatesResponse != null &&
            apiContractBalanceUpdatesResponse.result != null) {
          smartContractMultiSig.balanceUpdates =
              apiContractBalanceUpdatesResponse.result;
        }

        ContractGetStakeResponse contractGetStakeResponse = await sl
            .get<SmartContractService>()
            .getContractStake(smartContractMultiSig.contractAddress);
        if (contractGetStakeResponse != null &&
            contractGetStakeResponse.result != null) {
          smartContractMultiSig.stake =
              double.tryParse(contractGetStakeResponse.result.stake);
        }

        DnaGetBalanceResponse dnaGetBalanceResponse = await sl
            .get<AppService>()
            .getBalanceGetResponse(
                smartContractMultiSig.contractAddress, false);
        if (dnaGetBalanceResponse != null &&
            dnaGetBalanceResponse.result != null) {
          smartContractMultiSig.balance =
              double.tryParse(dnaGetBalanceResponse.result.balance);
        } else {
          smartContractMultiSig.balance = 0;
        }

        int maxVotes = await sl
            .get<SmartContractService>()
            .getContractReadDataByte(
                smartContractMultiSig.contractAddress, "maxVotes");
        smartContractMultiSig.maxVotes = maxVotes;

        int minVotes = await sl
            .get<SmartContractService>()
            .getContractReadDataByte(
                smartContractMultiSig.contractAddress, "minVotes");
        smartContractMultiSig.minVotes = minVotes;

        int count = await sl
            .get<SmartContractService>()
            .getContractReadDataByte(
                smartContractMultiSig.contractAddress, "count");
        smartContractMultiSig.count = count;

        int state = await sl
            .get<SmartContractService>()
            .getContractReadDataByte(
                smartContractMultiSig.contractAddress, "state");
        smartContractMultiSig.state = state;

        smartContractMultiSigList.add(smartContractMultiSig);
      }
    }

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDark,
          boxShadow: [
            BoxShadow(
                color: StateContainer.of(context).curTheme.overlay30,
                offset: Offset(-5, 0),
                blurRadius: 20),
          ],
        ),
        child: SafeArea(
          minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.035,
          ),
          child: Column(
            children: <Widget>[
              // A row for the address text and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Empty SizedBox
                  SizedBox(
                    width: 60,
                    height: 60,
                  ),
                  //Container for the address text and sheet handle
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
                                  AppLocalization.of(context).multisigTitle,
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

              // list + top and bottom gradients
              Expanded(
                child: Stack(
                  children: <Widget>[
                    //  list
                    smartContractMultiSigList != null
                        ? ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 15.0, bottom: 15),
                            itemCount: smartContractMultiSigList.length,
                            itemBuilder: (context, index) {
                              // Build
                              return buildSingleMultiSig(
                                  context, smartContractMultiSigList[index]);
                            },
                          )
                        : SizedBox(),
                    //List Top Gradient End
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 20.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark,
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark00
                            ],
                            begin: AlignmentDirectional(0.5, -1.0),
                            end: AlignmentDirectional(0.5, 1.0),
                          ),
                        ),
                      ),
                    ),
                    //List Bottom Gradient End
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 15.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark00,
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark,
                            ],
                            begin: AlignmentDirectional(0.5, -1.0),
                            end: AlignmentDirectional(0.5, 1.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    AppButton.buildAppButton(
                        context,
                        AppButtonType.TEXT_OUTLINE,
                        AppLocalization.of(context).createMultiSig,
                        Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                      Sheets.showAppHeightNineSheet(
                          context: context,
                          widget: MultiSigSheet(
                              address: widget.address,
                              localCurrency:
                                  StateContainer.of(context).curCurrency));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  buildSingleMultiSig(
      BuildContext context, SmartContractMultiSig smartContractMultiSig) {
    return FlatButton(
      onPressed: () {
        Sheets.showAppHeightEightSheet(
            context: context,
            widget:
                MultiSigDetail(smartContractMultiSig: smartContractMultiSig));
      },
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
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: <
                    Widget>[
              Container(
                width: 32.0,
                height: 32.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(FontAwesome.stop_circle,
                      size: 26,
                      color: StateContainer.of(context).curTheme.success),
                ),
              ),
              // info
              Expanded(
                child: Container(
                  height: 180,
                  margin: EdgeInsetsDirectional.only(start: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                              text: "Smart Contract : ",
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            TextSpan(
                                text: smartContractMultiSig.contractAddress,
                                style: AppStyles.textStyleTransactionAddress(
                                    context)),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                              text: "Owner : ",
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            TextSpan(
                                text: smartContractMultiSig.owner,
                                style: AppStyles.textStyleTransactionAddress(
                                    context)),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                              text: "Balance : ",
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            TextSpan(
                              text: smartContractMultiSig.balance.toString() +
                                  " iDNA",
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                              text: "Stake : ",
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            TextSpan(
                              text: smartContractMultiSig.stake.toString() +
                                  " iDNA",
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                              text: "Number of voters : ",
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            TextSpan(
                              text: smartContractMultiSig.maxVotes.toString(),
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                              text:
                                  "Min nb of votes required to unlock the coins : ",
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            TextSpan(
                              text: smartContractMultiSig.minVotes.toString(),
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                              text: "Status : ",
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            smartContractMultiSig.state == 1
                                ? TextSpan(
                                    text:
                                        "The list of voters is not defined yet (actually " +
                                            smartContractMultiSig.count
                                                .toString() +
                                            " voter(s))",
                                    style: TextStyle(
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .primary60,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Roboto',
                                    ),
                                  )
                                : TextSpan(
                                    text: "The list of voters is complete",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                              text: "Last status : ",
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            smartContractMultiSig
                                    .getLastBalanceUpdates()
                                    .txReceipt
                                    .success
                                ? TextSpan(
                                    text: smartContractMultiSig
                                            .getLastBalanceUpdates()
                                            .txReceipt
                                            .method +
                                        " - Success",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Roboto',
                                    ),
                                  )
                                : TextSpan(
                                    text: smartContractMultiSig
                                            .getLastBalanceUpdates()
                                            .txReceipt
                                            .method +
                                        " - " +
                                        smartContractMultiSig
                                            .getLastBalanceUpdates()
                                            .txReceipt
                                            .errorMsg,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ])),
      ]),
    );
  }
}
