import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:logger/logger.dart';

import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/response/dna_activate_invite_response.dart';
import 'package:my_idena/factory/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/model/address.dart';
import 'package:my_idena/model/db/contact.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/widgets/app_text_field.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/util/caseconverter.dart';

class ActivateInvite extends StatefulWidget {
  final String keyInvite;
  final String address;
  final Contact contact;

  ActivateInvite({
    this.contact,
    this.keyInvite,
    this.address,
  }) : super();

  _ActivateInviteState createState() => _ActivateInviteState();
}

enum AddressStyle { TEXT60, TEXT90, PRIMARY }

class _ActivateInviteState extends State<ActivateInvite> {
  final Logger log = sl.get<Logger>();

  FocusNode _sendAddressFocusNode;
  TextEditingController _sendAddressController;
  FocusNode _keyInviteFocusNode;
  TextEditingController _keyInviteController;

  // States
  AddressStyle _sendAddressStyle;
  String _keyInviteHint = "";
  String _addressHint = "";
  String _keyInviteValidationText = "";
  String _addressValidationText = "";

  List<Contact> _contacts;
  bool animationOpen;
  // Used to replace address textfield with colorized TextSpan
  bool _addressValidAndUnfocused = false;
  // Set to true when a contact is being entered
  bool _isContact = false;
  // Buttons States (Used because we hide the buttons under certain conditions)
  bool _pasteButtonVisible = true;
  bool _showContactButton = true;

  bool validRequest = true;

