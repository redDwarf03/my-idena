// @dart=2.9

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:idena_lib_dart/factory/smart_contract_service.dart';
import 'package:idena_lib_dart/model/response/contract/contract_estimate_deploy_response.dart';

// Project imports:
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/bus/events.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/authentication_method.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/smartContracts/multiSig_complete_sheet.dart';
import 'package:my_idena/ui/util/routes.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/ui/widgets/one_or_three_address_text.dart';
import 'package:my_idena/ui/widgets/security.dart';
import 'package:my_idena/ui/widgets/sheet_util.dart';
import 'package:my_idena/util/biometrics.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/hapticutil.dart';
import 'package:my_idena/util/numberutil.dart';
import 'package:my_idena/util/sharedprefsutil.dart';

class MultiSigConfirmSheet extends StatefulWidget {
  final String owner;
  final String amountRaw;
  final String scPredictAddress;
  final int minVotes;
  final int maxVotes;
  final ContractEstimateDeployResponse contractEstimateDeployResponse;

  MultiSigConfirmSheet(
      {this.owner,
      this.amountRaw,
      this.scPredictAddress,
      this.minVotes,
      this.maxVotes,
      this.contractEstimateDeployResponse})
      : super();

  _MultiSigConfirmSheetState createState() => _MultiSigConfirmSheetState();
}

class _MultiSigConfirmSheetState extends State<MultiSigConfirmSheet> {
  String amount;
  String destinationAltered;
  bool animationOpen;

  StreamSubscription<AuthenticatedEvent> _authSub;
  StreamSubscription<ContractDeployEvent> _contractDeploySub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((event) {
      if (event.authType == AUTH_EVENT_TYPE.SEND) {
        _doContractDeploy();
      }
    });

