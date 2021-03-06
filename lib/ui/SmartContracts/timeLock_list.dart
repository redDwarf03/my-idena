import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/model/smartContractTimeLock.dart';
import 'package:my_idena/network/model/request/contract/api_contract_balance_updates_response.dart';
import 'package:my_idena/network/model/request/contract/api_contract_txs_response.dart';
import 'package:my_idena/network/model/response/contract/contract_get_stake_response.dart';
import 'package:my_idena/network/model/response/dna_getBalance_response.dart';
import 'package:my_idena/factory/app_service.dart';
import 'package:my_idena/factory/smart_contract_service.dart';
import 'package:my_idena/ui/send/send_sheet.dart';
import 'package:my_idena/ui/smartContracts/smart_contract_terminate_sheet.dart';
import 'package:my_idena/ui/smartContracts/smart_contract_transfer_sheet.dart';
import 'package:my_idena/ui/smartContracts/timeLock_sheet.dart';
import 'package:my_idena/ui/widgets/sheet_util.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';
import 'package:timelines/timelines.dart';

const kTileHeight = 50.0;
const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xFF5890FF);
const todoColor = Color(0xffd1d2d7);

class TimeLockList extends StatefulWidget {
  final String address;

  TimeLockList(this.address);

  _TimeLockListState createState() => _TimeLockListState();
}

class _TimeLockListState extends State<TimeLockList> {
  final Logger log = sl.get<Logger>();
  bool loaded;
  int _processIndex;
  var _processes;

  List<SmartContractTimeLock> smartContractTimeLockList =
      new List<SmartContractTimeLock>();

  PageController _controller;

