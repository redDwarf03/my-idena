import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:decimal/decimal.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/available_currency.dart';
import 'package:my_idena/network/model/response/contract/contract_estimate_deploy_response.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service/smart_contract_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/SmartContracts/timeLock_confirm_sheet.dart';
import 'package:my_idena/ui/widgets/app_text_field.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/one_or_three_address_text.dart';
import 'package:my_idena/ui/util/formatters.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/sheet_util.dart';
import 'package:my_idena/util/numberutil.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/sharedprefsutil.dart';

class TimeLockSheet extends StatefulWidget {
  final AvailableCurrency localCurrency;
  final String quickSendAmount;
  final String address;

  TimeLockSheet({@required this.localCurrency, this.quickSendAmount, this.address}) : super();

  _TimeLockSheetState createState() => _TimeLockSheetState();
}

enum AddressStyle { TEXT60, TEXT90, PRIMARY }

class _TimeLockSheetState extends State<TimeLockSheet> {
  final Logger log = sl.get<Logger>();

  FocusNode _timeLockDateFocusNode;
  TextEditingController _timeLockDateController;
  FocusNode _timeLockAmountFocusNode;
  TextEditingController _timeLockAmountController;

  String _amountHint = "";
  String _dateHint = "";
  String _amountValidationText = "";
  String _dateValidationText = "";
  String quickSendAmount;
  bool animationOpen;
  // Local currency mode/fiat conversion
  bool _localCurrencyMode = false;
  String _lastLocalCurrencyAmount = "";
  String _lastCryptoAmount = "";
  NumberFormat _localCurrencyFormat;
  bool isTokenToSendSwitched = false;
  String _rawAmount;
  bool validRequest = true;
  DateTime _timeLockDate;
  String scPredictAddress = "";
  ContractEstimateDeployResponse contractEstimateDeployResponse;

  Future<ContractEstimateDeployResponse> estimateContract() async {
    return await sl.get<SmartContractService>().contractEstimateDeployTimeLock(
        StateContainer.of(context).wallet.address,
        _timeLockDate.millisecondsSinceEpoch ~/ 1000,
        _localCurrencyMode
            ? double.tryParse(
                NumberUtil.getAmountAsRaw(_convertLocalCurrencyToCrypto()))
            : _rawAmount == null
                ? double.tryParse(
                    NumberUtil.getAmountAsRaw(_timeLockAmountController.text))
                : double.tryParse(_rawAmount));
  }

