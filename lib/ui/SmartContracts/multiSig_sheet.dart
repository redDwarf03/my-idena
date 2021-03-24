// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/response/contract/contract_estimate_deploy_response.dart';
import 'package:my_idena/factory/smart_contract_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/smartContracts/multiSig_confirm_sheet.dart';
import 'package:my_idena/ui/widgets/app_text_field.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/one_or_three_address_text.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/sheet_util.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/sharedprefsutil.dart';

class MultiSigSheet extends StatefulWidget {
  final String address;

  MultiSigSheet({this.address}) : super();

  _MultiSigSheetState createState() => _MultiSigSheetState();
}

enum AddressStyle { TEXT60, TEXT90, PRIMARY }

class _MultiSigSheetState extends State<MultiSigSheet> {
  final Logger log = sl.get<Logger>();

  FocusNode _multiSigMinVotesFocusNode;
  TextEditingController _multiSigMinVotesController;
  FocusNode _multiSigMaxVotesFocusNode;
  TextEditingController _multiSigMaxVotesController;

  String _minVotesHint = "";
  String _maxVotesHint = "";
  String _minVotesValidationText = "";
  String _maxVotesValidationText = "";
  bool animationOpen;
  // Local currency mode/fiat conversion
  bool _localCurrencyMode = false;
  bool validRequest = true;
  String scPredictAddress = "";
  ContractEstimateDeployResponse contractEstimateDeployResponse;
  double smartContractAmountStake = 0;

  Future<ContractEstimateDeployResponse> estimateContract() async {
    return await sl.get<SmartContractService>().contractEstimateDeployMultiSig(
        StateContainer.of(context).wallet.address,
        int.tryParse(_multiSigMaxVotesController.text),
        int.tryParse(_multiSigMinVotesController.text),
        smartContractAmountStake);
  }

  void loadSCPredictAddress() async {
    scPredictAddress = await sl
        .get<SmartContractService>()
        .getPredictSmartContractAddress(widget.address);
    setState(() {});
  }

