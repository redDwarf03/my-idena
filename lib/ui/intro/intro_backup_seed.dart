// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hex/hex.dart';
import 'package:idena_lib_dart/enums/wallet_type.dart';
import 'package:idena_lib_dart/util/encrypt/crypter.dart';
import 'package:idena_lib_dart/util/keys/mnemonics.dart';

// Project imports:
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/mnemonic_display.dart';
import 'package:my_idena/ui/widgets/plainseed_display.dart';
import 'package:my_idena/util/app_ffi/apputil.dart';
import 'package:my_idena/util/sharedprefsutil.dart';

class IntroBackupSeedPage extends StatefulWidget {
  final String encryptedSeed;

  IntroBackupSeedPage({this.encryptedSeed}) : super();

  @override
  _IntroBackupSeedState createState() => _IntroBackupSeedState();
}

class _IntroBackupSeedState extends State<IntroBackupSeedPage> {
  String _seed;
  List<String> _mnemonic;
  bool _showMnemonic;

  @override
  void initState() {
    super.initState();
    if (widget.encryptedSeed == null) {
      sl.get<Vault>().getSeed().then((seed) {
        setState(() {
          _seed = seed;
          _mnemonic = AppMnemomics.seedToMnemonic(seed);
        });
      });
    } else {
      sl.get<Vault>().getSessionKey().then((key) {
        setState(() {
          _seed = HEX.encode(AppCrypt.decrypt(widget.encryptedSeed, key));
          _mnemonic = AppMnemomics.seedToMnemonic(_seed);
        });
      });
    }
    _showMnemonic = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075),
          child: Column(
            children: <Widget>[
              //A widget that holds the header, the paragraph, the seed, "seed copied" text and the back button
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
                                  color:
                                      StateContainer.of(context).curTheme.text,
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
                                  _showMnemonic = !_showMnemonic;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Icon(
                                  _showMnemonic ? AppIcons.seed : Icons.vpn_key,
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
                      child: Row(
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width -
                                    (smallScreen(context) ? 120 : 140)),
                            child: AutoSizeText(
                              _showMnemonic
                                  ? AppLocalization.of(context).secretPhrase
                                  : AppLocalization.of(context).seed,
                              style: AppStyles.textStyleHeaderColored(context),
                              stepGranularity: 0.1,
                              minFontSize: 12.0,
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsetsDirectional.only(start: 10, end: 10),
                            child: Icon(
                              _showMnemonic ? Icons.vpn_key : AppIcons.seed,
                              size: _showMnemonic ? 36 : 24,
                              color:
                                  StateContainer.of(context).curTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: smallScreen(context) ? 30 : 40,
                          right: smallScreen(context) ? 30 : 40,
                          top: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalization.of(context)
                            .newAccountInfoDerivationPath,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: StateContainer.of(context).curTheme.primary,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    // Mnemonic word list
                    _seed != null && _mnemonic != null
                        ? _showMnemonic
                            ? MnemonicDisplay(wordList: _mnemonic)
                            : PlainSeedDisplay(seed: _seed)
                        : Text('')
                  ],
                ),
              ),
              // Next Screen Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppButton.buildAppButton(
                    context,
                    AppButtonType.PRIMARY,
                    AppLocalization.of(context).backupConfirmButton,
                    Dimens.BUTTON_BOTTOM_DIMENS,
                    onPressed: () async {
                      // Update wallet
                      sl.get<DBHelper>().dropAccounts().then((_) {
                        StateContainer.of(context).getSeed().then((seed) async {
                          String address = await AppUtil().seedToAddress(
                              _seed,
                              StateContainer.of(context).selectedAccount.index,
                              HD_WALLET);

                          await sl.get<SharedPrefsUtil>().setAddress(address);

                          AppUtil().loginAccount(context).then((_) {
                            StateContainer.of(context).requestUpdate();
                            Navigator.of(context)
                                .pushNamed('/intro_backup_confirm');
                          });
                        });
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
