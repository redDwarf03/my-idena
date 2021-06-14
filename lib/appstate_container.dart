// @dart=2.9

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:hex/hex.dart';
import 'package:idena_lib_dart/factory/app_service.dart';
import 'package:idena_lib_dart/factory/smart_contract_service.dart';
import 'package:idena_lib_dart/model/dictWords.dart';
import 'package:idena_lib_dart/model/request/contract/api_contract_balance_updates_response.dart';
import 'package:idena_lib_dart/model/request/contract/api_contract_response.dart';
import 'package:idena_lib_dart/model/response/bcn_transactions_response.dart';
import 'package:idena_lib_dart/model/response/contract/contract_get_stake_response.dart';
import 'package:idena_lib_dart/model/response/dna_getBalance_response.dart';
import 'package:idena_lib_dart/model/response/dna_identity_response.dart';
import 'package:idena_lib_dart/model/response/simplePrice/simple_price_response.dart';
import 'package:idena_lib_dart/model/smartContractMultiSig.dart';
import 'package:idena_lib_dart/util/encrypt/crypter.dart';
import 'package:idena_lib_dart/util/helpers.dart';
import 'package:logger/logger.dart';
import 'package:uni_links/uni_links.dart';

// Project imports:
import 'package:my_idena/bus/events.dart';
import 'package:my_idena/model/available_currency.dart';
import 'package:my_idena/model/available_language.dart';
import 'package:my_idena/model/db/account.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/model/wallet.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/themes.dart';
import 'package:my_idena/util/app_ffi/apputil.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'util/sharedprefsutil.dart';

class _InheritedStateContainer extends InheritedWidget {
  // Data is your entire state. In our case just 'User'
  final StateContainerState data;

  // You must pass through a child and your state.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends StatefulWidget {
  // You must pass through a child.
  final Widget child;

  StateContainer({@required this.child});

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static StateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

/// App InheritedWidget
/// This is where we handle the global state and also where
/// we interact with the server and make requests/handle+propagate responses
///
/// Basically the central hub behind the entire app
class StateContainerState extends State<StateContainer> {
  final Logger log = sl.get<Logger>();

  // Minimum receive = 0.000001
  String receiveThreshold = BigInt.from(10).pow(24).toString();

  AppWallet wallet;
  String currencyLocale;
  Locale deviceLocale = Locale('en', 'US');
  DictWords dictWords;

  AvailableCurrency curCurrency = AvailableCurrency(AvailableCurrencyEnum.USD);
  LanguageSetting curLanguage = LanguageSetting(AvailableLanguage.DEFAULT);
  BaseTheme curTheme = IdenaTheme();
  // Currently selected account
  Account selectedAccount =
      Account(id: 1, name: "AB", index: 0, lastAccess: 0, selected: true);
  // Two most recently used accounts
  Account recentLast;
  Account recentSecondLast;

  // Initial deep link
  String initialDeepLink;
  // Deep link changes
  StreamSubscription _deepLinkSub;

  // When wallet is encrypted
  String encryptedSecret;

  @override
  void initState() {
    super.initState();
    // Register RxBus
    _registerBus();
    // Set currency locale here for the UI to access
    sl.get<SharedPrefsUtil>().getCurrency(deviceLocale).then((currency) {
      setState(() {
        currencyLocale = currency.getLocale().toString();
        curCurrency = currency;
      });
    });
    // Get default language setting
    sl.get<SharedPrefsUtil>().getLanguage().then((language) {
      setState(() {
        curLanguage = language;
      });
    });
    // Get initial deep link
    getInitialLink().then((initialLink) {
      setState(() {
        initialDeepLink = initialLink;
      });
    });
  }

  // Subscriptions
  StreamSubscription<SubscribeEvent> _subscribeEventSub;
  StreamSubscription<PriceEvent> _priceEventSub;
  StreamSubscription<AccountModifiedEvent> _accountModifiedSub;

