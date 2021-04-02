// @dart=2.9
import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/factory/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/app_text_field.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/security.dart';
import 'package:my_idena/util/app_ffi/apputil.dart';
import 'package:my_idena/util/app_ffi/keys/seeds.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/user_data_util.dart';
import 'package:my_idena/util/util_demo_mode.dart';
import 'package:my_idena/util/util_node.dart';
import 'package:my_idena/util/util_vps.dart';

class ConfigureAccessNodePage extends StatefulWidget {
  @override
  _ConfigureAccessNodePageState createState() =>
      _ConfigureAccessNodePageState();
}

class _ConfigureAccessNodePageState extends State<ConfigureAccessNodePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  FocusNode _apiUrlFocusNode;
  FocusNode _keyAppFocusNode;
  FocusNode _encryptedPkFocusNode;
  FocusNode _passwordPkFocusNode;
  FocusNode _vpsUserFocusNode;
  FocusNode _vpsIpFocusNode;
  FocusNode _vpsTunnelFocusNode;
  FocusNode _vpsPasswordFocusNode;
  FocusNode _operatorFocusNode;
  TextEditingController _apiUrlController;
  TextEditingController _keyAppController;
  TextEditingController _encryptedPkController;
  TextEditingController _passwordPkController;
  TextEditingController _vpsUserController;
  TextEditingController _vpsIpController;
  TextEditingController _vpsTunnelController;
  TextEditingController _vpsPasswordController;
  TextEditingController _operatorController;

  String _apiUrlHint = "";
  String _keyAppHint = "";
  String _encryptedPkHint = "";
  String _passwordPkHint = "";
  String _vpsUserHint = "";
  String _vpsIpHint = "";
  String _vpsTunnelHint = "";
  String _vpsPasswordHint = "";
  String _operatorHint = "";
  String _apiUrlValidationText = "";
  String _keyAppValidationText = "";
  String _encryptedPkValidationText = "";
  String _passwordPkValidationText = "";
  String _vpsUserValidationText = "";
  String _vpsIpValidationText = "";
  String _vpsTunnelValidationText = "";
  String _vpsPasswordValidationText = "";
  String _operatorValidationText = "";
  String _nodeTypeExplainationText =
      NodeUtil().getExplaination(NORMAL_VPS_NODE);
  String _addressText = "";
  int _selectedNodeType = NORMAL_VPS_NODE;
  bool _keyAppVisible;
  bool _encryptedPkVisible;
  bool _passwordPkVisible;
  bool _vpsPasswordVisible;

  bool status = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _apiUrlFocusNode = FocusNode();
    _keyAppFocusNode = FocusNode();
    _encryptedPkFocusNode = FocusNode();
    _passwordPkFocusNode = FocusNode();
    _vpsUserFocusNode = FocusNode();
    _vpsIpFocusNode = FocusNode();
    _vpsTunnelFocusNode = FocusNode();
    _vpsPasswordFocusNode = FocusNode();
    _operatorFocusNode = FocusNode();
    _apiUrlController = TextEditingController();
    _keyAppController = TextEditingController();
    _encryptedPkController = TextEditingController();
    _passwordPkController = TextEditingController();
    _vpsUserController = TextEditingController();
    _vpsIpController = TextEditingController();
    _vpsTunnelController = TextEditingController();
    _vpsPasswordController = TextEditingController();
    _operatorController = TextEditingController();
    _keyAppVisible = false;
    _encryptedPkVisible = false;
    _passwordPkVisible = false;
    _vpsPasswordVisible = false;
    _keyAppFocusNode.requestFocus();
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
    _vpsUserFocusNode.addListener(() {
      if (_vpsUserFocusNode.hasFocus) {
        setState(() {
          _vpsUserHint = null;
        });
      } else {
        setState(() {
          _vpsUserHint = "";
        });
      }
    });
    _vpsIpFocusNode.addListener(() {
      if (_vpsIpFocusNode.hasFocus) {
        setState(() {
          _vpsIpHint = null;
        });
      } else {
        setState(() {
          _vpsIpHint = "";
        });
      }
    });
    _vpsTunnelFocusNode.addListener(() {
      if (_vpsTunnelFocusNode.hasFocus) {
        setState(() {
          _vpsTunnelHint = null;
        });
      } else {
        setState(() {
          _vpsTunnelHint = "";
        });
      }
    });
    _vpsPasswordFocusNode.addListener(() {
      if (_vpsPasswordFocusNode.hasFocus) {
        setState(() {
          _vpsPasswordHint = null;
        });
      } else {
        setState(() {
          _vpsPasswordHint = "";
        });
      }
    });
    _operatorFocusNode.addListener(() {
      if (_operatorFocusNode.hasFocus) {
        setState(() {
          _operatorHint = null;
        });
      } else {
        setState(() {
          _operatorHint = "";
        });
      }
    });
    _deleteConfAccessNode();
  }

  void _deleteConfAccessNode() async {
    await sl.get<SharedPrefsUtil>().deleteConfAccessNode();
  }

  _tryConnection() async {
    _addressText = "";
    if (_selectedNodeType == DEMO_NODE || _selectedNodeType == PUBLIC_NODE) {
      status = true;
    } else {
      status = false;
    }

    if (_selectedNodeType != DEMO_NODE && _selectedNodeType != PUBLIC_NODE) {
      if ((_selectedNodeType == NORMAL_VPS_NODE &&
              _vpsTunnelController.text != "" &&
              _keyAppController.text != "" &&
              _vpsIpController.text != "" &&
              _vpsUserController.text != "" &&
              _vpsPasswordController.text != "") ||
          (_selectedNodeType == SHARED_NODE &&
              _operatorController.text != "" &&
              _keyAppController.text != "" &&
              _encryptedPkController.text != "" &&
              _passwordPkController.text != "") ||
          (_selectedNodeType == NORMAL_LOCAL_NODE &&
              _apiUrlController.text != "" &&
              _keyAppController.text != "")) {
        if (_selectedNodeType == NORMAL_VPS_NODE) {
          sl.get<VpsUtil>().disconnectVps();
        }

        String statusString =
            await sl.get<AppService>().getWStatusGetResponse();
        // print("statusString: " + statusString);
        if (statusString != null && statusString == "true") {
          status = true;
          _addressText = await AppUtil().getAddress();
        } else {
          UIUtil.showSnackbar(statusString, context);
        }
      }
    } else {
      if (_selectedNodeType == DEMO_NODE) {
        _addressText = await AppUtil().getAddress();
      }
    }
    await sl.get<SharedPrefsUtil>().setAddress(_addressText);
    //print("status : " + status.toString());
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        splashColor: StateContainer.of(context).curTheme.text15,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Icon(AppIcons.back,
                            color: StateContainer.of(context).curTheme.text,
                            size: 24)),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        end: smallScreen(context) ? 15 : 20),
                    height: 50,
                    width: 50,
                    child: FlatButton(
                        highlightColor:
                            StateContainer.of(context).curTheme.text15,
                        splashColor: StateContainer.of(context).curTheme.text15,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return UIUtil.showFAQ(context);
                          }));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Icon(FontAwesome.help_circled,
                            color: StateContainer.of(context).curTheme.text,
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, bottom: bottom + 30),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    getEnterNodeTypeContainer(),
                                  ],
                                )),
                                Container(
                                  alignment: AlignmentDirectional(0, 0),
                                  margin: EdgeInsets.only(
                                      top: 3, left: 10, right: 10),
                                  child:
                                      SelectableText(_nodeTypeExplainationText,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                          )),
                                ),
                                SizedBox(height: 30),
                                _selectedNodeType == DEMO_NODE ||
                                        _selectedNodeType == SHARED_NODE ||
                                        _selectedNodeType == NORMAL_VPS_NODE ||
                                        _selectedNodeType == PUBLIC_NODE
                                    ? SizedBox()
                                    : Container(
                                        child: getApiUrlContainer(),
                                      ),
                                _selectedNodeType == DEMO_NODE ||
                                        _selectedNodeType == SHARED_NODE ||
                                        _selectedNodeType == NORMAL_VPS_NODE ||
                                        _selectedNodeType == PUBLIC_NODE
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
                                _selectedNodeType != SHARED_NODE
                                    ? SizedBox()
                                    : Container(
                                        child: getSharedNodeOperatorContainer(),
                                      ),
                                _selectedNodeType != SHARED_NODE
                                    ? SizedBox(
                                        height: 1,
                                      )
                                    : Container(
                                        alignment: AlignmentDirectional(0, 0),
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text(_operatorValidationText,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .primary,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ),
                                _selectedNodeType == DEMO_NODE ||
                                        _selectedNodeType == PUBLIC_NODE
                                    ? SizedBox()
                                    : Container(
                                        child: getKeyAppContainer(),
                                      ),
                                _selectedNodeType == DEMO_NODE ||
                                        _selectedNodeType == PUBLIC_NODE
                                    ? SizedBox()
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
                                _selectedNodeType != SHARED_NODE
                                    ? SizedBox()
                                    : Container(
                                        child: getEncryptedPkContainer(),
                                      ),
                                _selectedNodeType != SHARED_NODE
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
                                _selectedNodeType != SHARED_NODE
                                    ? SizedBox()
                                    : Container(
                                        child: getPasswordPkContainer(),
                                      ),
                                _selectedNodeType != SHARED_NODE
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
                                _selectedNodeType != NORMAL_VPS_NODE
                                    ? SizedBox()
                                    : Container(
                                        child: getVpsIpContainer(),
                                      ),
                                _selectedNodeType != NORMAL_VPS_NODE
                                    ? SizedBox()
                                    : Container(
                                        alignment: AlignmentDirectional(0, 0),
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text(_vpsIpValidationText,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .primary,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ),
                                _selectedNodeType != NORMAL_VPS_NODE
                                    ? SizedBox()
                                    : Container(
                                        child: getVpsUserContainer(),
                                      ),
                                _selectedNodeType != NORMAL_VPS_NODE
                                    ? SizedBox()
                                    : Container(
                                        alignment: AlignmentDirectional(0, 0),
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text(_vpsUserValidationText,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .primary,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ),
                                _selectedNodeType != NORMAL_VPS_NODE
                                    ? SizedBox()
                                    : Container(
                                        child: getVpsPasswordContainer(),
                                      ),
                                _selectedNodeType != NORMAL_VPS_NODE
                                    ? SizedBox()
                                    : Container(
                                        alignment: AlignmentDirectional(0, 0),
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text(_vpsPasswordValidationText,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .primary,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ),
                                _selectedNodeType != NORMAL_VPS_NODE
                                    ? SizedBox()
                                    : Container(
                                        child: getVpsTunnelContainer(),
                                      ),
                                _selectedNodeType != NORMAL_VPS_NODE
                                    ? SizedBox()
                                    : Container(
                                        alignment: AlignmentDirectional(0, 0),
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text(_vpsTunnelValidationText,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              _addressText != null &&
                      _addressText != "" &&
                      _selectedNodeType != PUBLIC_NODE
                  ? Container(
                      alignment: AlignmentDirectional(0, 0),
                      margin: EdgeInsets.only(top: 3),
                      child: SelectableText(_addressText,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.green[400],
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                          )),
                    )
                  : SizedBox(),
              Column(children: <Widget>[
                _selectedNodeType == PUBLIC_NODE
                    ? Row(
                        children: <Widget>[
                          // New Wallet Button
                          AppButton.buildAppButton(
                              context,
                              AppButtonType.PRIMARY,
                              AppLocalization.of(context).newAccount,
                              Dimens.BUTTON_TOP_DIMENS, onPressed: () {
                            sl
                                .get<Vault>()
                                .setSeed(AppSeeds.generateSeed())
                                .then((result) {
                              // Update wallet
                              StateContainer.of(context).getSeed().then((seed) {
                                AppUtil().loginAccount(context).then((_) {
                                  StateContainer.of(context).requestUpdate();
                                  Navigator.of(context).pushNamed(
                                      '/intro_backup',
                                      arguments: StateContainer.of(context)
                                          .encryptedSecret);
                                });
                              });
                            });
                          }),
                        ],
                      )
                    : SizedBox(),
                (status && _addressText != null && _addressText != "") ||
                        (_selectedNodeType == PUBLIC_NODE)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _selectedNodeType == PUBLIC_NODE
                              ? AppButton.buildAppButton(
                                  context,
                                  AppButtonType.PRIMARY,
                                  AppLocalization.of(context).importSeed,
                                  Dimens.BUTTON_BOTTOM_DIMENS,
                                  onPressed: () async {
                                  if (_validateRequest() == true) {
                                    updateSharedPrefsUtil();
                                    await sl.get<DBHelper>().dropAccounts();
                                    await AppUtil().loginAccount(context);
                                    StateContainer.of(context).requestUpdate();
                                  } else {
                                    return;
                                  }
                                  Navigator.of(context)
                                      .pushNamed('/intro_import');
                                })
                              : AppButton.buildAppButton(
                                  context,
                                  AppButtonType.PRIMARY,
                                  AppLocalization.of(context).goHome,
                                  Dimens.BUTTON_BOTTOM_DIMENS,
                                  onPressed: () async {
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
              ])
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterApiUrl,
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
          focusNode: _apiUrlFocusNode,
          controller: _apiUrlController,
          topMargin: 0,
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
          hintText: _apiUrlHint == null
              ? ""
              : AppLocalization.of(context).enterApiUrl,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.left,
          onSubmitted: (text) {
            FocusScope.of(context).unfocus();
          },
        )
      ],
    );
  }

  getKeyAppContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterKeyApp,
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
          focusNode: _keyAppFocusNode,
          controller: _keyAppController,
          obscureText: !_keyAppVisible,
          enableSuggestions: false,
          topMargin: 0,
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
          hintText: _keyAppHint == null
              ? ""
              : AppLocalization.of(context).enterKeyApp,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.left,
          onSubmitted: (text) {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }

  getSharedNodeOperatorContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterOperator,
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
          focusNode: _operatorFocusNode,
          controller: _operatorController,
          topMargin: 0,
          cursorColor: StateContainer.of(context).curTheme.primary,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: StateContainer.of(context).curTheme.primary,
            fontFamily: 'Roboto',
          ),
          inputFormatters: [LengthLimitingTextInputFormatter(50)],
          onChanged: (text) {
            // Always reset the error message to be less annoying
            updateSharedPrefsUtil();
            setState(() {
              _operatorValidationText = "";
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: 1,
          autocorrect: false,
          hintText: _operatorHint == null
              ? ""
              : AppLocalization.of(context).enterOperator,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.left,
          onSubmitted: (text) {
            FocusScope.of(context).unfocus();
          },
        ),
        Text(AppLocalization.of(context).enterOperatorExample,
            style: AppStyles.textStyleParagraphSmallest(context)),
      ],
    );
  }

  getEncryptedPkContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterEncryptedPk,
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
          focusNode: _encryptedPkFocusNode,
          controller: _encryptedPkController,
          obscureText: !_encryptedPkVisible,
          enableSuggestions: false,
          topMargin: 0,
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
              icon:
                  _encryptedPkVisible ? Icons.visibility : Icons.visibility_off,
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
        )
      ],
    );
  }

  getPasswordPkContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterPasswordPk,
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
          focusNode: _passwordPkFocusNode,
          controller: _passwordPkController,
          obscureText: !_passwordPkVisible,
          enableSuggestions: false,
          topMargin: 0,
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
              icon:
                  _passwordPkVisible ? Icons.visibility : Icons.visibility_off,
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
        )
      ],
    );
  }

  getVpsUserContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterVpsUser,
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
          focusNode: _vpsUserFocusNode,
          controller: _vpsUserController,
          topMargin: 0,
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
              _vpsUserValidationText = "";
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          hintText: _vpsUserHint == null
              ? ""
              : AppLocalization.of(context).enterVpsUser,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.left,
          onSubmitted: (text) {
            FocusScope.of(context).unfocus();
          },
        ),
        Text(AppLocalization.of(context).enterVpsUserExample,
            style: AppStyles.textStyleParagraphSmallest(context)),
      ],
    );
  }

  getVpsIpContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterVpsIp,
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
          focusNode: _vpsIpFocusNode,
          controller: _vpsIpController,
          topMargin: 0,
          cursorColor: StateContainer.of(context).curTheme.primary,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: StateContainer.of(context).curTheme.primary,
            fontFamily: 'Roboto',
          ),
          inputFormatters: [LengthLimitingTextInputFormatter(23)],
          onChanged: (text) {
            // Always reset the error message to be less annoying
            updateSharedPrefsUtil();
            setState(() {
              _vpsIpValidationText = "";
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          hintText:
              _vpsIpHint == null ? "" : AppLocalization.of(context).enterVpsIp,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.left,
          onSubmitted: (text) {
            FocusScope.of(context).unfocus();
          },
        ),
        Text(AppLocalization.of(context).enterVpsIpExample,
            style: AppStyles.textStyleParagraphSmallest(context)),
      ],
    );
  }

  getVpsTunnelContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterVpsTunnel,
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
          focusNode: _vpsTunnelFocusNode,
          controller: _vpsTunnelController,
          topMargin: 0,
          cursorColor: StateContainer.of(context).curTheme.primary,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: StateContainer.of(context).curTheme.primary,
            fontFamily: 'Roboto',
          ),
          inputFormatters: [LengthLimitingTextInputFormatter(30)],
          onChanged: (text) {
            // Always reset the error message to be less annoying
            updateSharedPrefsUtil();
            setState(() {
              _vpsTunnelValidationText = "";
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          hintText: _vpsTunnelHint == null
              ? ""
              : AppLocalization.of(context).enterVpsTunnel,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.left,
          onSubmitted: (text) {
            FocusScope.of(context).unfocus();
          },
        ),
        Text(AppLocalization.of(context).enterVpsTunnelExample,
            style: AppStyles.textStyleParagraphSmallest(context)),
      ],
    );
  }

  getVpsPasswordContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).enterVpsPassword,
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
          focusNode: _vpsPasswordFocusNode,
          controller: _vpsPasswordController,
          obscureText: !_vpsPasswordVisible,
          enableSuggestions: false,
          topMargin: 0,
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
              _vpsPasswordValidationText = "";
            });
          },
          suffixButton: TextFieldButton(
              icon:
                  _vpsPasswordVisible ? Icons.visibility : Icons.visibility_off,
              onPressed: () {
                setState(() {
                  _vpsPasswordVisible = !_vpsPasswordVisible;
                });
              }),
          textInputAction: TextInputAction.next,
          maxLines: 1,
          autocorrect: false,
          hintText: _vpsPasswordHint == null
              ? ""
              : AppLocalization.of(context).enterVpsPassword,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.left,
          onSubmitted: (text) {
            FocusScope.of(context).unfocus();
          },
        )
      ],
    );
  }

  bool _validateRequest() {
    bool isValid = true;
    _apiUrlFocusNode.unfocus();
    _keyAppFocusNode.unfocus();
    _encryptedPkFocusNode.unfocus();
    _passwordPkFocusNode.unfocus();
    _vpsUserFocusNode.unfocus();
    _vpsIpFocusNode.unfocus();
    _vpsPasswordFocusNode.unfocus();
    _vpsTunnelFocusNode.unfocus();
    _operatorFocusNode.unfocus();

    if (_selectedNodeType == PUBLIC_NODE) {
      return isValid;
    }
    if (_selectedNodeType == SHARED_NODE) {
      if (_operatorController.text.trim().isEmpty) {
        isValid = false;
        setState(() {
          _operatorValidationText = AppLocalization.of(context).operatorMissing;
        });
      }
    }
    if (_selectedNodeType != DEMO_NODE) {
      if (_selectedNodeType != NORMAL_VPS_NODE) {
        if (_selectedNodeType != SHARED_NODE) {
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
          if (_selectedNodeType == NORMAL_VPS_NODE) {
            // TODO
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
      } else {}
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
    if (_selectedNodeType == DEMO_NODE) {
      await sl.get<SharedPrefsUtil>().setNodeType(DEMO_NODE);
      await sl.get<SharedPrefsUtil>().setApiUrl("http://127.0.0.1");
      await sl.get<SharedPrefsUtil>().setKeyApp(DM_KEY_APP);
      await sl.get<SharedPrefsUtil>().setVpsIp("");
      await sl.get<SharedPrefsUtil>().setVpsUser("");
      await sl.get<SharedPrefsUtil>().setVpsPassword("");
      await sl.get<SharedPrefsUtil>().setEncryptedPk("");
      await sl.get<SharedPrefsUtil>().setPasswordPk("");
    } else if (_selectedNodeType == SHARED_NODE) {
      await sl.get<SharedPrefsUtil>().setNodeType(SHARED_NODE);
      await sl.get<SharedPrefsUtil>().setApiUrl(_operatorController.text);
      await sl.get<SharedPrefsUtil>().setKeyApp(_keyAppController.text);
      await sl
          .get<SharedPrefsUtil>()
          .setEncryptedPk(_encryptedPkController.text);
      await sl.get<SharedPrefsUtil>().setPasswordPk(_passwordPkController.text);
      await sl.get<SharedPrefsUtil>().setVpsIp("");
      await sl.get<SharedPrefsUtil>().setVpsUser("");
      await sl.get<SharedPrefsUtil>().setVpsPassword("");
    } else if (_selectedNodeType == NORMAL_VPS_NODE) {
      await sl.get<SharedPrefsUtil>().setNodeType(NORMAL_VPS_NODE);
      await sl.get<SharedPrefsUtil>().setApiUrl(_vpsTunnelController.text);
      await sl.get<SharedPrefsUtil>().setKeyApp(_keyAppController.text);
      await sl.get<SharedPrefsUtil>().setVpsIp(_vpsIpController.text);
      await sl.get<SharedPrefsUtil>().setVpsUser(_vpsUserController.text);
      await sl
          .get<SharedPrefsUtil>()
          .setVpsPassword(_vpsPasswordController.text);
      await sl.get<SharedPrefsUtil>().setEncryptedPk("");
      await sl.get<SharedPrefsUtil>().setPasswordPk("");
    } else if (_selectedNodeType == PUBLIC_NODE) {
      await sl.get<SharedPrefsUtil>().setNodeType(PUBLIC_NODE);
      await sl.get<SharedPrefsUtil>().setApiUrl(PN_URL);
      await sl.get<SharedPrefsUtil>().setKeyApp("");
      await sl.get<SharedPrefsUtil>().setVpsIp("");
      await sl.get<SharedPrefsUtil>().setVpsUser("");
      await sl.get<SharedPrefsUtil>().setVpsPassword("");
      await sl.get<SharedPrefsUtil>().setEncryptedPk("");
      await sl.get<SharedPrefsUtil>().setPasswordPk("");
    } else {
      await sl.get<SharedPrefsUtil>().setNodeType(NORMAL_LOCAL_NODE);
      await sl.get<SharedPrefsUtil>().setApiUrl(_apiUrlController.text);
      await sl.get<SharedPrefsUtil>().setKeyApp(_keyAppController.text);
      await sl.get<SharedPrefsUtil>().setVpsIp("");
      await sl.get<SharedPrefsUtil>().setVpsUser("");
      await sl.get<SharedPrefsUtil>().setVpsPassword("");
      await sl.get<SharedPrefsUtil>().setEncryptedPk("");
      await sl.get<SharedPrefsUtil>().setPasswordPk("");
    }
    await _tryConnection();
  }

  getEnterNodeTypeContainer() {
    return SizedBox(
      width: 250,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: StateContainer.of(context).curTheme.backgroundDarkest,
        ),
        child: DropdownButtonFormField(
          value: _selectedNodeType,
          icon: Icon(
            Icons.arrow_drop_down,
            color: StateContainer.of(context).curTheme.text60,
          ),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(0, 5.5, 0, 0),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: StateContainer.of(context)
                          .curTheme
                          .backgroundDarkest)),
              isDense: true),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w100,
            fontFamily: 'Roboto',
            color: StateContainer.of(context).curTheme.text60,
          ),
          items: NodeUtil().getNodeTypeList().map((NodeType nodeType) {
            return DropdownMenuItem<int>(
                value: nodeType.type,
                child: Container(
                    child: Text(
                  nodeType.label,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Roboto',
                    color: StateContainer.of(context).curTheme.text60,
                  ),
                )));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedNodeType = value;
              if (_selectedNodeType == SHARED_NODE) {
                _operatorFocusNode.requestFocus();
              }
              if (_selectedNodeType == NORMAL_LOCAL_NODE) {
                _apiUrlFocusNode.requestFocus();
              }
              if (_selectedNodeType == NORMAL_VPS_NODE) {
                _keyAppFocusNode.requestFocus();
              }
              _nodeTypeExplainationText =
                  NodeUtil().getExplaination(_selectedNodeType);
              _apiUrlController = TextEditingController();
              _keyAppController = TextEditingController();
              _encryptedPkController = TextEditingController();
              _passwordPkController = TextEditingController();
              _vpsUserController = TextEditingController();
              _vpsIpController = TextEditingController();
              _vpsTunnelController = TextEditingController();
              _vpsPasswordController = TextEditingController();
              _operatorController = TextEditingController();
              _apiUrlValidationText = "";
              _keyAppValidationText = "";
              _encryptedPkValidationText = "";
              _passwordPkValidationText = "";
              _vpsUserValidationText = "";
              _vpsIpValidationText = "";
              _vpsTunnelValidationText = "";
              _vpsPasswordValidationText = "";
              _operatorValidationText = "";
              _apiUrlHint = "";
              _keyAppHint = "";
              _encryptedPkHint = "";
              _passwordPkHint = "";
              _vpsUserHint = "";
              _vpsIpHint = "";
              _vpsTunnelHint = "";
              _vpsPasswordHint = "";
              _operatorHint = "";

              updateSharedPrefsUtil();
            });
          },
        ),
      ),
    );
  }
}
