// @dart=2.9
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:my_idena/bus/events.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/network/model/response/dna_getBalance_response.dart';
import 'package:my_idena/factory/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/db/account.dart';
import 'package:my_idena/ui/accounts/accountdetails_sheet.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/sheets.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/numberutil.dart';

class AppAccountsSheet {
  List<Account> accounts;

  AppAccountsSheet(this.accounts);

  mainBottomSheet(BuildContext context) {
    AppSheets.showAppHeightNineSheet(
        context: context,
        builder: (BuildContext context) {
          return AppAccountsWidget(accounts: accounts);
        });
  }
}

class AppAccountsWidget extends StatefulWidget {
  final List<Account> accounts;

  AppAccountsWidget({Key key, @required this.accounts}) : super(key: key);

  @override
  _AppAccountsWidgetState createState() => _AppAccountsWidgetState();
}

class _AppAccountsWidgetState extends State<AppAccountsWidget> {
  static const int MAX_ACCOUNTS = 50;
  final GlobalKey expandedKey = GlobalKey();

  bool _addingAccount;

  ScrollController _scrollController = new ScrollController();

  StreamSubscription<AccountModifiedEvent> _accountModifiedSub;
  bool _accountIsChanging;

  @override
  void initState() {
    super.initState();
    _registerBus();
    this._addingAccount = false;
    this._accountIsChanging = false;

    widget.accounts.forEach((account) async {
      if (account.address != null) {
        DnaGetBalanceResponse balanceGetResponse =
            await sl.get<AppService>().getBalanceGetResponse(account.address, false);
        setState(() {
          account.balance = balanceGetResponse.result.balance;
        });
        sl
            .get<DBHelper>()
            .updateAccountBalance(account, balanceGetResponse.result.balance);
      }
    });
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _registerBus() {
    _accountModifiedSub = EventTaxiImpl.singleton()
        .registerTo<AccountModifiedEvent>()
        .listen((event) {
      if (event.deleted) {
        if (event.account.selected) {
          Future.delayed(Duration(milliseconds: 50), () {
            setState(() {
              widget.accounts
                  .where((a) =>
                      a.index ==
                      StateContainer.of(context).selectedAccount.index)
                  .forEach((account) {
                account.selected = true;
              });
            });
          });
        }
        setState(() {
          widget.accounts.removeWhere((a) => a.index == event.account.index);
        });
      } else {
        // Name change
        setState(() {
          widget.accounts.removeWhere((a) => a.index == event.account.index);
          widget.accounts.add(event.account);
          widget.accounts.sort((a, b) => a.index.compareTo(b.index));
        });
      }
    });
  }

  void _destroyBus() {
    if (_accountModifiedSub != null) {
      _accountModifiedSub.cancel();
    }
  }

  Future<void> _requestBalances(
      BuildContext context, List<Account> accounts) async {
    accounts.forEach((account) async {
      if (account.address != null) {
        DnaGetBalanceResponse balanceGetResponse =
            await sl.get<AppService>().getBalanceGetResponse(account.address, false);
        sl
            .get<DBHelper>()
            .updateAccountBalance(account, balanceGetResponse.result.balance);
        setState(() {
          account.balance =
              balanceGetResponse == null || balanceGetResponse.result.balance == null
                  ? 0
                  : balanceGetResponse.result.balance;
        });
      }
    });
  }

  Future<void> _changeAccount(Account account, StateSetter setState) async {
    // Change account
    widget.accounts.forEach((a) {
      if (a.selected) {
        setState(() {
          a.selected = false;
        });
      } else if (account.index == a.index) {
        setState(() {
          a.selected = true;
        });
      }
    });
    await sl.get<DBHelper>().changeAccount(account);
    EventTaxiImpl.singleton()
        .fire(AccountChangedEvent(account: account, delayPop: true));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //A container for the header
              Container(
                margin: EdgeInsets.only(top: 30.0, bottom: 15),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 140),
                child: AutoSizeText(
                  CaseChange.toUpperCase(
                      AppLocalization.of(context).accounts, context),
                  style: AppStyles.textStyleHeader(context),
                  maxLines: 1,
                  stepGranularity: 0.1,
                ),
              ),

              //A list containing accounts
              Expanded(
                  key: expandedKey,
                  child: Stack(
                    children: <Widget>[
                      widget.accounts == null
                          ? Center(
                              child: Text("Loading"),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              itemCount: widget.accounts.length,
                              controller: _scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildAccountListItem(
                                    context, widget.accounts[index], setState);
                              },
                            ),
                      //List Top Gradient
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 20.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                StateContainer.of(context)
                                    .curTheme
                                    .backgroundDark00,
                                StateContainer.of(context)
                                    .curTheme
                                    .backgroundDark,
                              ],
                              begin: AlignmentDirectional(0.5, 1.0),
                              end: AlignmentDirectional(0.5, -1.0),
                            ),
                          ),
                        ),
                      ),
                      // List Bottom Gradient
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 20.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                StateContainer.of(context)
                                    .curTheme
                                    .backgroundDark,
                                StateContainer.of(context)
                                    .curTheme
                                    .backgroundDark00
                              ],
                              begin: AlignmentDirectional(0.5, 1.0),
                              end: AlignmentDirectional(0.5, -1.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              //A row with Add Account button
              Row(
                children: <Widget>[
                  widget.accounts == null ||
                          widget.accounts.length >= MAX_ACCOUNTS
                      ? SizedBox()
                      : AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context).addAccount,
                          Dimens.BUTTON_TOP_DIMENS,
                          disabled: _addingAccount,
                          onPressed: () {
                            if (!_addingAccount) {
                              setState(() {
                                _addingAccount = true;
                              });
                             
                                sl
                                    .get<DBHelper>()
                                    .addAccount(
                                        nameBuilder: AppLocalization.of(context)
                                            .defaultNewAccountName)
                                    .then((newAccount) {
                                  _requestBalances(context, [newAccount]);
                                  StateContainer.of(context)
                                      .updateRecentlyUsedAccounts();
                                  widget.accounts.add(newAccount);
                                  setState(() {
                                    _addingAccount = false;
                                    widget.accounts.sort(
                                        (a, b) => a.index.compareTo(b.index));
                                    // Scroll if list is full
                                    if (expandedKey.currentContext != null) {
                                      RenderBox box = expandedKey.currentContext
                                          .findRenderObject();
                                      if (widget.accounts.length * 72.0 >=
                                          box.size.height) {
                                        _scrollController.animateTo(
                                          newAccount.index * 72.0 >
                                                  _scrollController
                                                      .position.maxScrollExtent
                                              ? _scrollController.position
                                                      .maxScrollExtent +
                                                  72.0
                                              : newAccount.index * 72.0,
                                          curve: Curves.easeOut,
                                          duration:
                                              const Duration(milliseconds: 200),
                                        );
                                      }
                                    }
                                  });
                                });
                              
                            }
                          },
                        ),
                ],
              ),
              //A row with Close button
              Row(
                children: <Widget>[
                  AppButton.buildAppButton(
                    context,
                    AppButtonType.PRIMARY_OUTLINE,
                    AppLocalization.of(context).close,
                    Dimens.BUTTON_BOTTOM_DIMENS,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildAccountListItem(
      BuildContext context, Account account, StateSetter setState) {
    return Slidable(
      secondaryActions: _getSlideActionsForAccount(context, account, setState),
      actionExtentRatio: 0.2,
      actionPane: SlidableStrechActionPane(),
      child: FlatButton(
          highlightColor: StateContainer.of(context).curTheme.text15,
          splashColor: StateContainer.of(context).curTheme.text15,
          onPressed: () {
            if (!_accountIsChanging) {
              // Change account
              if (!account.selected) {
                setState(() {
                  _accountIsChanging = true;
                });
                _changeAccount(account, setState);
              }
            }
          },
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              Divider(
                height: 2,
                color: StateContainer.of(context).curTheme.text15,
              ),
              Container(
                height: 70.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Selected indicator
                    Container(
                      height: 70,
                      width: 6,
                      color: account.selected
                          ? StateContainer.of(context).curTheme.primary
                          : Colors.transparent,
                    ),
                    // Icon, Account Name, Address and Amount
                    Expanded(
                      child: Container(
                        margin: EdgeInsetsDirectional.only(start: 8, end: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 64.0,
                                  height: 64.0,
                                  child: CircleAvatar(
                                    backgroundColor: StateContainer.of(context)
                                        .curTheme
                                        .text05,
                                    backgroundImage:
                                      UIUtil.getRobohashURL(account.address),
                                    radius: 50.0,
                                  ),
                                ),
                                // Account name and address
                                Container(
                                  width: (MediaQuery.of(context).size.width -
                                          116) *
                                      0.5,
                                  margin:
                                      EdgeInsetsDirectional.only(start: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Account name
                                      AutoSizeText(
                                        account.name,
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .text,
                                        ),
                                        minFontSize: 8.0,
                                        stepGranularity: 0.1,
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                      ),
                                      // Account address
                                      AutoSizeText(
                                        account.address.substring(0, 12) +
                                            "...",
                                        style: TextStyle(
                                          fontFamily: "OverpassMono",
                                          fontWeight: FontWeight.w100,
                                          fontSize: 14.0,
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .text60,
                                        ),
                                        minFontSize: 8.0,
                                        stepGranularity: 0.1,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width - 116) *
                                  0.4,
                              alignment: AlignmentDirectional(1, 0),
                              child: AutoSizeText.rich(
                                TextSpan(
                                  children: [
                                    // Main balance text
                                    TextSpan(
                                      text: account.balance == null ? "" : NumberUtil.getRawAsUsableString(
                                              account.balance) +
                                          " IDNA",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w900,
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .text),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                style: TextStyle(fontSize: 16.0),
                                stepGranularity: 0.1,
                                minFontSize: 1,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Selected indicator
                    Container(
                      height: 70,
                      width: 6,
                      color: account.selected
                          ? StateContainer.of(context).curTheme.primary
                          : Colors.transparent,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  List<Widget> _getSlideActionsForAccount(
      BuildContext context, Account account, StateSetter setState) {
    List<Widget> _actions = List();
    _actions.add(SlideAction(
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 2, top: 1, bottom: 1),
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: StateContainer.of(context).curTheme.primary,
          ),
          child: Icon(
            Icons.edit,
            color: StateContainer.of(context).curTheme.backgroundDark,
          ),
        ),
        onTap: () {
          AccountDetailsSheet(account).mainBottomSheet(context);
        }));
    if (account.index > 0) {
      _actions.add(SlideAction(
          child: Container(
            margin: EdgeInsetsDirectional.only(start: 2, top: 1, bottom: 1),
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.primary,
            ),
            child: Icon(
              Icons.delete,
              color: StateContainer.of(context).curTheme.backgroundDark,
            ),
          ),
          onTap: () {
            AppDialogs.showConfirmDialog(
                context,
                AppLocalization.of(context).hideAccountHeader,
                AppLocalization.of(context)
                    .removeAccountText
                    .replaceAll("%1", AppLocalization.of(context).addAccount),
                CaseChange.toUpperCase(
                    AppLocalization.of(context).yes, context), () {
              // Remove account
              sl.get<DBHelper>().deleteAccount(account).then((id) {
                EventTaxiImpl.singleton().fire(
                    AccountModifiedEvent(account: account, deleted: true));
                setState(() {
                  widget.accounts.removeWhere((a) => a.index == account.index);
                });
              });
            },
                cancelText: CaseChange.toUpperCase(
                    AppLocalization.of(context).no, context));
          }));
    }
    return _actions;
  }
}