  void loadSmartContractAmountStake() async {
    smartContractAmountStake =
        await sl.get<SmartContractService>().getSmartContractStake();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    loadSCPredictAddress();
    loadSmartContractAmountStake();

    _multiSigMinVotesFocusNode = FocusNode();
    _multiSigMaxVotesFocusNode = FocusNode();
    _multiSigMinVotesController = TextEditingController();
    _multiSigMaxVotesController = TextEditingController();
    this.animationOpen = false;

    _multiSigMinVotesFocusNode.addListener(() {
      if (_multiSigMinVotesFocusNode.hasFocus) {
        setState(() {
          _minVotesHint = null;
        });
      } else {
        setState(() {
          _minVotesHint = "";
        });
      }
    });
    _multiSigMaxVotesFocusNode.addListener(() {
      if (_multiSigMaxVotesFocusNode.hasFocus) {
        setState(() {
          _minVotesHint = null;
        });
      } else {
        setState(() {
          _minVotesHint = "";
        });
      }
    });
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

            Container(
              margin: EdgeInsets.only(top: 0.0, left: 30, right: 30),
              child: Container(
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                        text: AppLocalization.of(context).owner,
                        style: TextStyle(
                          color: StateContainer.of(context).curTheme.text60,
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
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: OneOrThreeLineAddressText(
                  address: StateContainer.of(context).wallet.address,
                  type: AddressTextType.PRIMARY60),
            ),
            Container(
              margin: EdgeInsets.only(top: 0.0, left: 30, right: 30),
              child: Container(
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                        text: AppLocalization.of(context).smartContractAddress,
                        style: TextStyle(
                          color: StateContainer.of(context).curTheme.text60,
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
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: OneOrThreeLineAddressText(
                  address: scPredictAddress, type: AddressTextType.PRIMARY60),
            ),

            // A main container that holds everything
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 0, bottom: 10),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Clear focus of our fields when tapped in this empty space
                        _multiSigMaxVotesFocusNode.unfocus();
                        _multiSigMinVotesFocusNode.unfocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: SizedBox.expand(),
                        constraints: BoxConstraints.expand(),
                      ),
                    ),
                    // A column for Enter Amount, Error containers and the pop up list
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 30, bottom: bottom + 80, left: 20, right: 30),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                // Column for Balance Text, Enter Amount container + Enter Amount Error container
                                Column(
                                  children: <Widget>[
                                    // Balance Text
                                    FutureBuilder(
                                      future: sl
                                          .get<SharedPrefsUtil>()
                                          .getPriceConversion(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data != null &&
                                            snapshot.data !=
                                                PriceConversion.HIDDEN) {
                                          return Container(
                                            child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                text: '',
                                                children: [
                                                  TextSpan(
                                                    text: "(",
                                                    style: TextStyle(
                                                      color: StateContainer.of(
                                                              context)
                                                          .curTheme
                                                          .primary60,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: _localCurrencyMode
                                                        ? StateContainer.of(
                                                                context)
                                                            .wallet
                                                            .getLocalCurrencyPrice(
                                                                StateContainer.of(
                                                                        context)
                                                                    .curCurrency,
                                                                locale: StateContainer.of(
                                                                        context)
                                                                    .currencyLocale)
                                                        : StateContainer.of(
                                                                context)
                                                            .wallet
                                                            .getAccountBalanceDisplay(),
                                                    style: TextStyle(
                                                      color: StateContainer.of(
                                                              context)
                                                          .curTheme
                                                          .primary60,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: _localCurrencyMode
                                                        ? ")"
                                                        : " iDNA)",
                                                    style: TextStyle(
                                                      color: StateContainer.of(
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
                                          );
                                        }
                                        return Container(
                                          child: Text(
                                            "*******",
                                            style: TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w100,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        child: getEnterMaxVotesContainer()),
                                    Container(
                                      alignment: AlignmentDirectional(0, 0),
                                      margin: EdgeInsets.only(top: 3),
                                      child: Text(_maxVotesValidationText,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        child: getEnterMinVotesContainer()),
                                    Container(
                                      alignment: AlignmentDirectional(0, 0),
                                      margin: EdgeInsets.only(top: 3),
                                      child: Text(_minVotesValidationText,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Text(
                                        AppLocalization.of(context)
                                                .smartContractAmountStake +
                                            ": " +
                                            smartContractAmountStake
                                                .toStringAsFixed(5) +
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
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //List Top Gradient End
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 30.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              StateContainer.of(context).curTheme.background00,
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
                              StateContainer.of(context).curTheme.background00,
                              StateContainer.of(context).curTheme.background
                            ],
                            begin: AlignmentDirectional(0.5, -1),
                            end: AlignmentDirectional(0.5, 0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //A column "Lock" buttons
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context).multiSigEstimationButton,
                          Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                        validRequest = _validateRequest();
                        if (validRequest) {
                          contractEstimateDeployResponse =
                              await estimateContract();
                          if (contractEstimateDeployResponse != null &&
                              contractEstimateDeployResponse.error != null) {
                            UIUtil.showSnackbar(
                                AppLocalization.of(context)
                                        .contractDeployError +
                                    " (" +
                                    contractEstimateDeployResponse
                                        .error.message +
                                    ")",
                                context);
                            return;
                          }
                          Sheets.showAppHeightNineSheet(
                              context: context,
                              widget: MultiSigConfirmSheet(
                                  contractEstimateDeployResponse:
                                      contractEstimateDeployResponse,
                                  scPredictAddress: scPredictAddress,
                                  owner:
                                      StateContainer.of(context).wallet.address,
                                  minVotes: int.tryParse(
                                      _multiSigMinVotesController.text),
                                  maxVotes: int.tryParse(
                                      _multiSigMaxVotesController.text),
                                  amountRaw:
                                      smartContractAmountStake.toString()));
                        }
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  /// Validate form data to see if valid
  /// @returns true if valid, false otherwise
  bool _validateRequest() {
    bool isValid = true;
    _multiSigMinVotesFocusNode.unfocus();
    _multiSigMaxVotesFocusNode.unfocus();

    int minVotes = int.tryParse(_multiSigMinVotesController.text);
    if (_multiSigMinVotesController.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _minVotesValidationText = AppLocalization.of(context).minVotesMissing;
      });
    } else {
      if (minVotes == null) {
        isValid = false;
        setState(() {
          _minVotesValidationText =
              AppLocalization.of(context).minVotesNumericError;
        });
      }
    }
    int maxVotes = int.tryParse(_multiSigMaxVotesController.text);
    if (_multiSigMaxVotesController.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _maxVotesValidationText = AppLocalization.of(context).maxVotesMissing;
      });
    } else {
      if (maxVotes == null) {
        isValid = false;
        setState(() {
          _maxVotesValidationText =
              AppLocalization.of(context).maxVotesNumericError;
        });
      } else {
        if (maxVotes > 32) {
          isValid = false;
          setState(() {
            _maxVotesValidationText =
                AppLocalization.of(context).maxVotes32Error;
          });
        }
        if (maxVotes != null && minVotes != null && maxVotes < minVotes) {
          isValid = false;
          setState(() {
            _maxVotesValidationText =
                AppLocalization.of(context).maxVSminVotesError;
          });
        }
      }
    }
    return isValid;
  }

  getEnterMaxVotesContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterMaxVotesMultiSig,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w100,
                fontFamily: 'Roboto',
                color: StateContainer.of(context).curTheme.text60,
              ),
            ),
          ],
        ),
        AppTextField(
          focusNode: _multiSigMaxVotesFocusNode,
          controller: _multiSigMaxVotesController,
          cursorColor: StateContainer.of(context).curTheme.primary,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: StateContainer.of(context).curTheme.primary,
            fontFamily: 'Roboto',
          ),
          inputFormatters: [LengthLimitingTextInputFormatter(2)],
          onChanged: (text) {
            // Always reset the error message to be less annoying
            setState(() {
              _maxVotesValidationText = "";
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          hintText: _maxVotesHint == null
              ? ""
              : AppLocalization.of(context).enterMaxVotesMultiSig,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: false),
          textAlign: TextAlign.center,
          onSubmitted: (text) {
            FocusScope.of(context).unfocus();
          },
        )
      ],
    );
  }

  getEnterMinVotesContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterMinVotesMultiSig,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w100,
                fontFamily: 'Roboto',
                color: StateContainer.of(context).curTheme.text60,
              ),
            ),
          ],
        ),
        AppTextField(
          focusNode: _multiSigMinVotesFocusNode,
          controller: _multiSigMinVotesController,
          cursorColor: StateContainer.of(context).curTheme.primary,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: StateContainer.of(context).curTheme.primary,
            fontFamily: 'Roboto',
          ),
          inputFormatters: [LengthLimitingTextInputFormatter(2)],
          onChanged: (text) {
            // Always reset the error message to be less annoying
            setState(() {
              _minVotesValidationText = "";
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          hintText: _minVotesHint == null
              ? ""
              : AppLocalization.of(context).enterMinVotesMultiSig,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: false),
          textAlign: TextAlign.center,
          onSubmitted: (text) {
            FocusScope.of(context).unfocus();
          },
        )
      ],
    );
  }
}
