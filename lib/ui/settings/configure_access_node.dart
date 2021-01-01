import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/network/model/response/dna_identity_response.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/app_text_field.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/security.dart';
import 'package:my_idena/util/app_ffi/apputil.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/user_data_util.dart';
import 'package:my_idena/util/util_demo_mode.dart';
import 'package:my_idena/util/util_public_node.dart';

class ConfigureAccessNodePage extends StatefulWidget {
  @override
  _ConfigureAccessNodePageState createState() =>
      _ConfigureAccessNodePageState();
}

class _ConfigureAccessNodePageState extends State<ConfigureAccessNodePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Logger log = sl.get<Logger>();

  FocusNode _apiUrlFocusNode;
  FocusNode _keyAppFocusNode;
  FocusNode _encryptedPkFocusNode;
  FocusNode _passwordPkFocusNode;
  TextEditingController _apiUrlController;
  TextEditingController _keyAppController;
  TextEditingController _encryptedPkController;
  TextEditingController _passwordPkController;
  String _apiUrlHint = "";
  String _keyAppHint = "";
  String _encryptedPkHint = "";
  String _passwordPkHint = "";
  String _apiUrlValidationText = "";
  String _keyAppValidationText = "";
  String _encryptedPkValidationText = "";
  String _passwordPkValidationText = "";
  String _addressText = "";
  bool _isDemoModeSwitched = false;
  bool _isPublicNodeSwitched = false;
  bool _keyAppVisible;
  bool _encryptedPkVisible;
  bool _passwordPkVisible;

  Timer _timerSync;
  bool status = false;
  AppService appService = new AppService();

  @override
  void dispose() {
    _timerSync.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _apiUrlFocusNode = FocusNode();
    _keyAppFocusNode = FocusNode();
    _encryptedPkFocusNode = FocusNode();
    _passwordPkFocusNode = FocusNode();
    _apiUrlController = TextEditingController();
    _keyAppController = TextEditingController();
    _encryptedPkController = TextEditingController();
    _passwordPkController = TextEditingController();
    _keyAppVisible = false;
    _encryptedPkVisible = false;
    _passwordPkVisible = false;

    _apiUrlFocusNode.addListener(() {
      if (_apiUrlFocusNode.hasFocus) {
        setState(() {
          _apiUrlHint = null;
        });
      } else {
        setState(() {
          _apiUrlHint = "";
        });
      }
    });
    _keyAppFocusNode.addListener(() {
      if (_keyAppFocusNode.hasFocus) {
        setState(() {
          _keyAppHint = null;
        });
      } else {
        setState(() {
          _keyAppHint = "";
        });
      }
    });
    _encryptedPkFocusNode.addListener(() {
      if (_encryptedPkFocusNode.hasFocus) {
        setState(() {
          _encryptedPkHint = null;
        });
      } else {
        setState(() {
          _encryptedPkHint = "";
        });
      }
    });
    _passwordPkFocusNode.addListener(() {
      if (_passwordPkFocusNode.hasFocus) {
        setState(() {
          _passwordPkHint = null;
        });
      } else {
        setState(() {
          _passwordPkHint = "";
        });
      }
    });

    _deleteConfAccessNode();

    _timeSyncUpdate();
  }

  void _deleteConfAccessNode() async {
    await sl.get<SharedPrefsUtil>().deleteConfAccessNode();
  }

  _timeSyncUpdate() {
    _timerSync = Timer(const Duration(milliseconds: 500), () async {
      status = true;
      status = await appService.getWStatusGetResponse();
      //print("status getStatus : " + status.toString());
      _addressText = await AppUtil().getAddress();
      if (_isPublicNodeSwitched) {
        if (_addressText != null && _addressText.isEmpty == false) {
          DnaIdentityResponse _dnaIdentityResponse =
              await appService.getDnaIdentity(_addressText);
          if (_dnaIdentityResponse == null) {
            status = false;
            //print("status getIdentity : " + status.toString());
          } else {
            _addressText = _dnaIdentityResponse.result.address;
            status = true;
          }
        } else {
          status = false;
        }
      }
      //print("status : " + status.toString());
      if (!mounted) return;
      setState(() {});
      _timeSyncUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Back Button
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              start: smallScreen(context) ? 15 : 20),
                          height: 50,
                          width: 50,
                          child: FlatButton(
                              highlightColor:
                                  StateContainer.of(context).curTheme.text15,
                              splashColor:
                                  StateContainer.of(context).curTheme.text15,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Icon(AppIcons.back,
                                  color:
                                      StateContainer.of(context).curTheme.text,
                                  size: 24)),
                        ),
                      ],
                    ),

                    // The header
                    Container(
                      margin: EdgeInsetsDirectional.only(
                        start: smallScreen(context) ? 30 : 40,
                        end: smallScreen(context) ? 30 : 40,
                        top: 10,
                      ),
                      alignment: AlignmentDirectional(-1, 0),
                      child: AutoSizeText(
                        AppLocalization.of(context).configureAccessNodeHeader,
                        style: AppStyles.textStyleHeaderColored(context),
                        stepGranularity: 0.1,
                        maxLines: 1,
                        minFontSize: 12,
                      ),
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalization.of(context).enterDemoMode,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Roboto',
                            color: StateContainer.of(context).curTheme.text60,
                          ),
                        ),
                        Switch(
                            value: _isDemoModeSwitched,
                            onChanged: (value) {
                              setState(() {
                                _isDemoModeSwitched = value;
                                if (_isDemoModeSwitched) {
                                  _isPublicNodeSwitched = false;
                                }
                                _apiUrlController = TextEditingController();
                                _keyAppController = TextEditingController();
                                _encryptedPkController =
                                    TextEditingController();
                                _passwordPkController = TextEditingController();
                                _apiUrlValidationText = "";
                                _keyAppValidationText = "";
                                _encryptedPkValidationText = "";
                                _passwordPkValidationText = "";
                                _apiUrlHint = "";
                                _keyAppHint = "";
                                _encryptedPkHint = "";
                                _passwordPkHint = "";
                              });
                              updateSharedPrefsUtil();
                            },
                            activeTrackColor: StateContainer.of(context)
                                .curTheme
                                .backgroundDarkest,
                            activeColor: Colors.green),
                      ],
                    )),
                    _isDemoModeSwitched
                        ? SizedBox()
                        : Container(
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalization.of(context).enterPublicNode,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: 'Roboto',
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .text60,
                                ),
                              ),
                              Switch(
                                  value: _isPublicNodeSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      _isPublicNodeSwitched = value;
                                      if (_isPublicNodeSwitched) {
                                        _isDemoModeSwitched = false;
                                      }
                                      _apiUrlController =
                                          TextEditingController();
                                      _keyAppController =
                                          TextEditingController();
                                      _encryptedPkController =
                                          TextEditingController();
                                      _passwordPkController =
                                          TextEditingController();
                                      _apiUrlValidationText = "";
                                      _keyAppValidationText = "";
                                      _encryptedPkValidationText = "";
                                      _passwordPkValidationText = "";
                                      _apiUrlHint = "";
                                      _keyAppHint = "";
                                      _encryptedPkHint = "";
                                      _passwordPkHint = "";
                                    });
                                    updateSharedPrefsUtil();
                                  },
                                  activeTrackColor: StateContainer.of(context)
                                      .curTheme
                                      .backgroundDarkest,
                                  activeColor: Colors.green),
                            ],
                          )),
                    _isDemoModeSwitched || _isPublicNodeSwitched
                        ? SizedBox()
                        : Container(
                            child: getApiUrlContainer(),
                          ),
                    _isDemoModeSwitched || _isPublicNodeSwitched
                        ? SizedBox()
                        : Container(
                            alignment: AlignmentDirectional(0, 0),
                            margin: EdgeInsets.only(top: 3),
                            child: Text(_apiUrlValidationText,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                    _isDemoModeSwitched
                        ? SizedBox()
                        : Container(
                            child: getKeyAppContainer(),
                          ),
                    _isDemoModeSwitched
                        ? SizedBox(
                            height: 1,
                          )
                        : Container(
                            alignment: AlignmentDirectional(0, 0),
                            margin: EdgeInsets.only(top: 3),
                            child: Text(_keyAppValidationText,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                    _isPublicNodeSwitched == false
                        ? SizedBox()
                        : Container(
                            child: getEncryptedPkContainer(),
                          ),
                    _isPublicNodeSwitched == false
                        ? SizedBox()
                        : Container(
                            alignment: AlignmentDirectional(0, 0),
                            margin: EdgeInsets.only(top: 3),
                            child: Text(_encryptedPkValidationText,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                    _isPublicNodeSwitched == false
                        ? SizedBox()
                        : Container(
                            child: getPasswordPkContainer(),
                          ),
                    _isPublicNodeSwitched == false
                        ? SizedBox()
                        : Container(
                            alignment: AlignmentDirectional(0, 0),
                            margin: EdgeInsets.only(top: 3),
                            child: Text(_passwordPkValidationText,
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
                      alignment: AlignmentDirectional(0, 0),
                      margin: EdgeInsets.only(top: 3),
                      child: SelectableText(_addressText,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: StateContainer.of(context).curTheme.primary,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ],
                ),
              ),

              // Next Screen Button
              status
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context).goHome,
                            Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () async {
                          if (_validateRequest() == true) {
                            updateSharedPrefsUtil();
                            await sl.get<DBHelper>().dropAccounts();
                            await AppUtil().loginAccount(context);
                            StateContainer.of(context).requestUpdate();
                          } else {
                            return;
                          }

                          String pin = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return new PinScreen(
                              PinOverlayType.NEW_PIN,
                            );
                          }));
                          if (pin != null && pin.length > 5) {
                            _pinEnteredCallback(pin);
                          }
                        }),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.TEXT_OUTLINE,
                            AppLocalization.of(context).notConnected,
                            Dimens.BUTTON_BOTTOM_DIMENS,
                            onPressed: () async {}),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _pinEnteredCallback(String pin) async {
    await sl.get<SharedPrefsUtil>().setSeedBackedUp(true);
    await sl.get<Vault>().writePin(pin);
    PriceConversion conversion =
        await sl.get<SharedPrefsUtil>().getPriceConversion();

    Navigator.of(context).pushNamedAndRemoveUntil(
        '/home', (Route<dynamic> route) => false,
        arguments: conversion);
  }

  getApiUrlContainer() {
    return AppTextField(
      focusNode: _apiUrlFocusNode,
      controller: _apiUrlController,
      topMargin: 30,
      cursorColor: StateContainer.of(context).curTheme.primary,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: StateContainer.of(context).curTheme.primary,
        fontFamily: 'Roboto',
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(35)],
      onChanged: (text) {
        // Always reset the error message to be less annoying
        updateSharedPrefsUtil();
        setState(() {
          _apiUrlValidationText = "";
        });
      },
      textInputAction: TextInputAction.next,
      maxLines: null,
      autocorrect: false,
      hintText:
          _apiUrlHint == null ? "" : AppLocalization.of(context).enterApiUrl,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.left,
      onSubmitted: (text) {
        FocusScope.of(context).unfocus();
      },
    );
  }

  getKeyAppContainer() {
    return AppTextField(
      focusNode: _keyAppFocusNode,
      controller: _keyAppController,
      obscureText: !_keyAppVisible,
      enableSuggestions: false,
      topMargin: 30,
      cursorColor: StateContainer.of(context).curTheme.primary,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: StateContainer.of(context).curTheme.primary,
        fontFamily: 'Roboto',
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(35)],
      onChanged: (text) {
        // Always reset the error message to be less annoying
        updateSharedPrefsUtil();
        setState(() {
          _keyAppValidationText = "";
        });
      },
      suffixButton: TextFieldButton(
          icon: _keyAppVisible ? Icons.visibility : Icons.visibility_off,
          onPressed: () {
            setState(() {
              _keyAppVisible = !_keyAppVisible;
            });
          }),
      textInputAction: TextInputAction.next,
      maxLines: 1,
      autocorrect: false,
      hintText:
          _keyAppHint == null ? "" : AppLocalization.of(context).enterKeyApp,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.left,
      onSubmitted: (text) {
        FocusScope.of(context).unfocus();
      },
    );
  }

  getEncryptedPkContainer() {
    return AppTextField(
      focusNode: _encryptedPkFocusNode,
      controller: _encryptedPkController,
      obscureText: !_encryptedPkVisible,
      enableSuggestions: false,
      topMargin: 30,
      cursorColor: StateContainer.of(context).curTheme.primary,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: StateContainer.of(context).curTheme.primary,
        fontFamily: 'Roboto',
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(150)],
      onChanged: (text) {
        // Always reset the error message to be less annoying
        updateSharedPrefsUtil();
        setState(() {
          _encryptedPkValidationText = "";
        });
      },
      textInputAction: TextInputAction.next,
      maxLines: 1,
      autocorrect: false,
      hintText: _encryptedPkHint == null
          ? ""
          : AppLocalization.of(context).enterEncryptedPk,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.left,
      onSubmitted: (text) {
        FocusScope.of(context).unfocus();
      },
      suffixButton: TextFieldButton(
          icon: _encryptedPkVisible ? Icons.visibility : Icons.visibility_off,
          onPressed: () {
            setState(() {
              _encryptedPkVisible = !_encryptedPkVisible;
            });
          }),
      prefixButton: TextFieldButton(
          icon: AppIcons.scan,
          onPressed: () async {
            UIUtil.cancelLockEvent();
            String scanResult =
                await UserDataUtil.getQRData(DataType.ADDRESS, context);
            if (scanResult == null) {
              UIUtil.showSnackbar(
                  AppLocalization.of(context).qrInvalidAddress, context);
            } else if (scanResult != null &&
                !QRScanErrs.ERROR_LIST.contains(scanResult)) {
              if (mounted) {
                setState(() {
                  _encryptedPkController.text = scanResult;
                  _encryptedPkValidationText = "";
                });
                _encryptedPkFocusNode.unfocus();
              }
            }
          }),
    );
  }

  getPasswordPkContainer() {
    return AppTextField(
      focusNode: _passwordPkFocusNode,
      controller: _passwordPkController,
      obscureText: !_passwordPkVisible,
      enableSuggestions: false,
      topMargin: 30,
      cursorColor: StateContainer.of(context).curTheme.primary,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: StateContainer.of(context).curTheme.primary,
        fontFamily: 'Roboto',
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(100)],
      onChanged: (text) {
        // Always reset the error message to be less annoying
        updateSharedPrefsUtil();
        setState(() {
          _passwordPkValidationText = "";
        });
      },
      suffixButton: TextFieldButton(
          icon: _passwordPkVisible ? Icons.visibility : Icons.visibility_off,
          onPressed: () {
            setState(() {
              _passwordPkVisible = !_passwordPkVisible;
            });
          }),
      textInputAction: TextInputAction.next,
      maxLines: 1,
      autocorrect: false,
      hintText: _passwordPkHint == null
          ? ""
          : AppLocalization.of(context).enterPasswordPk,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.left,
      onSubmitted: (text) {
        FocusScope.of(context).unfocus();
      },
    );
  }

  bool _validateRequest() {
    bool isValid = true;
    _apiUrlFocusNode.unfocus();
    _keyAppFocusNode.unfocus();
    _encryptedPkFocusNode.unfocus();
    _passwordPkFocusNode.unfocus();

    if (_isDemoModeSwitched == false) {
      if (_isPublicNodeSwitched == false) {
        if (_apiUrlController.text.trim().isEmpty) {
          isValid = false;
          setState(() {
            _apiUrlValidationText = AppLocalization.of(context).apiUrlMissing;
          });
        } else {
          if (Uri.parse(_apiUrlController.text).isAbsolute == false) {
            isValid = false;
            setState(() {
              _apiUrlValidationText = AppLocalization.of(context).wrongApiUrl;
            });
          }
        }
      } else {
        if (_encryptedPkController.text.trim().isEmpty) {
          isValid = false;
          setState(() {
            _encryptedPkValidationText =
                AppLocalization.of(context).encryptedPkMissing;
          });
        }
        if (_passwordPkController.text.trim().isEmpty) {
          isValid = false;
          setState(() {
            _passwordPkValidationText =
                AppLocalization.of(context).passwordPkMissing;
          });
        }
      }

      if (_keyAppController.text.trim().isEmpty) {
        isValid = false;
        setState(() {
          _keyAppValidationText = AppLocalization.of(context).keyAppMissing;
        });
      }
    }

    return isValid;
  }

  void updateSharedPrefsUtil() async {
    if (_isDemoModeSwitched) {
      await sl.get<SharedPrefsUtil>().setApiUrl("http://127.0.0.1");
      await sl.get<SharedPrefsUtil>().setKeyApp(DM_KEY_APP);
    } else {
      await sl.get<SharedPrefsUtil>().setApiUrl(_apiUrlController.text);
      await sl.get<SharedPrefsUtil>().setKeyApp(_keyAppController.text);
    }
    if (_isPublicNodeSwitched) {
      await sl.get<SharedPrefsUtil>().setApiUrl(PN_URL);
      await sl
          .get<SharedPrefsUtil>()
          .setEncryptedPk(_encryptedPkController.text);
      await sl.get<SharedPrefsUtil>().setPasswordPk(_passwordPkController.text);
    } else {
      await sl.get<SharedPrefsUtil>().setEncryptedPk("");
      await sl.get<SharedPrefsUtil>().setPasswordPk("");
    }
  }
}
