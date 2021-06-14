// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:idena_lib_dart/factory/smart_contract_service.dart';
import 'package:idena_lib_dart/model/address.dart';
import 'package:idena_lib_dart/model/response/contract/contract_terminate_response.dart';
import 'package:logger/logger.dart';

// Project imports:
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/db/contact.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/util/routes.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/app_text_field.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/ui/widgets/one_or_three_address_text.dart';
import 'package:my_idena/util/caseconverter.dart';

class SmartContractTerminateSheet extends StatefulWidget {
  final String title;
  final Contact contact;
  final String address;
  final String contractAddress;
  final String nodeAddress;
  final String contractStake;

  SmartContractTerminateSheet(
      {this.title,
      this.contact,
      this.address,
      this.contractAddress,
      this.contractStake,
      this.nodeAddress})
      : super();

  _SmartContractTerminateSheetState createState() =>
      _SmartContractTerminateSheetState();
}

enum AddressStyle { TEXT60, TEXT90, PRIMARY }

class _SmartContractTerminateSheetState
    extends State<SmartContractTerminateSheet> {
  final Logger log = sl.get<Logger>();

  FocusNode _blockAddressFocusNode;
  TextEditingController _blockAddressController;

  AddressStyle _blockAddressStyle;
  String _addressHint = "";
  String _addressValidationText = "";
  List<Contact> _contacts;

// Used to replace address textfield with colorized TextSpan
  bool _addressValidAndUnfocused = false;
  // Set to true when a contact is being entered
  bool _isContact = false;
  // Buttons States (Used because we hide the buttons under certain conditions)
  bool _pasteButtonVisible = true;
  bool _showContactButton = true;
  bool validRequest = true;

  bool animationOpen;

  @override
  void initState() {
    super.initState();

    this.animationOpen = false;

    _blockAddressFocusNode = FocusNode();
    _blockAddressController = TextEditingController();
    _blockAddressStyle = AddressStyle.TEXT60;
    _contacts = List();
    if (widget.contact != null) {
      // Setup initial state for contact pre-filled
      _blockAddressController.text = widget.contact.name;
      _isContact = true;
      _showContactButton = false;
      _pasteButtonVisible = false;
      _blockAddressStyle = AddressStyle.PRIMARY;
    } else if (widget.address != null) {
      // Setup initial state with prefilled address
      _blockAddressController.text = widget.address;
      _showContactButton = false;
      _pasteButtonVisible = false;
      _blockAddressStyle = AddressStyle.TEXT90;
      _addressValidAndUnfocused = true;
    }

    // On address focus change
    _blockAddressFocusNode.addListener(() {
      if (_blockAddressFocusNode.hasFocus) {
        setState(() {
          _addressHint = null;
          //_addressValidAndUnfocused = false;
        });
        _blockAddressController.selection = TextSelection.fromPosition(
            TextPosition(offset: _blockAddressController.text.length));
        if (_blockAddressController.text.startsWith("@")) {
          sl
              .get<DBHelper>()
              .getContactsWithNameLike(_blockAddressController.text)
              .then((contactList) {
            setState(() {
              _contacts = contactList;
            });
          });
        }
      } else {
        setState(() {
          _addressHint = "";
          _contacts = [];
          if (Address(_blockAddressController.text).isValid()) {
            //_addressValidAndUnfocused = true;
          }
        });
        if (_blockAddressController.text.trim() == "@") {
          _blockAddressController.text = "";
          setState(() {
            _showContactButton = true;
          });
        }
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
                            CaseChange.toUpperCase(widget.title, context),
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
                        _blockAddressFocusNode.unfocus();
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
                                          address: widget.contractAddress,
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
                                                text: AppLocalization.of(
                                                        context)
                                                    .smartContractAmountStake,
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
                                              text: widget.contractStake +
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
                                    SizedBox(height: 10),
                                    getEnterAddressContainer(),
                                    Container(
                                      alignment: AlignmentDirectional(0, 0),
                                      margin: EdgeInsets.only(top: 3),
                                      child: Text(_addressValidationText,
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
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.105,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.105),
                                      alignment: Alignment.topCenter,
                                      constraints: BoxConstraints(
                                          maxHeight: 174, minHeight: 0),
                                      // ********************************************* //
                                      // ********* The pop-up Contacts List ********* //
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .backgroundDarkest,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            margin: EdgeInsets.only(bottom: 0),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.only(
                                                  bottom: 0, top: 0),
                                              itemCount: _contacts.length,
                                              itemBuilder: (context, index) {
                                                return _buildContactItem(
                                                    _contacts[index]);
                                              },
                                            ), // ********* The pop-up Contacts List End ********* //
                                            // ************************************************** //
                                          ),
                                        ),
                                      ),
                                    ),
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

            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context).scTerminateButton,
                          Dimens.BUTTON_TOP_DIMENS, onPressed: () {
                        validRequest = _validateRequest();
                        if (_blockAddressController.text.startsWith("@") &&
                            validRequest) {
                          // Need to make sure its a valid contact
                          sl
                              .get<DBHelper>()
                              .getContactWithName(_blockAddressController.text)
                              .then((contact) {
                            if (contact == null) {
                              setState(() {
                                _addressValidationText =
                                    AppLocalization.of(context).contactInvalid;
                              });
                            } else {
                              AppDialogs.showConfirmDialog(
                                  context,
                                  AppLocalization.of(context)
                                      .scTerminateConfirmationTitle,
                                  AppLocalization.of(context)
                                      .scTerminateConfirmationText,
                                  CaseChange.toUpperCase(
                                      AppLocalization.of(context).yesButton,
                                      context), () async {
                                ContractTerminateResponse
                                    contractTerminateResponse = await sl
                                        .get<SmartContractService>()
                                        .contractTerminateTimeLock(
                                            widget.nodeAddress,
                                            widget.contractAddress,
                                            0.25,
                                            contact.address);
                                if (contractTerminateResponse != null &&
                                    contractTerminateResponse.error != null) {
                                  UIUtil.showSnackbar(
                                      AppLocalization.of(context).sendError +
                                          " (" +
                                          contractTerminateResponse
                                              .error.message +
                                          ")",
                                      context);
                                  return;
                                } else {
                                  Navigator.of(context).popUntil(
                                      RouteUtils.withNameLike('/home'));
                                }
                              });
                            }
                          });
                        } else if (validRequest) {
                          AppDialogs.showConfirmDialog(
                              context,
                              AppLocalization.of(context)
                                  .scTerminateConfirmationTitle,
                              AppLocalization.of(context)
                                  .scTerminateConfirmationText,
                              CaseChange.toUpperCase(
                                  AppLocalization.of(context).yesButton,
                                  context), () async {
                            ContractTerminateResponse
                                contractTerminateResponse = await sl
                                    .get<SmartContractService>()
                                    .contractTerminateTimeLock(
                                        widget.nodeAddress,
                                        widget.contractAddress,
                                        0.25,
                                        _blockAddressController.text);
                            if (contractTerminateResponse != null &&
                                contractTerminateResponse.error != null) {
                              UIUtil.showSnackbar(
                                  AppLocalization.of(context).sendError +
                                      " (" +
                                      contractTerminateResponse.error.message +
                                      ")",
                                  context);
                              return;
                            } else {
                              Navigator.of(context)
                                  .popUntil(RouteUtils.withNameLike('/home'));
                            }
                          });
                        }
                      })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  // Build contact items for the list
  Widget _buildContactItem(Contact contact) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 42,
          width: double.infinity - 5,
          child: FlatButton(
            onPressed: () {
              _blockAddressController.text = contact.name;
              _blockAddressFocusNode.unfocus();
              setState(() {
                _isContact = true;
                _showContactButton = false;
                _pasteButtonVisible = false;
                _blockAddressStyle = AddressStyle.PRIMARY;
              });
            },
            child: Text(contact.name,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleAddressText90(context)),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          height: 1,
          color: StateContainer.of(context).curTheme.text03,
        ),
      ],
    );
  }

  /// Validate form data to see if valid
  /// @returns true if valid, false otherwise
  bool _validateRequest() {
    bool isValid = true;
    _blockAddressFocusNode.unfocus();

    // Validate address
    bool isContact = _blockAddressController.text.startsWith("@");
    if (_blockAddressController.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _addressValidationText = AppLocalization.of(context).addressMising;
        _pasteButtonVisible = true;
      });
    } else if (!isContact && !Address(_blockAddressController.text).isValid()) {
      isValid = false;
      setState(() {
        _addressValidationText = AppLocalization.of(context).invalidAddress;
        _pasteButtonVisible = true;
      });
    } else if (!isContact) {
      setState(() {
        _addressValidationText = "";
        _pasteButtonVisible = false;
      });
      _blockAddressFocusNode.unfocus();
    }

    return isValid;
  }

  getEnterAddressContainer() {
    return AppTextField(
        padding: _addressValidAndUnfocused
            ? EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0)
            : EdgeInsets.zero,
        textAlign: _isContact && false ? TextAlign.start : TextAlign.center,
        focusNode: _blockAddressFocusNode,
        controller: _blockAddressController,
        cursorColor: StateContainer.of(context).curTheme.primary,
        inputFormatters: [
          _isContact
              ? LengthLimitingTextInputFormatter(20)
              : LengthLimitingTextInputFormatter(65),
        ],
        textInputAction: TextInputAction.done,
        maxLines: null,
        autocorrect: false,
        hintText: _addressHint == null
            ? ""
            : AppLocalization.of(context).enterAddress,
        prefixButton: TextFieldButton(
          icon: AppIcons.at,
          onPressed: () {
            if (_showContactButton && _contacts.length == 0) {
              // Show menu
              FocusScope.of(context).requestFocus(_blockAddressFocusNode);
              if (_blockAddressController.text.length == 0) {
                _blockAddressController.text = "@";
                _blockAddressController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _blockAddressController.text.length));
              }
              sl.get<DBHelper>().getContacts().then((contactList) {
                setState(() {
                  _contacts = contactList;
                });
              });
            }
          },
        ),
        fadePrefixOnCondition: true,
        prefixShowFirstCondition: _showContactButton && _contacts.length == 0,
        suffixButton: TextFieldButton(
          icon: AppIcons.paste,
          onPressed: () {
            if (!_pasteButtonVisible) {
              return;
            }
            Clipboard.getData("text/plain").then((ClipboardData data) {
              if (data == null || data.text == null) {
                return;
              }
              Address address = Address(data.text);
              if (address.isValid()) {
                sl
                    .get<DBHelper>()
                    .getContactWithAddress(address.address)
                    .then((contact) {
                  if (contact == null) {
                    setState(() {
                      _isContact = false;
                      _addressValidationText = "";
                      _blockAddressStyle = AddressStyle.TEXT90;
                      _pasteButtonVisible = false;
                      _showContactButton = false;
                    });
                    _blockAddressController.text = address.address;
                    //_blockAddressFocusNode.unfocus();
                    setState(() {
                      //_addressValidAndUnfocused = true;
                    });
                  } else {
                    // Is a contact
                    setState(() {
                      _isContact = true;
                      _addressValidationText = "";
                      _blockAddressStyle = AddressStyle.PRIMARY;
                      _pasteButtonVisible = false;
                      _showContactButton = false;
                    });
                    _blockAddressController.text = contact.name;
                  }
                });
              }
            });
          },
        ),
        fadeSuffixOnCondition: true,
        suffixShowFirstCondition: _pasteButtonVisible,
        style: _blockAddressStyle == AddressStyle.TEXT60
            ? AppStyles.textStyleAddressText60(context)
            : _blockAddressStyle == AddressStyle.TEXT90
                ? AppStyles.textStyleAddressText90(context)
                : AppStyles.textStyleAddressText90(context),
        onChanged: (text) {
          if (text.length > 0) {
            setState(() {
              _showContactButton = false;
            });
          } else {
            setState(() {
              _showContactButton = true;
            });
          }
          bool isContact = text.startsWith("@");
          // Switch to contact mode if starts with @
          if (isContact) {
            setState(() {
              _isContact = true;
            });
            sl
                .get<DBHelper>()
                .getContactsWithNameLike(text)
                .then((matchedList) {
              setState(() {
                _contacts = matchedList;
              });
            });
          } else {
            setState(() {
              _isContact = false;
              _contacts = [];
            });
          }
          // Always reset the error message to be less annoying
          setState(() {
            _addressValidationText = "";
          });
          if (!isContact && Address(text).isValid()) {
            //_blockAddressFocusNode.unfocus();
            setState(() {
              _blockAddressStyle = AddressStyle.TEXT90;
              _addressValidationText = "";
              _pasteButtonVisible = true;
            });
          } else if (!isContact) {
            setState(() {
              _blockAddressStyle = AddressStyle.TEXT60;
              _pasteButtonVisible = true;
            });
          } else {
            sl.get<DBHelper>().getContactWithName(text).then((contact) {
              if (contact == null) {
                setState(() {
                  _blockAddressStyle = AddressStyle.TEXT60;
                });
              } else {
                setState(() {
                  _pasteButtonVisible = false;
                  _addressValidationText = "";
                  _blockAddressStyle = AddressStyle.PRIMARY;
                });
              }
            });
          }
        },
        overrideTextFieldWidget: _addressValidAndUnfocused
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _addressValidAndUnfocused = false;
                    _addressValidationText = "";
                  });
                  Future.delayed(Duration(milliseconds: 50), () {
                    FocusScope.of(context).requestFocus(_blockAddressFocusNode);
                  });
                },
                child: UIUtil.threeLineAddressText(
                    context, _blockAddressController.text))
            : null);
  }
}
