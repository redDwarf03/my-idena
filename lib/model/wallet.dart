import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';
import 'package:my_idena/model/available_currency.dart';
import 'package:my_idena/network/model/response/bcn_transactions_response.dart';
import 'package:my_idena/util/numberutil.dart';

/// Main wallet object that's passed around the app via state
class AppWallet {
  static const String defaultRepresentative = '0xf2b4f700d2975abd39000587f9788f66afedf691';

  bool _loading; // Whether or not app is initially loading
  bool _historyLoading; // Whether or not we have received initial account history response
  String _address;
  double _accountBalance;
  double _accountStake;
  String _representative;
  String _localCurrencyPrice;
  String _btcPrice;
  List<Transaction> _history;

  AppWallet({String address, double accountBalance, double accountStake,
                String representative, String localCurrencyPrice,String btcPrice, 
                List<Transaction> history, bool loading, bool historyLoading}) {
    this._address = address;
    this._accountBalance = accountBalance ?? 0;
    this._accountStake = accountStake ?? 0;
    this._representative = representative;
    this._localCurrencyPrice = localCurrencyPrice ?? "0";
    this._btcPrice = btcPrice ?? "0";
    this._history = history ?? new List<Transaction>();
    this._loading = loading ?? true;
    this._historyLoading = historyLoading  ?? true;
  }

  String get address => _address;

  set address(String address) {
    this._address = address;
  }

  double get accountBalance => _accountBalance;

  set accountBalance(double accountBalance) {
    this._accountBalance = accountBalance;
  }

 double get accountStake => _accountStake;

  set accountStake(double accountStake) {
    this._accountStake = accountStake;
  }

  // Get pretty account balance version
  String getAccountBalanceDisplay() {
    if (accountBalance == null) {
      return "0";
    }
    return NumberUtil.getRawAsUsableString(_accountBalance.toString());
  }

  String getAccountStakeDisplay() {
    if (accountStake == null) {
      return "0";
    }
    return NumberUtil.getRawAsUsableString(_accountStake.toString());
  }


  String getLocalCurrencyPrice(AvailableCurrency currency, {String locale = "en_US"}) {
    Decimal converted = Decimal.parse(_localCurrencyPrice) * (NumberUtil.getRawAsUsableDecimal(_accountBalance.toString()) + NumberUtil.getRawAsUsableDecimal(_accountStake.toString()));
    return NumberFormat.currency(locale:locale, symbol: currency.getCurrencySymbol()).format(converted.toDouble());
  }

  set localCurrencyPrice(String value) {
    _localCurrencyPrice = value;
  }

  String get localCurrencyConversion {
    return _localCurrencyPrice;
  }

  String get btcPrice {
    Decimal converted = Decimal.parse(_btcPrice) * (NumberUtil.getRawAsUsableDecimal(_accountBalance.toString()) + NumberUtil.getRawAsUsableDecimal(_accountStake.toString()));
    // Show 4 decimal places for BTC price if its >= 0.0001 BTC, otherwise 6 decimals
    if (converted >= Decimal.parse("0.0001")) {
      return new NumberFormat("#,##0.0000", "en_US").format(converted.toDouble());
    } else {
      return new NumberFormat("#,##0.000000000", "en_US").format(converted.toDouble());
    }
  }

  set btcPrice(String value) {
    _btcPrice = value;
  }

  String get representative {
   return _representative ?? defaultRepresentative;
  }

  set representative(String value) {
    _representative = value;
  }

  List<Transaction> get history => _history;

  set history(List<Transaction> value) {
    _history = value;
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  bool get historyLoading => _historyLoading;

  set historyLoading(bool value) {
    _historyLoading = value;
  }
}