  @override
  void initState() {
    loaded = false;
    _processes = ['Deploy', 'Lock', 'Unlock', 'Transfer', 'Terminate'];
    super.initState();
    _controller = PageController();
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

    setState(() {
      if (mounted) {
        loaded = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
                      SizedBox(height: 10),
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
                    loaded == true
                        ? PageView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: _controller,
                            itemCount: smartContractTimeLockList.length,
                            itemBuilder: (context, index) {
                              // Build
                              return buildSingleTimeLock(
                                  context, smartContractTimeLockList[index]);
                            },
                          )
                        : Center(child: CircularProgressIndicator()),
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
              smartContractTimeLockList != null &&
                      smartContractTimeLockList.length > 0
                  ? ScrollingPageIndicator(
                      dotColor: StateContainer.of(context).curTheme.primary30,
                      dotSelectedColor:
                          StateContainer.of(context).curTheme.primary,
                      dotSize: 6,
                      dotSelectedSize: 8,
                      dotSpacing: 12,
                      controller: _controller,
                      itemCount: smartContractTimeLockList.length,
                      orientation: Axis.horizontal,
                    )
                  : SizedBox(),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    AppButton.buildAppButton(
                        context,
                        AppButtonType.PRIMARY,
                        AppLocalization.of(context).createTimeLock,
                        Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                      Sheets.showAppHeightEightSheet(
                          context: context,
                          widget: TimeLockSheet(
                            address: widget.address,
                          ));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Color getColor(int index) {
    if (index == _processIndex && index != 4) {
      return inProgressColor;
    } else if (index <= _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  buildSingleTimeLock(
      BuildContext context, SmartContractTimeLock smartContractTimeLock) {
    _processIndex = 0;
    if (smartContractTimeLock.getLastBalanceUpdates().txReceipt.method ==
        "deploy") {
      if (smartContractTimeLock.isLocked() == null) {
        _processIndex = 3;
      } else {
        if (smartContractTimeLock.isLocked()) {
          _processIndex = 1;
        } else {
          _processIndex = 2;
        }
      }
    } else if (smartContractTimeLock.getLastBalanceUpdates().txReceipt.method ==
        "transfer") {
      _processIndex = 3;
    } else if (smartContractTimeLock.getLastBalanceUpdates().txReceipt.method ==
        "terminate") {
      _processIndex = 4;
    }
    return FlatButton(
      onPressed: () {},
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.grey[200],
          elevation: 10,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  height: 60,
                  child: Timeline.tileBuilder(
                    theme: TimelineThemeData(
                      direction: Axis.horizontal,
                      connectorTheme: ConnectorThemeData(
                        space: 20.0,
                        thickness: 5.0,
                      ),
                    ),
                    builder: TimelineTileBuilder.connected(
                      connectionDirection: ConnectionDirection.before,
                      itemExtentBuilder: (_, __) =>
                          (MediaQuery.of(context).size.width - 40) /
                          _processes.length,
                      oppositeContentsBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: index == 0
                                ? Icon(FontAwesome5.file_contract,
                                    size: 14, color: getColor(index))
                                : index == 1
                                    ? Icon(FontAwesome5.lock,
                                        size: 14, color: getColor(index))
                                    : index == 2
                                        ? Icon(FontAwesome5.lock_open,
                                            size: 14, color: getColor(index))
                                        : index == 3
                                            ? Icon(FontAwesome5.share_square,
                                                size: 14,
                                                color: getColor(index))
                                            : Icon(FontAwesome.stop_circle,
                                                size: 16,
                                                color: getColor(index)));
                      },
                      contentsBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            _processes[index],
                            style: TextStyle(
                              color: getColor(index),
                              fontSize: 10.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        );
                      },
                      indicatorBuilder: (_, index) {
                        var color;
                        var child;
                        if (index == _processIndex && index != 4) {
                          color = inProgressColor;
                          child = Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: index == 3
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 10.0,
                                  )
                                : CircularProgressIndicator(
                                    strokeWidth: 1.0,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                          );
                        } else if (index <= _processIndex) {
                          color = completeColor;
                          child = Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 10.0,
                          );
                        } else {
                          color = todoColor;
                        }

                        if (index <= _processIndex) {
                          return Stack(
                            children: [
                              CustomPaint(
                                size: Size(20.0, 20.0),
                                painter: _BezierPainter(
                                  color: color,
                                  drawStart: index > 0,
                                  drawEnd: index < _processIndex,
                                ),
                              ),
                              DotIndicator(
                                size: 20.0,
                                color: color,
                                child: child,
                              ),
                            ],
                          );
                        } else {
                          return Stack(
                            children: [
                              CustomPaint(
                                size: Size(10.0, 10.0),
                                painter: _BezierPainter(
                                  color: color,
                                  drawEnd: index < _processes.length - 1,
                                ),
                              ),
                              OutlinedDotIndicator(
                                borderWidth: 4.0,
                                color: color,
                              ),
                            ],
                          );
                        }
                      },
                      connectorBuilder: (_, index, type) {
                        if (index > 0) {
                          if (index == _processIndex) {
                            final prevColor = getColor(index - 1);
                            final color = getColor(index);
                            var gradientColors;
                            if (type == ConnectorType.start) {
                              gradientColors = [
                                Color.lerp(prevColor, color, 0.5),
                                color
                              ];
                            } else {
                              gradientColors = [
                                prevColor,
                                Color.lerp(prevColor, color, 0.5)
                              ];
                            }
                            return DecoratedLineConnector(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: gradientColors,
                                ),
                              ),
                            );
                          } else {
                            return SolidLineConnector(
                              color: getColor(index),
                            );
                          }
                        } else {
                          return null;
                        }
                      },
                      itemCount: _processes.length,
                    ),
                  ),
                ),
                // Main Container
                Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    margin: new EdgeInsetsDirectional.only(
                        start: 12.0, end: 0.0, bottom: 0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // info
                          Expanded(
                            child: Container(
                              margin: EdgeInsetsDirectional.only(start: 2.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    AppLocalization.of(context)
                                        .smartContractLabel,
                                    style: TextStyle(
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .primary,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  SelectableText(
                                      smartContractTimeLock.contractAddress,
                                      style:
                                          AppStyles.textStyleTransactionAddress(
                                              context)),
                                  Text(
                                    AppLocalization.of(context).ownerLabel,
                                    style: TextStyle(
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .primary,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  SelectableText(smartContractTimeLock.owner,
                                      style:
                                          AppStyles.textStyleTransactionAddress(
                                              context)),
                                  SizedBox(height: 20),
                                  _processIndex == 4
                                      ? SizedBox()
                                      : Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    text: '',
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            AppLocalization.of(
                                                                    context)
                                                                .balanceLabel,
                                                        style: TextStyle(
                                                          color:
                                                              StateContainer.of(
                                                                      context)
                                                                  .curTheme
                                                                  .primary,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Roboto',
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            smartContractTimeLock
                                                                    .balance
                                                                    .toString() +
                                                                " iDNA",
                                                        style: TextStyle(
                                                          color:
                                                              StateContainer.of(
                                                                      context)
                                                                  .curTheme
                                                                  .primary60,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w100,
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
                                                            AppLocalization.of(
                                                                    context)
                                                                .stakeLabel,
                                                        style: TextStyle(
                                                          color:
                                                              StateContainer.of(
                                                                      context)
                                                                  .curTheme
                                                                  .primary,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Roboto',
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            smartContractTimeLock
                                                                    .stake
                                                                    .toString() +
                                                                " iDNA",
                                                        style: TextStyle(
                                                          color:
                                                              StateContainer.of(
                                                                      context)
                                                                  .curTheme
                                                                  .primary60,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontFamily: 'Roboto',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                              height: 10,
                                            ),
                                            _processIndex >= 3
                                                ? SizedBox()
                                                : MaterialButton(
                                                    onPressed: () {
                                                      Sheets.showAppHeightNineSheet(
                                                          context: context,
                                                          widget: SendSheet(
                                                              address:
                                                                  smartContractTimeLock
                                                                      .contractAddress,
                                                              localCurrency:
                                                                  StateContainer.of(
                                                                          context)
                                                                      .curCurrency));
                                                    },
                                                    color: StateContainer.of(
                                                            context)
                                                        .curTheme
                                                        .primary,
                                                    textColor: Colors.white,
                                                    child: Icon(
                                                      AppIcons.export_icon,
                                                      size: 14,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22.0)),
                                                  ),
                                          ],
                                        ),
                                  _processIndex == 4
                                      ? SizedBox()
                                      : SizedBox(height: 20),
                                  smartContractTimeLock.timestamp == null
                                      ? SizedBox()
                                      : RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: '',
                                            children: [
                                              TextSpan(
                                                text:
                                                    AppLocalization.of(context)
                                                        .unlockTimeLabel,
                                                style: TextStyle(
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .primary,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                              TextSpan(
                                                text: DateFormat.yMEd(
                                                        Localizations.localeOf(
                                                                context)
                                                            .languageCode)
                                                    .add_Hm()
                                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                                            smartContractTimeLock
                                                                    .timestamp *
                                                                1000)
                                                        .toLocal())
                                                    .toString(),
                                                style: TextStyle(
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .primary60,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w100,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  smartContractTimeLock.timestamp == null
                                      ? SizedBox()
                                      : SizedBox(
                                          height: 20,
                                        ),
                                  smartContractTimeLock
                                              .getLastBalanceUpdates() ==
                                          null
                                      ? SizedBox()
                                      : RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: '',
                                            children: [
                                              TextSpan(
                                                text:
                                                    AppLocalization.of(context)
                                                        .unlockTimeLabel,
                                                style: TextStyle(
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .primary,
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
                                                          " - " +
                                                          AppLocalization.of(
                                                                  context)
                                                              .successInfo,
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w100,
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
                                                              " - " +
                                                              AppLocalization.of(
                                                                      context)
                                                                  .successInfo,
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontFamily:
                                                                'Roboto',
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
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontFamily:
                                                                'Roboto',
                                                          ),
                                                        ),
                                            ],
                                          ),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      _processIndex >= 3 || _processIndex == 1
                                          ? SizedBox()
                                          : MaterialButton(
                                              onPressed: () {
                                                Sheets.showAppHeightEightSheet(
                                                    context: context,
                                                    widget: SmartContractTransferSheet(
                                                        title:
                                                            AppLocalization.of(
                                                                    context)
                                                                .timeLockTitle,
                                                        contractBalance:
                                                            smartContractTimeLock
                                                                .balance
                                                                .toString(),
                                                        contractAddress:
                                                            smartContractTimeLock
                                                                .contractAddress,
                                                        owner:
                                                            smartContractTimeLock
                                                                .owner));
                                              },
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .primary,
                                              textColor: Colors.white,
                                              child: Icon(
                                                FontAwesome5.share_square,
                                                size: 16,
                                              ),
                                              padding: EdgeInsets.all(14),
                                              shape: CircleBorder(),
                                            ),
                                      _processIndex == 4
                                          ? SizedBox()
                                          : MaterialButton(
                                              onPressed: () {
                                                Sheets.showAppHeightEightSheet(
                                                    context: context,
                                                    widget: SmartContractTerminateSheet(
                                                        title:
                                                            AppLocalization.of(
                                                                    context)
                                                                .timeLockTitle,
                                                        contractStake:
                                                            smartContractTimeLock
                                                                .stake
                                                                .toString(),
                                                        contractAddress:
                                                            smartContractTimeLock
                                                                .contractAddress,
                                                        owner:
                                                            smartContractTimeLock
                                                                .owner));
                                              },
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .primary,
                                              textColor: Colors.white,
                                              child: Icon(
                                                FontAwesome.stop_circle,
                                                size: 22,
                                              ),
                                              padding: EdgeInsets.all(12),
                                              shape: CircleBorder(),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])),
              ])),
    );
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    @required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius)
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(
            size.width, size.height / 2, size.width + radius, radius)
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