  @override
  void initState() {
    super.initState();
    _keyInviteFocusNode = FocusNode();
    _sendAddressFocusNode = FocusNode();
    _keyInviteController = TextEditingController();
    _sendAddressController = TextEditingController();
    _contacts = List();
    this.animationOpen = false;
    if (widget.contact != null) {
      // Setup initial state for contact pre-filled
      _sendAddressController.text = widget.contact.name;
      _isContact = true;
      _showContactButton = false;
      _pasteButtonVisible = false;
      _sendAddressStyle = AddressStyle.PRIMARY;
    } else if (widget.address != null) {
      // Setup initial state with prefilled address
      _sendAddressController.text = widget.address;
      _showContactButton = false;
      _pasteButtonVisible = false;
      _sendAddressStyle = AddressStyle.TEXT90;
      _addressValidAndUnfocused = true;
    }

    // On amount focus change
    _keyInviteFocusNode.addListener(() {
      if (_keyInviteFocusNode.hasFocus) {
        setState(() {
          _keyInviteHint = null;
        });
      } else {
        setState(() {
          _keyInviteHint = "";
        });
      }
    });
    // On address focus change
    _sendAddressFocusNode.addListener(() {
      if (_sendAddressFocusNode.hasFocus) {
        setState(() {
          _addressHint = null;
          //_addressValidAndUnfocused = false;
        });
        _sendAddressController.selection = TextSelection.fromPosition(
            TextPosition(offset: _sendAddressController.text.length));
        if (_sendAddressController.text.startsWith("@")) {
          sl
              .get<DBHelper>()
              .getContactsWithNameLike(_sendAddressController.text)
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
          if (Address(_sendAddressController.text).isValid()) {
            //_addressValidAndUnfocused = true;
          }
        });
        if (_sendAddressController.text.trim() == "@") {
          _sendAddressController.text = "";
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
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Empty SizedBox
                SizedBox(
                  width: 60,
                  height: 60,
                ),

                //
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
                                AppLocalization.of(context)
                                    .invitationActivateTitle,
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
                        _sendAddressFocusNode.unfocus();
                        _keyInviteFocusNode.unfocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: SizedBox.expand(),
                        constraints: BoxConstraints.expand(),
                      ),
                    ),
                    //
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30, bottom: bottom + 80),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                //
                                Column(
                                  children: <Widget>[
                                    getEnterKeyInviteContainer(),
                                    Container(
                                      alignment: AlignmentDirectional(0, 0),
                                      margin: EdgeInsets.only(top: 3),
                                      child: Text(_keyInviteValidationText,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  ],
                                ),

                                // Column for Enter Address container + Enter Address Error container
                                Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: <Widget>[
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
                                            alignment: Alignment.bottomCenter,
                                            constraints: BoxConstraints(
                                                maxHeight: 174, minHeight: 0),
                                            // ********************************************* //
                                            // ********* The pop-up Contacts List ********* //
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .backgroundDarkest,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  margin: EdgeInsets.only(
                                                      bottom: 50),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.only(
                                                        bottom: 0, top: 0),
                                                    itemCount: _contacts.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return _buildContactItem(
                                                          _contacts[index]);
                                                    },
                                                  ), // ********* The pop-up Contacts List End ********* //
                                                  // ************************************************** //
                                                ),
                                              ),
                                            ),
                                          ),

                                          // ******* Enter Address Container ******* //

                                          getEnterAddressContainer(),
                                          // ******* Enter Address Container End ******* //
                                        ],
                                      ),
                                    ),

                                    // ******* Enter Address Error Container ******* //
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
                                    // ******* Enter Address Error Container End ******* //
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
                      // Send Button
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context).invitationActivateButton,
                          Dimens.BUTTON_TOP_DIMENS, onPressed: () {
                        validRequest = _validateRequest();
                        if (_sendAddressController.text.startsWith("@") &&
                            validRequest) {
                          // Need to make sure its a valid contact
                          sl
                              .get<DBHelper>()
                              .getContactWithName(_sendAddressController.text)
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
                                      .activationInviteConfirmationHeader,
                                  AppLocalization.of(context)
                                      .activationInviteConfirmationInfos,
                                  CaseChange.toUpperCase(
                                      AppLocalization.of(context).yesButton,
                                      context), () async {
                                DnaActivateInviteResponse
                                    dnaActivateInviteResponse = await sl
                                        .get<AppService>()
                                        .activateInvitation(
                                            _keyInviteController.text,
                                            contact.address);
                                if (dnaActivateInviteResponse == null) {
                                  UIUtil.showSnackbar(
                                      AppLocalization.of(context).sendError,
                                      context);
                                } else {
                                  if (dnaActivateInviteResponse.error != null) {
                                    UIUtil.showSnackbar(
                                        AppLocalization.of(context).sendError +
                                            " (" +
                                            dnaActivateInviteResponse
                                                .error.message +
                                            ")",
                                        context);
                                  } else {
                                    UIUtil.showSnackbar(
                                        AppLocalization.of(context)
                                            .activateInviteSuccess,
                                        context);
                                  }
                                }
                                Navigator.pop(context);
                              });
                            }
                          });
                        } else if (validRequest) {
                          AppDialogs.showConfirmDialog(
                              context,
                              AppLocalization.of(context)
                                  .activationInviteConfirmationHeader,
                              AppLocalization.of(context)
                                  .activationInviteConfirmationInfos,
                              CaseChange.toUpperCase(
                                  AppLocalization.of(context).yesButton,
                                  context), () async {
                            DnaActivateInviteResponse
                                dnaActivateInviteResponse = await sl
                                    .get<AppService>()
                                    .activateInvitation(
                                        _keyInviteController.text,
                                        _sendAddressController.text);
                            if (dnaActivateInviteResponse == null) {
                              UIUtil.showSnackbar(
                                  AppLocalization.of(context).sendError,
                                  context);
                            } else {
                              if (dnaActivateInviteResponse.error != null) {
                                UIUtil.showSnackbar(
                                    AppLocalization.of(context).sendError +
                                        " (" +
                                        dnaActivateInviteResponse
                                            .error.message +
                                        ")",
                                    context);
                              } else {
                                UIUtil.showSnackbar(
                                    AppLocalization.of(context)
                                        .activateInviteSuccess,
                                    context);
                              }
                            }
                            Navigator.pop(context);
                          });
                        }
                      }),
                    ],
                  ),
                  Row(
                    children: <Widget>[],
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
              _sendAddressController.text = contact.name;
              _sendAddressFocusNode.unfocus();
              setState(() {
                _isContact = true;
                _showContactButton = false;
                _pasteButtonVisible = false;
                _sendAddressStyle = AddressStyle.PRIMARY;
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
    _keyInviteFocusNode.unfocus();
    _sendAddressFocusNode.unfocus();
    _sendAddressFocusNode.unfocus();
    // Validate amount
    if (_keyInviteController.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _keyInviteValidationText = AppLocalization.of(context).keyInviteMissing;
      });
    }
    // Validate address
    bool isContact = _sendAddressController.text.startsWith("@");
    if (_sendAddressController.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _addressValidationText = AppLocalization.of(context).addressMising;
        _pasteButtonVisible = true;
      });
    } else if (!isContact && !Address(_sendAddressController.text).isValid()) {
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
      _sendAddressFocusNode.unfocus();
    }

    return isValid;
  }

  //************ Enter Amount Container Method ************//
  //*******************************************************//
  getEnterKeyInviteContainer() {
    return AppTextField(
      focusNode: _keyInviteFocusNode,
      controller: _keyInviteController,
      topMargin: 30,
      cursorColor: StateContainer.of(context).curTheme.primary,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: StateContainer.of(context).curTheme.primary,
        fontFamily: 'Roboto',
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(64)],
      onChanged: (text) {
        // Always reset the error message to be less annoying
        setState(() {
          _keyInviteValidationText = "";
        });
      },
      textInputAction: TextInputAction.next,
      maxLines: null,
      autocorrect: false,
      hintText: _keyInviteHint == null
          ? ""
          : AppLocalization.of(context).enterInviteKey,
      fadeSuffixOnCondition: true,
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
      textAlign: TextAlign.center,
      onSubmitted: (text) {
        FocusScope.of(context).unfocus();
        if (!Address(_sendAddressController.text).isValid()) {
          FocusScope.of(context).requestFocus(_sendAddressFocusNode);
        }
      },
    );
  } //************ Enter Amount Container Method End ************//
  //*************************************************************//

  //************ Enter Address Container Method ************//
  //*******************************************************//
  getEnterAddressContainer() {
    return AppTextField(
        topMargin: 124,
        padding: _addressValidAndUnfocused
            ? EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0)
            : EdgeInsets.zero,
        textAlign: _isContact && false ? TextAlign.start : TextAlign.center,
        focusNode: _sendAddressFocusNode,
        controller: _sendAddressController,
        cursorColor: StateContainer.of(context).curTheme.primary,
        inputFormatters: [
          _isContact
              ? LengthLimitingTextInputFormatter(20)
              : LengthLimitingTextInputFormatter(64),
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
              FocusScope.of(context).requestFocus(_sendAddressFocusNode);
              if (_sendAddressController.text.length == 0) {
                _sendAddressController.text = "@";
                _sendAddressController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _sendAddressController.text.length));
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
                      _sendAddressStyle = AddressStyle.TEXT90;
                      _pasteButtonVisible = false;
                      _showContactButton = false;
                    });
                    _sendAddressController.text = address.address;
                    //_sendAddressFocusNode.unfocus();
                    setState(() {
                      //_addressValidAndUnfocused = true;
                    });
                  } else {
                    // Is a contact
                    setState(() {
                      _isContact = true;
                      _addressValidationText = "";
                      _sendAddressStyle = AddressStyle.PRIMARY;
                      _pasteButtonVisible = false;
                      _showContactButton = false;
                    });
                    _sendAddressController.text = contact.name;
                  }
                });
              }
            });
          },
        ),
        fadeSuffixOnCondition: true,
        suffixShowFirstCondition: _pasteButtonVisible,
        style: _sendAddressStyle == AddressStyle.TEXT60
            ? AppStyles.textStyleAddressText60(context)
            : _sendAddressStyle == AddressStyle.TEXT90
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
            //_sendAddressFocusNode.unfocus();
            setState(() {
              _sendAddressStyle = AddressStyle.TEXT90;
              _addressValidationText = "";
              _pasteButtonVisible = true;
            });
          } else if (!isContact) {
            setState(() {
              _sendAddressStyle = AddressStyle.TEXT60;
              _pasteButtonVisible = true;
            });
          } else {
            sl.get<DBHelper>().getContactWithName(text).then((contact) {
              if (contact == null) {
                setState(() {
                  _sendAddressStyle = AddressStyle.TEXT60;
                });
              } else {
                setState(() {
                  _pasteButtonVisible = false;
                  _addressValidationText = "";
                  _sendAddressStyle = AddressStyle.PRIMARY;
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
                    FocusScope.of(context).requestFocus(_sendAddressFocusNode);
                  });
                },
                child: UIUtil.threeLineAddressText(
                    context, _sendAddressController.text))
            : null);
  } //************ Enter Address Container Method End ************//
  //*************************************************************//

}
