// @dart=2.9
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/ui/widgets/mnemonic_display.dart';
import 'package:my_idena/ui/widgets/plainseed_display.dart';
import 'package:my_idena/ui/widgets/sheets.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/app_ffi/keys/mnemonics.dart';

class AppSeedBackupSheet {
  String _seed;
  List<String> _mnemonic;
  List<String> mnemonic;
  bool showMnemonic;
  bool _seedCopied;
  Timer _seedCopiedTimer;
  bool _mnemonicCopied;
  Timer _mnemonicCopiedTimer;

  AppSeedBackupSheet(String seed) {
    this._seed = seed;
  }

  mainBottomSheet(BuildContext context) {
    _seedCopied = false;
    _mnemonicCopied = false;
    _mnemonic = AppMnemomics.seedToMnemonic(_seed);
    bool showMnemonic = true;
    AppSheets.showAppHeightNineSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
                minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                ),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(width: 60, height: 60),
                              // Sheet handle and Header
                              Column(
                                children: <Widget>[
                                  // Header text
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: 5,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: BoxDecoration(
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .text10,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  //A container for the header
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context)
                                                .size
                                                .width -
                                            140),
                                    child: Column(
                                      children: <Widget>[
                                        AutoSizeText(
                                          CaseChange.toUpperCase(
                                              showMnemonic
                                                  ? AppLocalization.of(context).secretPhrase
                                                  : AppLocalization.of(context).seed,
                                              context),
                                          style: AppStyles.textStyleHeader(
                                              context),
                                          maxLines: 1,
                                          stepGranularity: 0.1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Switch button
                              Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsetsDirectional.only(
                                    top: 10.0, end: 10.0),
                                child: FlatButton(
                                  highlightColor: StateContainer.of(context)
                                      .curTheme
                                      .text15,
                                  splashColor: StateContainer.of(context)
                                      .curTheme
                                      .text15,
                                  onPressed: () {
                                    setState(() {
                                      showMnemonic = !showMnemonic;
                                    });
                                  },
                                  child: Icon(
                                      showMnemonic
                                          ? AppIcons.seed
                                          : Icons.vpn_key,
                                      size: 24,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .text),
                                  padding: EdgeInsets.all(13.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      //A container for the paragraph and seed
                      Expanded(
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            showMnemonic
                                ? MnemonicDisplay(
                                    wordList: _mnemonic,
                                    obscureSeed: true,
                                    showButton: false,
                                  )
                                : PlainSeedDisplay(
                                    seed: _seed,
                                    obscureSeed: true,
                                    showButton: false,
                                  ),
                          ],
                        )),
                      ),
                      //A row with copy button
                      showMnemonic
                          ? Row(
                              children: <Widget>[
                                AppButton.buildAppButton(
                                    context,
                                    // Copy Mnemonic Button
                                    _mnemonicCopied
                                        ? AppButtonType.SUCCESS
                                        : AppButtonType.PRIMARY,
                                    _mnemonicCopied
                                        ? AppLocalization.of(context).secretPhraseCopied
                                        : AppLocalization.of(context).secretPhraseCopy,
                                    Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                                      Clipboard.setData(new ClipboardData(
                                            text: _mnemonic.join(" ")));
                                            
                                  //UserDataUtil.setSecureClipboardItem(_mnemonic.join(" "));
                                  setState(() {
                                    // Set copied style
                                    _mnemonicCopied = true;
                                  });
                                  if (_mnemonicCopiedTimer != null) {
                                    _mnemonicCopiedTimer.cancel();
                                  }
                                  _mnemonicCopiedTimer = new Timer(
                                      const Duration(milliseconds: 1000), () {
                                    try {
                                      setState(() {
                                        _mnemonicCopied = false;
                                      });
                                    } catch (e) {}
                                  });
                                }),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                AppButton.buildAppButton(
                                    context,
                                    // Copy Seed Button
                                    _seedCopied
                                        ? AppButtonType.SUCCESS
                                        : AppButtonType.PRIMARY,
                                    _seedCopied ? AppLocalization.of(context).seedCopiedShort : AppLocalization.of(context).copySeed,
                                    Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                                        Clipboard.setData(new ClipboardData(
                                            text: _seed));
                                  //UserDataUtil.setSecureClipboardItem(_seed);
                                  setState(() {
                                    // Set copied style
                                    _seedCopied = true;
                                  });
                                  if (_seedCopiedTimer != null) {
                                    _seedCopiedTimer.cancel();
                                  }
                                  _seedCopiedTimer = new Timer(
                                      const Duration(milliseconds: 1000), () {
                                    setState(() {
                                      _seedCopied = false;
                                    });
                                  });
                                }),
                              ],
                            ),
                    ],
                  ),
                ));
          });
        });
  }
}