  void loadSCPredictAddress() async {
    scPredictAddress = await sl
        .get<SmartContractService>()
        .getPredictSmartContractAddress(
            widget.address);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    loadSCPredictAddress();

    _timeLockAmountFocusNode = FocusNode();
    _timeLockDateFocusNode = FocusNode();
    _timeLockAmountController = TextEditingController();
    _timeLockDateController = TextEditingController();
    quickSendAmount = widget.quickSendAmount;
    this.animationOpen = false;

    // On amount focus change
    _timeLockAmountFocusNode.addListener(() {
      if (_timeLockAmountFocusNode.hasFocus) {
        if (_rawAmount != null) {
          setState(() {
            _timeLockAmountController.text =
                NumberUtil.getRawAsUsableString(_rawAmount).replaceAll(",", "");
            _rawAmount = null;
          });
        }
        if (quickSendAmount != null) {
          _timeLockAmountController.text = "";
          setState(() {
            quickSendAmount = null;
          });
        }
        setState(() {
          _amountHint = null;
        });
      } else {
        setState(() {
          _amountHint = "";
        });
      }
    });
    _timeLockDateFocusNode.addListener(() {
      if (_timeLockDateFocusNode.hasFocus) {
        setState(() {
          _dateHint = null;
        });
      } else {
        setState(() {
          _dateHint = "";
        });
      }
    });

    // Set initial currency format
    _localCurrencyFormat = NumberFormat.currency(
        locale: widget.localCurrency.getLocale().toString(),
        symbol: widget.localCurrency.getCurrencySymbol());
    // Set quick send amount
    if (quickSendAmount != null) {
      _timeLockAmountController.text =
          NumberUtil.getRawAsUsableString(quickSendAmount).replaceAll(",", "");
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
                        _timeLockAmountFocusNode.unfocus();
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
                        padding: EdgeInsets.only(top: 30, bottom: bottom + 80),
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
                                    getEnterAmountContainer(),
                                    Container(
                                      alignment: AlignmentDirectional(0, 0),
                                      margin: EdgeInsets.only(top: 3),
                                      child: Text(_amountValidationText,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    getEnterDateContainer(),
                                    SizedBox(height: 20),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Text(
                                        "+ " +
                                            AppLocalization.of(context).fees +
                                            ": " +
                                            sl
                                                .get<AppService>()
                                                .getFeesEstimation()
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
                          AppLocalization.of(context).lockCoinEstimationButton,
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
                              widget: TimeLockConfirmSheet(
                                  contractEstimateDeployResponse:
                                      contractEstimateDeployResponse,
                                  scPredictAddress: scPredictAddress,
                                  owner:
                                      StateContainer.of(context).wallet.address,
                                  dateUnlock: _timeLockDate,
                                  amountRaw: _localCurrencyMode
                                      ? NumberUtil.getAmountAsRaw(
                                          _convertLocalCurrencyToCrypto())
                                      : _rawAmount == null
                                          ? NumberUtil.getAmountAsRaw(
                                              _timeLockAmountController.text)
                                          : _rawAmount,
                                  maxSend: _isMaxSend(),
                                  localCurrency: _localCurrencyMode
                                      ? _timeLockAmountController.text
                                      : null));
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

  String _convertLocalCurrencyToCrypto() {
    String convertedAmt = _timeLockAmountController.text.replaceAll(",", ".");
    convertedAmt = NumberUtil.sanitizeNumber(convertedAmt);
    if (convertedAmt.isEmpty) {
      return "";
    }
    Decimal valueLocal = Decimal.parse(convertedAmt);
    Decimal conversion = Decimal.parse(
        StateContainer.of(context).wallet.localCurrencyConversion);
    return NumberUtil.truncateDecimal(valueLocal / conversion).toString();
  }

  String _convertCryptoToLocalCurrency() {
    String convertedAmt = NumberUtil.sanitizeNumber(
        _timeLockAmountController.text,
        maxDecimalDigits: 2);
    if (convertedAmt.isEmpty) {
      return "";
    }
    Decimal valueCrypto = Decimal.parse(convertedAmt);
    Decimal conversion = Decimal.parse(
        StateContainer.of(context).wallet.localCurrencyConversion);
    convertedAmt =
        NumberUtil.truncateDecimal(valueCrypto * conversion, digits: 2)
            .toString();
    convertedAmt =
        convertedAmt.replaceAll(".", _localCurrencyFormat.symbols.DECIMAL_SEP);
    convertedAmt = _localCurrencyFormat.currencySymbol + convertedAmt;
    return convertedAmt;
  }

  String _convertFeesToLocalCurrency() {
    String convertedAmt = NumberUtil.sanitizeNumber(
        sl.get<AppService>().getFeesEstimation().toStringAsFixed(5),
        maxDecimalDigits: 5);
    if (convertedAmt.isEmpty) {
      return "";
    }
    Decimal valueCrypto = Decimal.parse(convertedAmt);
    Decimal conversion = Decimal.parse(
        StateContainer.of(context).wallet.localCurrencyConversion);
    convertedAmt =
        NumberUtil.truncateDecimal(valueCrypto * conversion, digits: 5)
            .toString();
    convertedAmt =
        convertedAmt.replaceAll(".", _localCurrencyFormat.symbols.DECIMAL_SEP);
    convertedAmt = _localCurrencyFormat.currencySymbol + convertedAmt;
    return convertedAmt;
  }

  // Determine if this is a max send or not by comparing balances
  bool _isMaxSend() {
    // Sanitize commas
    if (_timeLockAmountController.text.isEmpty) {
      return false;
    }
    try {
      String textField = _timeLockAmountController.text;

      String balance;
      if (_localCurrencyMode) {
        balance = StateContainer.of(context).wallet.getLocalCurrencyPrice(
            StateContainer.of(context).curCurrency,
            locale: StateContainer.of(context).currencyLocale);
      } else {
        balance = StateContainer.of(context)
            .wallet
            .getAccountBalanceDisplay()
            .replaceAll(r",", "");
      }
      // Convert to Integer representations
      int textFieldInt;
      int balanceInt;
      if (_localCurrencyMode) {
        // Sanitize currency values into plain integer representations
        textField = textField.replaceAll(",", ".");
        String sanitizedTextField = NumberUtil.sanitizeNumber(textField);
        balance =
            balance.replaceAll(_localCurrencyFormat.symbols.GROUP_SEP, "");
        balance = balance.replaceAll(",", ".");
        String sanitizedBalance = NumberUtil.sanitizeNumber(balance);
        textFieldInt = (Decimal.parse(sanitizedTextField) *
                Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits)))
            .toInt();
        balanceInt = (Decimal.parse(sanitizedBalance) *
                Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits)))
            .toInt();
      } else {
        textField = textField.replaceAll(",", "");
        textFieldInt = (Decimal.parse(textField) *
                Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits)))
            .toInt();
        balanceInt = (Decimal.parse(balance) *
                Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits)))
            .toInt();
      }

      int estimationFeesInt =
          (Decimal.parse(sl.get<AppService>().getFeesEstimation().toString()) *
                  Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits)))
              .toInt();

      return textFieldInt + estimationFeesInt == balanceInt;
    } catch (e) {
      return false;
    }
  }

  void toggleLocalCurrency() {
    // Keep a cache of previous amounts because, it's kinda nice to see approx what cryptocurrency is worth
    // this way you can tap button and tap back and not end up with X.9993451 cryptocurrency
    if (_localCurrencyMode) {
      // Switching to crypto-mode
      String cryptoAmountStr;
      // Check out previous state
      if (_timeLockAmountController.text == _lastLocalCurrencyAmount) {
        cryptoAmountStr = _lastCryptoAmount;
      } else {
        _lastLocalCurrencyAmount = _timeLockAmountController.text;
        _lastCryptoAmount = _convertLocalCurrencyToCrypto();
        cryptoAmountStr = _lastCryptoAmount;
      }
      setState(() {
        _localCurrencyMode = false;
      });
      Future.delayed(Duration(milliseconds: 50), () {
        _timeLockAmountController.text = cryptoAmountStr;
        _timeLockAmountController.selection = TextSelection.fromPosition(
            TextPosition(offset: cryptoAmountStr.length));
      });
    } else {
      // Switching to local-currency mode
      String localAmountStr;
      // Check our previous state
      if (_timeLockAmountController.text == _lastCryptoAmount) {
        localAmountStr = _lastLocalCurrencyAmount;
      } else {
        _lastCryptoAmount = _timeLockAmountController.text;
        _lastLocalCurrencyAmount = _convertCryptoToLocalCurrency();
        localAmountStr = _lastLocalCurrencyAmount;
      }
      setState(() {
        _localCurrencyMode = true;
      });
      Future.delayed(Duration(milliseconds: 50), () {
        _timeLockAmountController.text = localAmountStr;
        _timeLockAmountController.selection = TextSelection.fromPosition(
            TextPosition(offset: localAmountStr.length));
      });
    }
  }

  /// Validate form data to see if valid
  /// @returns true if valid, false otherwise
  bool _validateRequest() {
    bool isValid = true;
    _timeLockAmountFocusNode.unfocus();
    _timeLockDateFocusNode.unfocus();
    // Validate amount
    if (_timeLockAmountController.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _amountValidationText = AppLocalization.of(context).amountMissing;
      });
    } else {
      // Estimation of fees
      double estimationFees = sl.get<AppService>().getFeesEstimation();

      String amount = _localCurrencyMode
          ? _convertLocalCurrencyToCrypto()
          : _rawAmount == null
              ? _timeLockAmountController.text
              : NumberUtil.getRawAsUsableString(_rawAmount);
      double balanceRaw = StateContainer.of(context).wallet.accountBalance;
      double sendAmount = double.tryParse(amount);
      if (sendAmount == null) {
        isValid = false;
        setState(() {
          _amountValidationText = AppLocalization.of(context).amountMissing;
        });
      } else if (sendAmount + estimationFees > balanceRaw) {
        isValid = false;
        setState(() {
          _amountValidationText =
              AppLocalization.of(context).insufficientBalance;
        });
      }
    }
    if (_timeLockDateController.text.trim().isEmpty || _timeLockDate == null) {
      isValid = false;
      setState(() {
        _dateValidationText = AppLocalization.of(context).dateUnlockTimeMissing;
      });
    }
    return isValid;
  }

  //************ Enter Amount Container Method ************//
  //*******************************************************//
  getEnterAmountContainer() {
    return AppTextField(
      focusNode: _timeLockAmountFocusNode,
      controller: _timeLockAmountController,
      topMargin: 30,
      cursorColor: StateContainer.of(context).curTheme.primary,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: StateContainer.of(context).curTheme.primary,
        fontFamily: 'Roboto',
      ),
      inputFormatters: _rawAmount == null
          ? [
              LengthLimitingTextInputFormatter(16),
              _localCurrencyMode
                  ? CurrencyFormatter(
                      decimalSeparator:
                          _localCurrencyFormat.symbols.DECIMAL_SEP,
                      commaSeparator: _localCurrencyFormat.symbols.GROUP_SEP,
                      maxDecimalDigits: 8)
                  : CurrencyFormatter(
                      maxDecimalDigits: NumberUtil.maxDecimalDigits),
              LocalCurrencyFormatter(
                  active: _localCurrencyMode,
                  currencyFormat: _localCurrencyFormat)
            ]
          : [LengthLimitingTextInputFormatter(16)],
      onChanged: (text) {
        // Always reset the error message to be less annoying
        setState(() {
          _amountValidationText = "";
          // Reset the raw amount
          _rawAmount = null;
        });
      },
      textInputAction: TextInputAction.next,
      maxLines: null,
      autocorrect: false,
      hintText:
          _amountHint == null ? "" : AppLocalization.of(context).enterAmount,
      suffixButton: TextFieldButton(
        icon: AppIcons.max,
        onPressed: () {
          setState(() {
            _amountValidationText = "";
            // Reset the raw amount
            _rawAmount = null;
          });
          if (_isMaxSend()) {
            return;
          }

          if (!_localCurrencyMode) {
            double estimationFees = sl.get<AppService>().getFeesEstimation();
            _timeLockAmountController.text = StateContainer.of(context)
                .wallet
                .getAccountBalanceMoinsFeesDisplay(estimationFees)
                .replaceAll(r",", "");
          } else {
            String feeString = _convertFeesToLocalCurrency();
            feeString = feeString.replaceAll(
                _localCurrencyFormat.symbols.GROUP_SEP, "");
            feeString = feeString.replaceAll(
                _localCurrencyFormat.symbols.DECIMAL_SEP, ".");
            feeString = NumberUtil.sanitizeNumber(feeString)
                .replaceAll(".", _localCurrencyFormat.symbols.DECIMAL_SEP);

            String localAmount = StateContainer.of(context)
                .wallet
                .getLocalCurrencyPriceMoinsFees(
                    StateContainer.of(context).curCurrency,
                    double.tryParse(feeString),
                    locale: StateContainer.of(context).currencyLocale);
            localAmount = localAmount.replaceAll(
                _localCurrencyFormat.symbols.GROUP_SEP, "");
            localAmount = localAmount.replaceAll(
                _localCurrencyFormat.symbols.DECIMAL_SEP, ".");
            localAmount = NumberUtil.sanitizeNumber(localAmount)
                .replaceAll(".", _localCurrencyFormat.symbols.DECIMAL_SEP);
            _timeLockAmountController.text =
                _localCurrencyFormat.currencySymbol + localAmount;
          }
        },
      ),
      fadeSuffixOnCondition: true,
      suffixShowFirstCondition: !_isMaxSend(),
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
      textAlign: TextAlign.center,
      onSubmitted: (text) {
        FocusScope.of(context).unfocus();
      },
    );
  } //************ Enter Amount Container Method End ************//
  //*************************************************************//

