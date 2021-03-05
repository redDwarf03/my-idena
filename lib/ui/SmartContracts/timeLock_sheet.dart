import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/response/contract/contract_estimate_deploy_response.dart';
import 'package:my_idena/factory/smart_contract_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/smartContracts/timeLock_confirm_sheet.dart';
import 'package:my_idena/ui/widgets/app_text_field.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/one_or_three_address_text.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/sheet_util.dart';
import 'package:my_idena/util/caseconverter.dart';

class TimeLockSheet extends StatefulWidget {
  final String address;

  TimeLockSheet({this.address}) : super();

  _TimeLockSheetState createState() => _TimeLockSheetState();
}

class _TimeLockSheetState extends State<TimeLockSheet> {
  final Logger log = sl.get<Logger>();

  FocusNode _timeLockDateFocusNode;
  TextEditingController _timeLockDateController;

  String _dateHint = "";
  String _dateValidationText = "";
  bool animationOpen;
  // Local currency mode/fiat conversion
  bool validRequest = true;
  DateTime _timeLockDate;
  String scPredictAddress = "";
  ContractEstimateDeployResponse contractEstimateDeployResponse;
  double smartContractAmountStake = 0;

  Future<ContractEstimateDeployResponse> estimateContract() async {
    return await sl.get<SmartContractService>().contractEstimateDeployTimeLock(
        StateContainer.of(context).wallet.address,
        _timeLockDate.millisecondsSinceEpoch ~/ 1000,
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

    _timeLockDateFocusNode = FocusNode();
    _timeLockDateController = TextEditingController();
    this.animationOpen = false;

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

            // A main container that holds everything
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 0, bottom: 10),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Clear focus of our fields when tapped in this empty space
                        _timeLockDateFocusNode.unfocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: SizedBox.expand(),
                        constraints: BoxConstraints.expand(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0, bottom: bottom + 140),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
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
                                                          .primary,
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
                                                          .primary,
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

                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: OneOrThreeLineAddressText(
                                          address: scPredictAddress,
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
                                                        .yourBalance,
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          text: '',
                                          children: [
                                            TextSpan(
                                              text: StateContainer.of(context)
                                                      .wallet
                                                      .getAccountBalanceDisplay() +
                                                  " iDNA",
                                              style: TextStyle(
                                                color:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .text60,
                                                fontSize: 14.0,
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    getEnterDateContainer(),
                                    SizedBox(height: 20),
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
                                amountRaw: smartContractAmountStake.toString(),
                                contractEstimateDeployResponse:
                                    contractEstimateDeployResponse,
                                scPredictAddress: scPredictAddress,
                                owner: widget.address,
                                dateUnlock: _timeLockDate,
                              ));
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

  bool _validateRequest() {
    bool isValid = true;
    _timeLockDateFocusNode.unfocus();
    if (_timeLockDateController.text.trim().isEmpty || _timeLockDate == null) {
      isValid = false;
      setState(() {
        _dateValidationText = AppLocalization.of(context).dateUnlockTimeMissing;
      });
    }
    return isValid;
  }

  getEnterDateContainer() {
    return Column(
      children: [
        AppTextField(
          focusNode: _timeLockDateFocusNode,
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
            setState(() {
              _dateValidationText = "";
            });
          },
          suffixButton: TextFieldButton(
              icon: AppIcons.timer,
              onPressed: () {
                _dateValidationText = "";
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
        Container(
          alignment: AlignmentDirectional(0, 0),
          margin: EdgeInsets.only(top: 3),
          child: Text(_dateValidationText,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              )),
        ),
      ],
    );
  }
}