    _contractDeploySub = EventTaxiImpl.singleton()
        .registerTo<ContractDeployEvent>()
        .listen((event) {
      //print("listen ContractDeployEvent");
      //print("result : " + event.response);
      if (event.response != "Success") {
        // Send failed
        if (animationOpen) {
          Navigator.of(context).pop();
        }
        UIUtil.showSnackbar(
            AppLocalization.of(context).sendError + " (" + event.response + ")",
            context);
        Navigator.of(context).pop();
      } else {
        StateContainer.of(context).wallet.accountBalance -=
            double.parse(widget.amountRaw);

        Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
        StateContainer.of(context).requestUpdate();
        Sheets.showAppHeightNineSheet(
            context: context,
            closeOnTap: true,
            removeUntilHome: true,
            widget: MultiSigCompleteSheet(
              minVotes: widget.minVotes,
              maxVotes: widget.maxVotes,
              amountRaw: widget.amountRaw,
            ));
      }
    });
  }

  void _destroyBus() {
    if (_authSub != null) {
      _authSub.cancel();
    }
    if (_contractDeploySub != null) {
      _contractDeploySub.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _registerBus();

    this.animationOpen = false;
    // Derive amount from raw amount
    if (NumberUtil.getRawAsUsableString(widget.amountRaw).replaceAll(",", "") ==
        NumberUtil.getRawAsUsableDecimal(widget.amountRaw).toString()) {
      amount = NumberUtil.getRawAsUsableString(widget.amountRaw);
    } else {
      amount = NumberUtil.truncateDecimal(
                  NumberUtil.getRawAsUsableDecimal(widget.amountRaw),
                  digits: 6)
              .toStringAsFixed(6) +
          "~";
    }
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _showSendingAnimation(BuildContext context) {
    animationOpen = true;
    Navigator.of(context).push(AnimationLoadingOverlay(
        AnimationType.SEND,
        StateContainer.of(context).curTheme.animationOverlayStrong,
        StateContainer.of(context).curTheme.animationOverlayMedium,
        onPoppedCallback: () => animationOpen = false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Empty SizedBox
                SizedBox(
                  width: 60,
                  height: 60,
                ),
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
                      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
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
            //The main widget that holds the text fields, "SENDING" and "TO" texts
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 0, bottom: 10),
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Column(children: <Widget>[
                                Stack(children: <Widget>[
                                  // Column for Balance Text, Enter Amount container + Enter Amount Error container
                                  Column(children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 0.0, left: 30, right: 30),
                                      child: Container(
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: '',
                                            children: [
                                              TextSpan(
                                                text:
                                                    AppLocalization.of(context)
                                                        .owner,
                                                style: TextStyle(
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .text60,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Address Text
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: OneOrThreeLineAddressText(
                                          address: StateContainer.of(context)
                                              .wallet
                                              .address,
                                          type: AddressTextType.PRIMARY60),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 0.0, left: 30, right: 30),
                                      child: Container(
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: '',
                                            children: [
                                              TextSpan(
                                                text:
                                                    AppLocalization.of(context)
                                                        .smartContractAddress,
                                                style: TextStyle(
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .text60,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Address Text
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: OneOrThreeLineAddressText(
                                          address: widget.scPredictAddress,
                                          type: AddressTextType.PRIMARY60),
                                    ),
                                    // Container for the amount text
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.105,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.105),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 15),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .backgroundDarkest,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      // Amount text

                                      child: Column(
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: '',
                                              children: [
                                                TextSpan(
                                                  text: "Stake: ",
                                                  style: TextStyle(
                                                    color: StateContainer.of(
                                                            context)
                                                        .curTheme
                                                        .primary,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: widget.amountRaw,
                                                  style: TextStyle(
                                                    color: StateContainer.of(
                                                            context)
                                                        .curTheme
                                                        .primary,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: " iDNA",
                                                  style: TextStyle(
                                                    color: StateContainer.of(
                                                            context)
                                                        .curTheme
                                                        .primary,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w100,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          widget.contractEstimateDeployResponse !=
                                                      null &&
                                                  widget.contractEstimateDeployResponse
                                                          .result !=
                                                      null
                                              ? Text(
                                                  "+ " +
                                                      AppLocalization.of(
                                                              context)
                                                          .gasCost +
                                                      ": " +
                                                      widget
                                                          .contractEstimateDeployResponse
                                                          .result
                                                          .gasCost +
                                                      " iDNA",
                                                  style: TextStyle(
                                                    color: StateContainer.of(
                                                            context)
                                                        .curTheme
                                                        .primary60,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w100,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                )
                                              : SizedBox(),
                                          widget.contractEstimateDeployResponse !=
                                                      null &&
                                                  widget.contractEstimateDeployResponse
                                                          .result !=
                                                      null
                                              ? Text(
                                                  "+ " +
                                                      AppLocalization.of(
                                                              context)
                                                          .txFee +
                                                      ": " +
                                                      widget
                                                          .contractEstimateDeployResponse
                                                          .result
                                                          .txFee +
                                                      " iDNA",
                                                  style: TextStyle(
                                                    color: StateContainer.of(
                                                            context)
                                                        .curTheme
                                                        .primary60,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w100,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 0,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.105,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.105),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            CaseChange.toUpperCase(
                                                AppLocalization.of(context)
                                                    .maxVotesTitle,
                                                context),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .text60,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 25.0,
                                          vertical: 15.0,
                                        ),
                                        margin: EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.105,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.105),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .backgroundDarkest,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Text(
                                          widget.maxVotes.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Roboto',
                                          ),
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 0,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.105,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.105),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            CaseChange.toUpperCase(
                                                AppLocalization.of(context)
                                                    .minVotesTitle,
                                                context),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .text60,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 25.0,
                                          vertical: 15.0,
                                        ),
                                        margin: EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.105,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.105),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .backgroundDarkest,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Text(
                                          widget.minVotes.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Roboto',
                                          ),
                                        )),
                                  ])
                                ]),
                              ]))),
                      //List Top Gradient End
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 30.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                StateContainer.of(context)
                                    .curTheme
                                    .background00,
                                StateContainer.of(context).curTheme.background
                              ],
                              begin: AlignmentDirectional(0.5, 1.0),
                              end: AlignmentDirectional(0.5, -1.0),
                            ),
                          ),
                        ),
                      ), // List Top Gradient End

                      //List Bottom Gradient
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 30.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                StateContainer.of(context)
                                    .curTheme
                                    .background00,
                                StateContainer.of(context).curTheme.background
                              ],
                              begin: AlignmentDirectional(0.5, -1),
                              end: AlignmentDirectional(0.5, 0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),

            //A container for CONFIRM and CANCEL buttons
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 0),
              child: Column(
                children: <Widget>[
                  // A row for CONFIRM Button
                  Row(
                    children: <Widget>[
                      // CONFIRM Button
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          CaseChange.toUpperCase(
                              AppLocalization.of(context)
                                  .lockCoinConfirmatonButton,
                              context),
                          Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                        // Authenticate
                        AuthenticationMethod authMethod =
                            await sl.get<SharedPrefsUtil>().getAuthMethod();
                        bool hasBiometrics =
                            await sl.get<BiometricUtil>().hasBiometrics();
                        if (authMethod.method == AuthMethod.BIOMETRICS &&
                            hasBiometrics) {
                          try {
                            bool authenticated = await sl
                                .get<BiometricUtil>()
                                .authenticateWithBiometrics(
                                    context,
                                    AppLocalization.of(context)
                                        .sendAmountConfirm
                                        .replaceAll("%1", amount));
                            if (authenticated) {
                              sl.get<HapticUtil>().fingerprintSucess();
                              EventTaxiImpl.singleton().fire(
                                  AuthenticatedEvent(AUTH_EVENT_TYPE.SEND));
                            }
                          } catch (e) {
                            await authenticateWithPin();
                          }
                        } else {
                          await authenticateWithPin();
                        }
                      })
                    ],
                  ),
                  // A row for CANCEL Button
                  Row(
                    children: <Widget>[
                      // CANCEL Button
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY_OUTLINE,
                          CaseChange.toUpperCase(
                              AppLocalization.of(context).cancel, context),
                          Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> _doContractDeploy() async {
    try {
      _showSendingAnimation(context);

      //print("contract deploy tx");
      sl.get<SmartContractService>().contractDeployMultiSig(
          StateContainer.of(context).wallet.address,
          widget.maxVotes,
          widget.minVotes,
          double.tryParse(widget.amountRaw),
          double.tryParse(
                  widget.contractEstimateDeployResponse.result.gasCost) +
              double.tryParse(
                  widget.contractEstimateDeployResponse.result.txFee));
    } catch (e) {
      // Deploy failed
      //print("deploy failed" + e.toString());
      EventTaxiImpl.singleton()
          .fire(ContractDeployEvent(response: e.toString()));
    }
  }

  Future<void> authenticateWithPin() async {
    // PIN Authentication
    String expectedPin = await sl.get<Vault>().getPin();
    bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new PinScreen(
        PinOverlayType.ENTER_PIN,
        expectedPin: expectedPin,
        description: AppLocalization.of(context).scLockAmountConfirmPin,
      );
    }));
    //print("authenticateWithPin - auth : " + auth.toString());
    if (auth != null && auth) {
      await Future.delayed(Duration(milliseconds: 200));
      //print("authenticateWithPin - fire AuthenticatedEvent");
      EventTaxiImpl.singleton().fire(AuthenticatedEvent(AUTH_EVENT_TYPE.SEND));
    }
  }
}