  // Register RX event listeners
  void _registerBus() {
    _subscribeEventSub =
        EventTaxiImpl.singleton().registerTo<SubscribeEvent>().listen((event) {
      handleAddressResponse(event.response);
    });
    _priceEventSub =
        EventTaxiImpl.singleton().registerTo<PriceEvent>().listen((event) {
      // PriceResponse's get pushed periodically, it wasn't a request we made so don't pop the queue
      setState(() {
        wallet.btcPrice = event.response.btcPrice.toString();
        wallet.localCurrencyPrice =
            event.response.localCurrencyPrice.toString();
      });
    });

    // Account has been deleted or name changed
    _accountModifiedSub = EventTaxiImpl.singleton()
        .registerTo<AccountModifiedEvent>()
        .listen((event) {
      if (!event.deleted) {
        if (event.account.index == selectedAccount.index) {
          setState(() {
            selectedAccount.name = event.account.name;
          });
        } else {
          updateRecentlyUsedAccounts();
        }
      } else {
        // Remove account
        updateRecentlyUsedAccounts().then((_) {
          if (event.account.index == selectedAccount.index &&
              recentLast != null) {
            sl.get<DBHelper>().changeAccount(recentLast);
            setState(() {
              selectedAccount = recentLast;
            });
            EventTaxiImpl.singleton()
                .fire(AccountChangedEvent(account: recentLast, noPop: true));
          } else if (event.account.index == selectedAccount.index &&
              recentSecondLast != null) {
            sl.get<DBHelper>().changeAccount(recentSecondLast);
            setState(() {
              selectedAccount = recentSecondLast;
            });
            EventTaxiImpl.singleton().fire(
                AccountChangedEvent(account: recentSecondLast, noPop: true));
          } else if (event.account.index == selectedAccount.index) {
            sl.get<DBHelper>().getMainAccount().then((mainAccount) {
              sl.get<DBHelper>().changeAccount(mainAccount);
              setState(() {
                selectedAccount = mainAccount;
              });
              EventTaxiImpl.singleton()
                  .fire(AccountChangedEvent(account: mainAccount, noPop: true));
            });
          }
        });
        updateRecentlyUsedAccounts();
      }
    });
    // Deep link has been updated
    _deepLinkSub = getLinksStream().listen((String link) {
      setState(() {
        initialDeepLink = link;
      });
    });
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _destroyBus() {
    if (_subscribeEventSub != null) {
      _subscribeEventSub.cancel();
    }
    if (_priceEventSub != null) {
      _priceEventSub.cancel();
    }
    if (_accountModifiedSub != null) {
      _accountModifiedSub.cancel();
    }
    if (_deepLinkSub != null) {
      _deepLinkSub.cancel();
    }
  }

  // Update the global wallet instance with a new address
  Future<void> updateWallet({Account account}) async {
    String address;
    address = await AppUtil().getAddress();
    account.address = address;
    DnaIdentityResponse dnaIdentityResponse = new DnaIdentityResponse();
    dnaIdentityResponse = await sl.get<AppService>().getDnaIdentity(address);
    account.state =
        dnaIdentityResponse == null || dnaIdentityResponse.result == null
            ? ""
            : dnaIdentityResponse.result.state;
    selectedAccount = account;
    updateRecentlyUsedAccounts();
    setState(() {
      wallet = AppWallet(address: address, loading: true);
      requestUpdate();
    });
  }

  Future<void> updateRecentlyUsedAccounts() async {
    List<Account> otherAccounts =
        await sl.get<DBHelper>().getRecentlyUsedAccounts();
    if (otherAccounts != null && otherAccounts.length > 0) {
      if (otherAccounts.length > 1) {
        setState(() {
          recentLast = otherAccounts[0];
          recentSecondLast = otherAccounts[1];
        });
      } else {
        setState(() {
          recentLast = otherAccounts[0];
          recentSecondLast = null;
        });
      }
    } else {
      setState(() {
        recentLast = null;
        recentSecondLast = null;
      });
    }
  }

  // Change language
  void updateLanguage(LanguageSetting language) {
    setState(() {
      curLanguage = language;
    });
  }

  // Change curency
  void updateCurrency(AvailableCurrency currency) async {
    SimplePriceResponse simplePriceResponse =
        await sl.get<AppService>().getSimplePrice(currency.getIso4217Code());
    // Post to callbacks
    EventTaxiImpl.singleton().fire(PriceEvent(response: simplePriceResponse));
    setState(() {
      curCurrency = currency;
    });
  }

  // Set encrypted secret
  void setEncryptedSecret(String secret) {
    setState(() {
      encryptedSecret = secret;
    });
  }

  // Reset encrypted secret
  void resetEncryptedSecret() {
    setState(() {
      encryptedSecret = null;
    });
  }

  /// Handle address response
  void handleAddressResponse(DnaGetBalanceResponse response) {
    // Set currency locale here for the UI to access
    sl.get<SharedPrefsUtil>().getCurrency(deviceLocale).then((currency) {
      setState(() {
        currencyLocale = currency.getLocale().toString();
        curCurrency = currency;
      });
    });
    setState(() {
      if (wallet != null) {
        if (response == null || response.result == null) {
          wallet.accountBalance = 0;
          wallet.accountStake = 0;
        } else {
          wallet.accountBalance = double.tryParse(response.result.balance);
          wallet.accountStake = double.tryParse(response.result.stake);
        }
      }
    });
  }

  Future<void> requestUpdate({bool pending = true}) async {
    if (wallet != null && wallet.address != null) {
      // Request account history
      int count = 40;
      try {
        DnaGetBalanceResponse dnaGetBalanceResponse = await sl
            .get<AppService>()
            .getBalanceGetResponse(wallet.address.toString());
        EventTaxiImpl.singleton()
            .fire(SubscribeEvent(response: dnaGetBalanceResponse));

        SimplePriceResponse simplePriceResponse = await sl
            .get<AppService>()
            .getSimplePrice(curCurrency.getIso4217Code());
        // Post to callbacks
        EventTaxiImpl.singleton()
            .fire(PriceEvent(response: simplePriceResponse));

        BcnTransactionsResponse addressTxsResponse = await sl
            .get<AppService>()
            .getAddressTxsResponse(wallet.address, count);

        DnaIdentityResponse dnaIdentityResponse = new DnaIdentityResponse();
        dnaIdentityResponse = await sl
            .get<AppService>()
            .getDnaIdentity(wallet.address.toString());
        selectedAccount.state =
            dnaIdentityResponse == null || dnaIdentityResponse.result == null
                ? ""
                : dnaIdentityResponse.result.state;

        wallet.history.clear();

        // Iterate list in reverse (oldest to newest block)
        if (addressTxsResponse != null &&
            addressTxsResponse.result != null &&
            addressTxsResponse.result.transactions != null) {
          for (Transaction item in addressTxsResponse.result.transactions) {
            String contractAddressMultiSigToSend;
            SmartContractMultiSig smartContractMultiSig;
            try {
              String payloadFromHex = AppHelpers.fromHexString(item.payload);
              if (payloadFromHex.contains("multisig:")) {
                contractAddressMultiSigToSend = payloadFromHex.split(":")[1];

                if (contractAddressMultiSigToSend != null) {
                  ApiContractResponse apiContractResponse = await sl
                      .get<SmartContractService>()
                      .getContract(contractAddressMultiSigToSend);
                  if (apiContractResponse != null &&
                      apiContractResponse.result != null) {
                    smartContractMultiSig = new SmartContractMultiSig();
                    smartContractMultiSig.type = "Multisig";
                    smartContractMultiSig.owner =
                        apiContractResponse.result.author;
                    smartContractMultiSig.contractAddress =
                        apiContractResponse.result.address;

                    ApiContractBalanceUpdatesResponse
                        apiContractBalanceUpdatesResponse = await sl
                            .get<SmartContractService>()
                            .getContractBalanceUpdates(
                                smartContractMultiSig.owner,
                                apiContractResponse.result.address,
                                100);
                    if (apiContractBalanceUpdatesResponse != null &&
                        apiContractBalanceUpdatesResponse.result != null) {
                      smartContractMultiSig.balanceUpdates =
                          apiContractBalanceUpdatesResponse.result;
                    }

                    smartContractMultiSig.nbVotesDone = 0;
                    for (int j = 0;
                        j < smartContractMultiSig.balanceUpdates.length;
                        j++) {
                      if (smartContractMultiSig.balanceUpdates[j].txReceipt !=
                              null &&
                          smartContractMultiSig
                                  .balanceUpdates[j].txReceipt.method ==
                              "send") {
                        smartContractMultiSig.nbVotesDone++;
                      }
                    }

                    ContractGetStakeResponse contractGetStakeResponse = await sl
                        .get<SmartContractService>()
                        .getContractStake(
                            smartContractMultiSig.contractAddress);
                    if (contractGetStakeResponse != null &&
                        contractGetStakeResponse.result != null) {
                      smartContractMultiSig.stake = double.tryParse(
                          contractGetStakeResponse.result.stake);
                    }

                    DnaGetBalanceResponse dnaGetBalanceResponse = await sl
                        .get<AppService>()
                        .getBalanceGetResponse(
                            smartContractMultiSig.contractAddress);
                    if (dnaGetBalanceResponse != null &&
                        dnaGetBalanceResponse.result != null) {
                      smartContractMultiSig.balance =
                          double.tryParse(dnaGetBalanceResponse.result.balance);
                    } else {
                      smartContractMultiSig.balance = 0;
                    }

                    int maxVotes = await sl
                        .get<SmartContractService>()
                        .getContractReadDataByte(
                            smartContractMultiSig.contractAddress, "maxVotes");
                    smartContractMultiSig.maxVotes = maxVotes;

                    int minVotes = await sl
                        .get<SmartContractService>()
                        .getContractReadDataByte(
                            smartContractMultiSig.contractAddress, "minVotes");
                    smartContractMultiSig.minVotes = minVotes;

                    int count = await sl
                        .get<SmartContractService>()
                        .getContractReadDataByte(
                            smartContractMultiSig.contractAddress, "count");
                    smartContractMultiSig.count = count;

                    int state = await sl
                        .get<SmartContractService>()
                        .getContractReadDataByte(
                            smartContractMultiSig.contractAddress, "state");
                    smartContractMultiSig.state = state;
                  }
                }
              }
            } catch (e) {}
            item.smartContractMultiSig = smartContractMultiSig;
            wallet.history.insert(0, item);
          }
        }

        setState(() {
          wallet.historyLoading = false;
          wallet.loading = false;
        });

        EventTaxiImpl.singleton().fire(HistoryHomeEvent(items: wallet.history));
      } catch (e) {
        // TODO handle account history error
        sl.get<Logger>().e("account_history e", e);
      }
    } else {
      setState(() {
        if (wallet != null) {
          wallet.historyLoading = false;
          wallet.loading = false;
        }
      });
    }
  }

  void logOut() {
    setState(() {
      wallet = AppWallet();
      encryptedSecret = null;
    });
    sl.get<DBHelper>().dropAccounts();
  }

  // Simple build method that just passes this state through
  // your InheritedWidget
  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  Future<String> getSeed() async {
    String seed;
    if (encryptedSecret != null) {
      seed = HEX.encode(AppCrypt.decrypt(
          encryptedSecret, await sl.get<Vault>().getSessionKey()));
    } else {
      seed = await sl.get<Vault>().getSeed();
    }
    return seed;
  }
}
