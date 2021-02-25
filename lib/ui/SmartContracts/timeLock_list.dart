import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/model/smartContractTimeLock.dart';
import 'package:my_idena/network/model/request/contract/api_contract_balance_updates_response.dart';
import 'package:my_idena/network/model/request/contract/api_contract_txs_response.dart';
import 'package:my_idena/network/model/response/contract/contract_get_stake_response.dart';
import 'package:my_idena/network/model/response/dna_getBalance_response.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service/smart_contract_service.dart';
import 'package:my_idena/ui/SmartContracts/timeLock_detail.dart';
import 'package:my_idena/ui/SmartContracts/timeLock_sheet.dart';
import 'package:my_idena/ui/widgets/sheet_util.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/util/caseconverter.dart';

class TimeLockList extends StatefulWidget {
  String address;

  TimeLockList(this.address);

  _TimeLockListState createState() => _TimeLockListState();
}

class _TimeLockListState extends State<TimeLockList> {
  final Logger log = sl.get<Logger>();

  List<SmartContractTimeLock> smartContractTimeLockList =
      new List<SmartContractTimeLock>();

  @override
  void initState() {
    super.initState();
    // Initial list
    loadTimeLockContracts();
  }

  void loadTimeLockContracts() async {
    ApiContractTxsResponse apiContractTxsResponse = await sl
        .get<SmartContractService>()
        .getContractTxs(widget.address, 100, "TimeLock");
    if (apiContractTxsResponse != null &&
        apiContractTxsResponse.result != null) {
      for (int i = 0; i < apiContractTxsResponse.result.length; i++) {
        SmartContractTimeLock smartContractTimeLock =
            new SmartContractTimeLock();
        smartContractTimeLock.type = "TimeLock";
        smartContractTimeLock.owner = apiContractTxsResponse.result[i].from;
        smartContractTimeLock.contractAddress =
            apiContractTxsResponse.result[i].to;

        ApiContractBalanceUpdatesResponse apiContractBalanceUpdatesResponse =
            await sl.get<SmartContractService>().getContractBalanceUpdates(
                smartContractTimeLock.owner,
                apiContractTxsResponse.result[i].to,
                100);
        if (apiContractBalanceUpdatesResponse != null &&
            apiContractBalanceUpdatesResponse.result != null) {
          smartContractTimeLock.balanceUpdates =
              apiContractBalanceUpdatesResponse.result;
        }

        ContractGetStakeResponse contractGetStakeResponse = await sl
            .get<SmartContractService>()
            .getContractStake(smartContractTimeLock.contractAddress);
        if (contractGetStakeResponse != null &&
            contractGetStakeResponse.result != null) {
          smartContractTimeLock.stake =
              double.tryParse(contractGetStakeResponse.result.stake);
        }

        DnaGetBalanceResponse dnaGetBalanceResponse = await sl
            .get<AppService>()
            .getBalanceGetResponse(
                smartContractTimeLock.contractAddress, false);
        if (dnaGetBalanceResponse != null &&
            dnaGetBalanceResponse.result != null) {
          smartContractTimeLock.balance =
              double.tryParse(dnaGetBalanceResponse.result.balance);
        } else {
          smartContractTimeLock.balance = 0;
        }

        int contractReadDataTimestamp = await sl
            .get<SmartContractService>()
            .getContractReadDataUint64(
                smartContractTimeLock.contractAddress, "timestamp");
        smartContractTimeLock.timestamp = contractReadDataTimestamp;

        smartContractTimeLockList.add(smartContractTimeLock);
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
                                  AppLocalization.of(context).timeLockTitle,
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
                    smartContractTimeLockList != null
                        ? ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 15.0, bottom: 15),
                            itemCount: smartContractTimeLockList.length,
                            itemBuilder: (context, index) {
                              // Build
                              return buildSingleTimeLock(
                                  context, smartContractTimeLockList[index]);
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
                        AppLocalization.of(context).createTimeLock,
                        Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                      Sheets.showAppHeightNineSheet(
                          context: context,
                          widget: TimeLockSheet(
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

  buildSingleTimeLock(
      BuildContext context, SmartContractTimeLock smartContractTimeLock) {
    return FlatButton(
      onPressed: () {
        Sheets.showAppHeightEightSheet(
            context: context,
            widget:
                TimeLockDetail(smartContractTimeLock: smartContractTimeLock));
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
                  child: Icon(
                      smartContractTimeLock.isLocked() == null
                          ? FontAwesome.stop_circle
                          : smartContractTimeLock.isLocked()
                              ? FontAwesome.lock
                              : FontAwesome.lock_open,
                      size: 26,
                      color: StateContainer.of(context).curTheme.success),
                ),
              ),
              // info
              Expanded(
                child: Container(
                  height: 140,
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
                                text: smartContractTimeLock.contractAddress,
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
                                text: smartContractTimeLock.owner,
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
                              text: smartContractTimeLock.balance.toString() +
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
                              text: smartContractTimeLock.stake.toString() +
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
                      smartContractTimeLock.timestamp == null
                          ? SizedBox()
                          : RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: '',
                                children: [
                                  TextSpan(
                                    text: "Unlock time: ",
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
                                    text: DateFormat.yMEd(
                                            Localizations.localeOf(context)
                                                .languageCode)
                                        .add_Hm()
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    smartContractTimeLock
                                                            .timestamp *
                                                        1000)
                                                .toLocal())
                                        .toString(),
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
                      smartContractTimeLock.getLastBalanceUpdates() == null
                          ? SizedBox()
                          : RichText(
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
                                  smartContractTimeLock
                                              .getLastBalanceUpdates()
                                              .txReceipt ==
                                          null
                                      ? TextSpan(
                                          text: smartContractTimeLock
                                                  .getLastBalanceUpdates()
                                                  .type +
                                              " - Success",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w100,
                                            fontFamily: 'Roboto',
                                          ),
                                        )
                                      : smartContractTimeLock
                                              .getLastBalanceUpdates()
                                              .txReceipt
                                              .success
                                          ? TextSpan(
                                              text: smartContractTimeLock
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
                                              text: smartContractTimeLock
                                                      .getLastBalanceUpdates()
                                                      .txReceipt
                                                      .method +
                                                  " - " +
                                                  smartContractTimeLock
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