//************ Enter Date Container Method ************//
  //*******************************************************//
  getEnterDateContainer() {
    return Column(
      children: [
        AppTextField(
          focusNode: FocusNode(),
          controller: _timeLockDateController,
          topMargin: 30,
          cursorColor: StateContainer.of(context).curTheme.primary,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: StateContainer.of(context).curTheme.primary,
            fontFamily: 'Roboto',
          ),
          inputFormatters: [LengthLimitingTextInputFormatter(1)],
          onChanged: (text) {
            // Always reset the error message to be less annoying
            setState(() {
              _dateValidationText = "";
            });
          },
          suffixButton: TextFieldButton(
              icon: AppIcons.timer,
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                  _timeLockDateController.text =
                      '${date.year}/${date.month.toString().padLeft(2, "0")}/${date.day.toString().padLeft(2, "0")} - ${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}';

                  setState(() {
                    _timeLockDate = date;
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              }),
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          hintText: _dateHint == null
              ? ""
              : AppLocalization.of(context).enterDateTimeLock,
          fadeSuffixOnCondition: true,
          suffixShowFirstCondition: true,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          textAlign: TextAlign.center,
          onSubmitted: (text) {
            FocusScope.of(context).unfocus();
          },
        ),
        // ******* Enter Date Error Container ******* //
        Container(
          alignment: AlignmentDirectional(0, 0),
          margin: EdgeInsets.only(top: 3),
          child: Text(_dateValidationText,
              style: TextStyle(
                fontSize: 14.0,
                color: StateContainer.of(context).curTheme.primary,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              )),
        ),
        // ******* Enter Date Error Container End ******* //
      ],
    );
  } //************ Enter Date Container Method End ************//
  //*************************************************************//
}
