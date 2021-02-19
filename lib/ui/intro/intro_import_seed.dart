import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/util/formatters.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/app_text_field.dart';
import 'package:my_idena/ui/widgets/security.dart';
import 'package:my_idena/ui/widgets/tap_outside_unfocus.dart';
import 'package:my_idena/util/app_ffi/apputil.dart';
import 'package:my_idena/util/app_ffi/keys/mnemonics.dart';
import 'package:my_idena/util/app_ffi/keys/seeds.dart';
import 'package:my_idena/util/enums/wallet_type.dart';
import 'package:my_idena/util/sharedprefsutil.dart';

class IntroImportSeedPage extends StatefulWidget {
  @override
  _IntroImportSeedState createState() => _IntroImportSeedState();
}

class _IntroImportSeedState extends State<IntroImportSeedPage> {
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  // Plaintext seed
  FocusNode _seedInputFocusNode = FocusNode();
  TextEditingController _seedInputController = TextEditingController();
  // Mnemonic Phrase
  FocusNode _mnemonicFocusNode = FocusNode();
  TextEditingController _mnemonicController = TextEditingController();

  bool _seedMode = false; // False if restoring phrase, true if restoring seed

  bool _seedIsValid = false;
  bool _showSeedError = false;
  bool _mnemonicIsValid = false;
  String _mnemonicError;
  bool _isSwitched = false;
  String seedOrigin = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
        body: TapOutsideUnfocus(
            child: LayoutBuilder(
          builder: (context, constraints) => SafeArea(
            minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.075),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                splashColor:
                                    StateContainer.of(context).curTheme.text15,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Icon(AppIcons.back,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .text,
                                    size: 24)),
                          ),
                          // Switch between Secret Phrase and Seed
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                end: smallScreen(context) ? 15 : 20),
                            height: 50,
                            width: 50,
                            child: FlatButton(
                                highlightColor:
                                    StateContainer.of(context).curTheme.text15,
                                splashColor:
                                    StateContainer.of(context).curTheme.text15,
                                onPressed: () {
                                  setState(() {
                                    _seedMode = !_seedMode;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                    _seedMode ? Icons.vpn_key : AppIcons.seed,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .text,
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
                          _seedMode
                              ? AppLocalization.of(context).importSeed
                              : AppLocalization.of(context).importSecretPhrase,
                          style: AppStyles.textStyleHeaderColored(context),
                          maxLines: 1,
                          minFontSize: 12,
                          stepGranularity: 0.1,
                        ),
                      ),
                      // The paragraph
                      Container(
                        margin: EdgeInsets.only(
                            left: smallScreen(context) ? 30 : 40,
                            right: smallScreen(context) ? 30 : 40,
                            top: 15.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _seedMode
                              ? AppLocalization.of(context).importSeedHint
                              : AppLocalization.of(context)
                                  .importSecretPhraseHint,
                          style: AppStyles.textStyleParagraph(context),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                          child: KeyboardAvoider(
                              duration: Duration(milliseconds: 0),
                              autoScroll: true,
                              focusPadding: 40,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // The text field for the seed
                                    _seedMode
                                        ? AppTextField(
                                            leftMargin:
                                                smallScreen(context) ? 30 : 40,
                                            rightMargin:
                                                smallScreen(context) ? 30 : 40,
                                            topMargin: 20,
                                            focusNode: _seedInputFocusNode,
                                            controller: _seedInputController,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  64),
                                              UpperCaseTextFormatter()
                                            ],
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: null,
                                            autocorrect: false,
                                            prefixButton: TextFieldButton(
                                              icon: AppIcons.scan,
                                              onPressed: () {
                                                if (AppSeeds.isValidSeed(
                                                    _seedInputController
                                                        .text)) {
                                                  return;
                                                }
                                                // Scan QR for seed
                                                UIUtil.cancelLockEvent();
                                                BarcodeScanner.scan(
                                                        StateContainer.of(
                                                                context)
                                                            .curTheme
                                                            .qrScanTheme)
                                                    .then((result) {
                                                  if (result != null &&
                                                      AppSeeds.isValidSeed(
                                                          result)) {
                                                    _seedInputController.text =
                                                        result;
                                                    setState(() {
                                                      _seedIsValid = true;
                                                    });
                                                  } else if (result != null &&
                                                      AppMnemomics
                                                          .validateMnemonic(
                                                              result.split(
                                                                  ' '))) {
                                                    _mnemonicController.text =
                                                        result;
                                                    _mnemonicFocusNode
                                                        .unfocus();
                                                    _seedInputFocusNode
                                                        .unfocus();
                                                    setState(() {
                                                      _seedMode = false;
                                                      _mnemonicError = null;
                                                      _mnemonicIsValid = true;
                                                    });
                                                  } else {
                                                    UIUtil.showSnackbar(
                                                        AppLocalization.of(
                                                                context)
                                                            .qrInvalidSeed,
                                                        context);
                                                  }
                                                });
                                              },
                                            ),
                                            fadePrefixOnCondition: true,
                                            prefixShowFirstCondition:
                                                !AppSeeds.isValidSeed(
                                                    _seedInputController.text),
                                            suffixButton: TextFieldButton(
                                              icon: AppIcons.paste,
                                              onPressed: () {
                                                if (AppSeeds.isValidSeed(
                                                    _seedInputController
                                                        .text)) {
                                                  return;
                                                }
                                                Clipboard.getData("text/plain")
                                                    .then((ClipboardData data) {
                                                  if (data == null ||
                                                      data.text == null) {
                                                    return;
                                                  } else if (AppSeeds
                                                      .isValidSeed(data.text)) {
                                                    _seedInputController.text =
                                                        data.text;
                                                    setState(() {
                                                      _seedIsValid = true;
                                                    });
                                                  } else if (AppMnemomics
                                                      .validateMnemonic(data
                                                          .text
                                                          .split(' '))) {
                                                    _mnemonicController.text =
                                                        data.text;
                                                    _mnemonicFocusNode
                                                        .unfocus();
                                                    _seedInputFocusNode
                                                        .unfocus();
                                                    setState(() {
                                                      _seedMode = false;
                                                      _mnemonicError = null;
                                                      _mnemonicIsValid = true;
                                                    });
                                                  }
                                                });
                                              },
                                            ),
                                            fadeSuffixOnCondition: true,
                                            suffixShowFirstCondition:
                                                !AppSeeds.isValidSeed(
                                                    _seedInputController.text),
                                            keyboardType: TextInputType.text,
                                            style: _seedIsValid
                                                ? AppStyles.textStyleSeed(
                                                    context)
                                                : AppStyles.textStyleSeedGray(
                                                    context),
                                            onChanged: (text) {
                                              // Always reset the error message to be less annoying
                                              setState(() {
                                                _showSeedError = false;
                                              });
                                              // If valid seed, clear focus/close keyboard
                                              if (AppSeeds.isValidSeed(text)) {
                                                _seedInputFocusNode.unfocus();
                                                setState(() {
                                                  _seedIsValid = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _seedIsValid = false;
                                                });
                                              }
                                            })
                                        : // Mnemonic mode
                                        AppTextField(
                                            leftMargin:
                                                smallScreen(context) ? 30 : 40,
                                            rightMargin:
                                                smallScreen(context) ? 30 : 40,
                                            topMargin: 20,
                                            focusNode: _mnemonicFocusNode,
                                            controller: _mnemonicController,
                                            inputFormatters: [
                                              SingleSpaceInputFormatter(),
                                              LowerCaseTextFormatter(),
                                              FilteringTextInputFormatter.allow(
                                                  RegExp("[a-zA-Z ]")),
                                            ],
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: null,
                                            autocorrect: false,
                                            prefixButton: TextFieldButton(
                                              icon: AppIcons.scan,
                                              onPressed: () {
                                                if (AppMnemomics
                                                    .validateMnemonic(
                                                        _mnemonicController.text
                                                            .split(' '))) {
                                                  return;
                                                }
                                                // Scan QR for mnemonic
                                                UIUtil.cancelLockEvent();
                                                BarcodeScanner.scan(
                                                        StateContainer.of(
                                                                context)
                                                            .curTheme
                                                            .qrScanTheme)
                                                    .then((result) {
                                                  if (result != null &&
                                                      AppMnemomics
                                                          .validateMnemonic(
                                                              result.split(
                                                                  ' '))) {
                                                    _mnemonicController.text =
                                                        result;
                                                    setState(() {
                                                      _mnemonicIsValid = true;
                                                    });
                                                  } else if (result != null &&
                                                      AppSeeds.isValidSeed(
                                                          result)) {
                                                    _seedInputController.text =
                                                        result;
                                                    _mnemonicFocusNode
                                                        .unfocus();
                                                    _seedInputFocusNode
                                                        .unfocus();
                                                    setState(() {
                                                      _seedMode = true;
                                                      _seedIsValid = true;
                                                      _showSeedError = false;
                                                    });
                                                  } else {
                                                    UIUtil.showSnackbar(
                                                        AppLocalization.of(
                                                                context)
                                                            .qrMnemonicError,
                                                        context);
                                                  }
                                                });
                                              },
                                            ),
                                            fadePrefixOnCondition: true,
                                            prefixShowFirstCondition:
                                                !AppMnemomics.validateMnemonic(
                                                    _mnemonicController.text
                                                        .split(' ')),
                                            suffixButton: TextFieldButton(
                                              icon: AppIcons.paste,
                                              onPressed: () {
                                                if (AppMnemomics
                                                    .validateMnemonic(
                                                        _mnemonicController.text
                                                            .split(' '))) {
                                                  return;
                                                }
                                                Clipboard.getData("text/plain")
                                                    .then((ClipboardData data) {
                                                  if (data == null ||
                                                      data.text == null) {
                                                    return;
                                                  } else if (AppMnemomics
                                                      .validateMnemonic(data
                                                          .text
                                                          .split(' '))) {
                                                    _mnemonicController.text =
                                                        data.text;
                                                    setState(() {
                                                      _mnemonicIsValid = true;
                                                    });
                                                  } else if (AppSeeds
                                                      .isValidSeed(data.text)) {
                                                    _seedInputController.text =
                                                        data.text;
                                                    _mnemonicFocusNode
                                                        .unfocus();
                                                    _seedInputFocusNode
                                                        .unfocus();
                                                    setState(() {
                                                      _seedMode = true;
                                                      _seedIsValid = true;
                                                      _showSeedError = false;
                                                    });
                                                  }
                                                });
                                              },
                                            ),
                                            fadeSuffixOnCondition: true,
                                            suffixShowFirstCondition:
                                                !AppMnemomics.validateMnemonic(
                                                    _mnemonicController.text
                                                        .split(' ')),
                                            keyboardType: TextInputType.text,
                                            style: _mnemonicIsValid
                                                ? AppStyles
                                                    .textStyleParagraphPrimary(
                                                        context)
                                                : AppStyles.textStyleParagraph(
                                                    context),
                                            onChanged: (text) {
                                              if (text.length < 3) {
                                                setState(() {
                                                  _mnemonicError = null;
                                                });
                                              } else if (_mnemonicError !=
                                                  null) {
                                                if (!text.contains(
                                                    _mnemonicError
                                                        .split(' ')[0])) {
                                                  setState(() {
                                                    _mnemonicError = null;
                                                  });
                                                }
                                              }
                                              // If valid mnemonic, clear focus/close keyboard
                                              if (AppMnemomics.validateMnemonic(
                                                  text.split(' '))) {
                                                _mnemonicFocusNode.unfocus();
                                                setState(() {
                                                  _mnemonicIsValid = true;
                                                  _mnemonicError = null;
                                                });
                                              } else {
                                                setState(() {
                                                  _mnemonicIsValid = false;
                                                });
                                                // Validate each mnemonic word
                                                if (text.endsWith(" ") &&
                                                    text.length > 1) {
                                                  int lastSpaceIndex = text
                                                      .substring(
                                                          0, text.length - 1)
                                                      .lastIndexOf(" ");
                                                  if (lastSpaceIndex == -1) {
                                                    lastSpaceIndex = 0;
                                                  } else {
                                                    lastSpaceIndex++;
                                                  }
                                                  String lastWord =
                                                      text.substring(
                                                          lastSpaceIndex,
                                                          text.length - 1);
                                                  if (!AppMnemomics.isValidWord(
                                                      lastWord)) {
                                                    setState(() {
                                                      _mnemonicIsValid = false;
                                                      setState(() {
                                                        _mnemonicError =
                                                            AppLocalization.of(
                                                                    context)
                                                                .mnemonicInvalidWord
                                                                .replaceAll(
                                                                    "%1",
                                                                    lastWord);
                                                      });
                                                    });
                                                  }
                                                }
                                              }
                                            },
                                          ),
                                    // "Invalid Seed" text that appears if the input is invalid
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                          !_seedMode
                                              ? _mnemonicError == null
                                                  ? ""
                                                  : _mnemonicError
                                              : _showSeedError
                                                  ? AppLocalization.of(context)
                                                      .seedInvalid
                                                  : "",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: _seedMode
                                                ? _showSeedError
                                                    ? StateContainer.of(context)
                                                        .curTheme
                                                        .primary
                                                    : Colors.transparent
                                                : _mnemonicError != null
                                                    ? StateContainer.of(context)
                                                        .curTheme
                                                        .primary
                                                    : Colors.transparent,
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left:
                                                smallScreen(context) ? 30 : 40,
                                            right:
                                                smallScreen(context) ? 30 : 40,
                                            top: 15.0),
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalization.of(context)
                                                  .enterSeedFrom,
                                              style:
                                                  AppStyles.textStyleParagraph(
                                                      context),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            AdvancedSwitch(
                                              activeChild: Text("HD"),
                                              inactiveChild: Text("PAPER"),
                                              activeColor:
                                                  StateContainer.of(context)
                                                      .curTheme
                                                      .primary,
                                              inactiveColor:
                                                  StateContainer.of(context)
                                                      .curTheme
                                                      .primary,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              width: 76,
                                              value: _isSwitched,
                                              onChanged: (value) =>
                                                  setState(() {
                                                _isSwitched = value;
                                              }),
                                            ),
                                          ],
                                        )),
                                  ]))),
                    ],
                  ),
                ),
                // Next Screen Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 30),
                      height: 50,
                      width: 50,
                      child: FlatButton(
                          highlightColor:
                              StateContainer.of(context).curTheme.primary15,
                          splashColor:
                              StateContainer.of(context).curTheme.primary30,
                          onPressed: () async {
                            if (_seedMode) {
                              _seedInputFocusNode.unfocus();
                              // If seed valid, log them in
                              if (AppSeeds.isValidSeed(
                                  _seedInputController.text)) {
                                _isSwitched
                                    ? seedOrigin = HD_WALLET
                                    : seedOrigin = PAPER_WALLET;

                                String address = await AppUtil().seedToAddress(
                                    _seedInputController.text,
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .index,
                                    seedOrigin);

                                if (await sl
                                        .get<AppService>()
                                        .checkAddressIdena(address) ==
                                    false) {
                                  UIUtil.showSnackbar(
                                      AppLocalization.of(context).addressUnknown, context);
                                  return;
                                }

                                await sl
                                    .get<SharedPrefsUtil>()
                                    .setAddress(address);
                                await sl
                                    .get<SharedPrefsUtil>()
                                    .setSeedOrigin(seedOrigin);
                                await sl
                                    .get<Vault>()
                                    .setSeed(_seedInputController.text);
                                await sl.get<DBHelper>().dropAccounts();
                                await AppUtil().loginAccount(context);
                                StateContainer.of(context).requestUpdate();

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
                              } else {
                                // Display error
                                setState(() {
                                  _showSeedError = true;
                                });
                              }
                            } else {
                              // mnemonic mode
                              _mnemonicFocusNode.unfocus();
                              if (AppMnemomics.validateMnemonic(
                                  _mnemonicController.text.split(' '))) {
                                String seed = AppMnemomics.mnemonicListToSeed(
                                    _mnemonicController.text.split(' '));

                                _isSwitched
                                    ? seedOrigin = HD_WALLET
                                    : seedOrigin = PAPER_WALLET;

                                String address = await AppUtil().seedToAddress(
                                    seed,
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .index,
                                    seedOrigin);

                                if (await sl
                                        .get<AppService>()
                                        .checkAddressIdena(address) ==
                                    false) {
                                  UIUtil.showSnackbar(
                                      AppLocalization.of(context).addressUnknown, context);
                                  return;
                                }

                                await sl
                                    .get<SharedPrefsUtil>()
                                    .setAddress(address);
                                await sl
                                    .get<SharedPrefsUtil>()
                                    .setSeedOrigin(seedOrigin);
                                await sl.get<Vault>().setSeed(seed);
                                await sl.get<DBHelper>().dropAccounts();
                                await AppUtil().loginAccount(context);
                                StateContainer.of(context).requestUpdate();

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
                              } else {
                                // Show mnemonic error
                                if (_mnemonicController.text
                                        .split(' ')
                                        .length !=
                                    24) {
                                  setState(() {
                                    _mnemonicIsValid = false;
                                    _mnemonicError = AppLocalization.of(context)
                                        .mnemonicSizeError;
                                  });
                                } else {
                                  _mnemonicController.text
                                      .split(' ')
                                      .forEach((word) {
                                    if (!AppMnemomics.isValidWord(word)) {
                                      setState(() {
                                        _mnemonicIsValid = false;
                                        _mnemonicError =
                                            AppLocalization.of(context)
                                                .mnemonicInvalidWord
                                                .replaceAll("%1", word);
                                      });
                                    }
                                  });
                                }
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Icon(AppIcons.forward,
                              color:
                                  StateContainer.of(context).curTheme.primary,
                              size: 50)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
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
}
