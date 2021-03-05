import 'dart:async';
import 'dart:convert';
import 'package:dartssh/client.dart';
import 'package:decimal/decimal.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/bus/events.dart';
import 'package:my_idena/bus/subscribe_event.dart';
import 'package:my_idena/model/deepLinks/deepLinkParamSignin.dart';
import 'package:my_idena/model/deepLinks/idena_url.dart';
import 'package:my_idena/network/model/request/bcn_send_raw_tx_request.dart';
import 'package:my_idena/network/model/request/bcn_syncing_request.dart';
import 'package:my_idena/network/model/request/bcn_transaction_request.dart';
import 'package:my_idena/network/model/request/dna_getBalance_request.dart';
import 'package:my_idena/network/model/request/dna_identity_request.dart';
import 'package:my_idena/network/model/response/bcn_mempool_response.dart';
import 'package:my_idena/network/model/response/bcn_send_raw_tx_response.dart';
import 'package:my_idena/network/model/response/bcn_transaction_response.dart';
import 'package:my_idena/network/model/response/dna_activate_invite_response.dart';
import 'package:my_idena/network/model/response/dna_send_invite_response.dart';
import 'package:my_idena/network/model/response/bcn_syncing_response.dart';
import 'package:my_idena/network/model/response/bcn_transactions_response.dart';
import 'package:my_idena/network/model/response/dna_becomeOffline_response.dart';
import 'package:my_idena/network/model/response/dna_becomeOnline_response.dart';
import 'package:my_idena/network/model/response/dna_ceremonyIntervals_response.dart';
import 'package:my_idena/network/model/response/dna_getBalance_response.dart';
import 'package:my_idena/network/model/response/dna_getCoinbaseAddr_response.dart';
import 'package:my_idena/network/model/response/dna_getEpoch_response.dart';
import 'package:my_idena/network/model/response/dna_identity_response.dart';
import 'package:my_idena/network/model/response/dna_sendTransaction_response.dart';
import 'package:my_idena/model/transaction.dart' as model;
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/helpers.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/util_demo_mode.dart';
import 'package:http/http.dart' as http;
import 'package:ethereum_util/ethereum_util.dart' as ethereum_util;

class AppService {
  var logger = Logger();
  final Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };
  String body;
  http.Response responseHttp;

  SSHClient sshClient;

  Future<DnaGetBalanceResponse> getBalanceGetResponse(
      String address, bool activeBus) async {
    DnaGetBalanceRequest dnaGetBalanceRequest;
    DnaGetBalanceResponse dnaGetBalanceResponse = new DnaGetBalanceResponse();
    Map<String, dynamic> mapParams;

    Completer<DnaGetBalanceResponse> _completer =
        new Completer<DnaGetBalanceResponse>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    if (url.isAbsolute == false) {
      _completer.complete(dnaGetBalanceResponse);
      return _completer.future;
    }

    mapParams = {
      'method': DnaGetBalanceRequest.METHOD_NAME,
      'params': [address],
      'id': 101,
    };

    try {
      dnaGetBalanceRequest = DnaGetBalanceRequest.fromJson(mapParams);
      body = json.encode(dnaGetBalanceRequest.toJson());
      responseHttp = await http.post(url, body: body, headers: requestHeaders);
      if (responseHttp.statusCode == 200) {
        dnaGetBalanceResponse =
            dnaGetBalanceResponseFromJson(responseHttp.body);
      }

      if (activeBus) {
        EventTaxiImpl.singleton()
            .fire(SubscribeEvent(response: dnaGetBalanceResponse));
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(dnaGetBalanceResponse);

    return _completer.future;
  }

  Future<int> getLastNonce(String address) async {
    DnaGetBalanceResponse dnaGetBalanceResponse = new DnaGetBalanceResponse();
    dnaGetBalanceResponse = await getBalanceGetResponse(address, false);

    Completer<int> _completer = new Completer<int>();

    if (dnaGetBalanceResponse != null &&
        dnaGetBalanceResponse.result != null &&
        dnaGetBalanceResponse.result.nonce != null) {
      _completer.complete(dnaGetBalanceResponse.result.nonce);
    } else {
      _completer.complete(1);
    }

    return _completer.future;
  }

  Future<BcnTransactionsResponse> getAddressTxsResponse(
      String address, int count) async {
    throw "method not available";
  }

  Future<bool> getWStatusGetResponse() async {
    throw "method not available";
  }

  Future<DnaGetCoinbaseAddrResponse> getDnaGetCoinbaseAddr() async {
    throw "method not available";
  }

  Future<DnaIdentityResponse> getDnaIdentity(String address) async {
    DnaIdentityRequest dnaIdentityRequest;
    DnaIdentityResponse dnaIdentityResponse;
    Map<String, dynamic> mapParams;

    Completer<DnaIdentityResponse> _completer =
        new Completer<DnaIdentityResponse>();

    if (address == null) {
      dnaIdentityResponse = new DnaIdentityResponse();
      dnaIdentityResponse.result = DnaIdentityResponseResult();
      _completer.complete(dnaIdentityResponse);
      return _completer.future;
    }

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();

    if (url.isAbsolute == false) {
      _completer.complete(dnaIdentityResponse);
      return _completer.future;
    }

    mapParams = {
      'method': DnaIdentityRequest.METHOD_NAME,
      'params': [address],
      'id': 101,
    };

    try {
      dnaIdentityRequest = DnaIdentityRequest.fromJson(mapParams);
      body = json.encode(dnaIdentityRequest.toJson());
      responseHttp = await http.post(url, body: body, headers: requestHeaders);
      if (responseHttp.statusCode == 200) {
        dnaIdentityResponse = dnaIdentityResponseFromJson(responseHttp.body);
      }
    } catch (e) {
      //logger.e(e.toString());
      dnaIdentityResponse = new DnaIdentityResponse();
      dnaIdentityResponse.result = DnaIdentityResponseResult();
      dnaIdentityResponse.result.address = address;
    }

    _completer.complete(dnaIdentityResponse);

    return _completer.future;
  }

  Future<DnaGetEpochResponse> getDnaGetEpoch() async {
    DnaGetEpochResponse dnaGetEpochResponse;

    Completer<DnaGetEpochResponse> _completer =
        new Completer<DnaGetEpochResponse>();

    dnaGetEpochResponse = new DnaGetEpochResponse();
    dnaGetEpochResponse.result = new DnaGetEpochResponseResult();
    dnaGetEpochResponse.result.currentPeriod = DM_EPOCH_CURRENT_PERIOD;
    dnaGetEpochResponse.result.epoch = DM_EPOCH_EPOCH;
    dnaGetEpochResponse.result.nextValidation = DM_EPOCH_NEXT_VALIDATION;

    _completer.complete(dnaGetEpochResponse);
    return _completer.future;
  }

  Future<DnaCeremonyIntervalsResponse> getDnaCeremonyIntervals() async {
    DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponse;

    Completer<DnaCeremonyIntervalsResponse> _completer =
        new Completer<DnaCeremonyIntervalsResponse>();

    dnaCeremonyIntervalsResponse = new DnaCeremonyIntervalsResponse();
    dnaCeremonyIntervalsResponse.result =
        new DnaCeremonyIntervalsResponseResult();
    dnaCeremonyIntervalsResponse.result.flipLotteryDuration =
        DM_CEREMONY_INTERVALS_FLIP_LOTTERY_DURATION;
    dnaCeremonyIntervalsResponse.result.longSessionDuration =
        DM_CEREMONY_INTERVALS_LONG_SESSION_DURATION;
    dnaCeremonyIntervalsResponse.result.shortSessionDuration =
        DM_CEREMONY_INTERVALS_SHORT_SESSION_DURATION;

    _completer.complete(dnaCeremonyIntervalsResponse);
    return _completer.future;
  }

  Future<String> getCurrentPeriod() async {
    throw "method not available";
  }

  Future<DnaBecomeOnlineResponse> becomeOnline() async {
    throw "method not available";
  }

  Future<DnaBecomeOfflineResponse> becomeOffline() async {
    throw "method not available";
  }

  Future<DnaSendTransactionResponse> sendTip(
      String from, String amount, String seed) async {
    throw "method not available";
  }

  Future<DnaSendTransactionResponse> sendTx(String from, String amount,
      String to, String privateKey, String payload) async {
    DnaSendTransactionResponse dnaSendTransactionResponse;

    Completer<DnaSendTransactionResponse> _completer =
        new Completer<DnaSendTransactionResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      if (url.isAbsolute == false) {
        _completer.complete(dnaSendTransactionResponse);

        EventTaxiImpl.singleton()
            .fire(TransactionSendEvent(response: "Connection error"));

        return _completer.future;
      }

      int nonce = await getLastNonce(from);
      DnaGetEpochResponse dnaGetEpochResponse = await getDnaGetEpoch();
      int epoch = 0;
      if (dnaGetEpochResponse != null &&
          dnaGetEpochResponse.result != null &&
          dnaGetEpochResponse.result.epoch != null) {
        epoch = dnaGetEpochResponse.result.epoch;
      }

      var amountNumber = BigInt.parse(
          (Decimal.parse(amount) * Decimal.parse("1000000000000000000"))
              .toString());
      //print('amountNumber: ' + amountNumber.toString());
      var maxFee = 250000000000000000;
      // Create Transaction
      model.Transaction transaction = new model.Transaction(
          nonce + 1, epoch, 0, to, amountNumber, maxFee, null, null);
      //print("transaction.toHex() before sign : " + transaction.toHex());
      transaction.sign(privateKey);
      var rawTxSigned = ethereum_util.addHexPrefix(transaction.toHex());
      //print("rawTxSigned : " + rawTxSigned);
      // Sign Raw Tx
      BcnSendRawTxResponse bcnSendRawTxResponse = await sendRawTx(rawTxSigned);
      if (bcnSendRawTxResponse.error != null) {
        EventTaxiImpl.singleton().fire(
            TransactionSendEvent(response: bcnSendRawTxResponse.error.message));
      } else {
        EventTaxiImpl.singleton()
            .fire(TransactionSendEvent(response: "Success"));
      }
    } catch (e) {
      logger.e(e.toString());

      EventTaxiImpl.singleton()
          .fire(TransactionSendEvent(response: e.toString()));
    }

    _completer.complete(dnaSendTransactionResponse);
    return _completer.future;
  }

  Future<BcnSyncingResponse> checkSync() async {
    BcnSyncingRequest bcnSyncingRequest;
    BcnSyncingResponse bcnSyncingResponse;

    Map<String, dynamic> mapParams;

    Completer<BcnSyncingResponse> _completer =
        new Completer<BcnSyncingResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();

      if (url.isAbsolute == false) {
        _completer.complete(bcnSyncingResponse);
        return _completer.future;
      }

      mapParams = {
        'method': BcnSyncingRequest.METHOD_NAME,
        'params': [],
        'id': 101,
      };

      bcnSyncingRequest = BcnSyncingRequest.fromJson(mapParams);
      body = json.encode(bcnSyncingRequest.toJson());
      responseHttp = await http.post(url, body: body, headers: requestHeaders);
      if (responseHttp.statusCode == 200) {
        bcnSyncingResponse = bcnSyncingResponseFromJson(responseHttp.body);
      }
    } catch (e) {}

    _completer.complete(bcnSyncingResponse);
    return _completer.future;
  }

  double getFeesEstimation() {
    // TODO
    //print("getFeesEstimation: " + fees.toString());
    return 0.25;
  }

  Future<BcnMempoolResponse> getMemPool(String address) async {
    throw "method not available";
  }

  Future<BcnTransactionResponse> getTransaction(
      String hash, String address) async {
    BcnTransactionRequest bcnTransactionRequest;
    BcnTransactionResponse bcnTransactionResponse;

    Map<String, dynamic> mapParams;

    Completer<BcnTransactionResponse> _completer =
        new Completer<BcnTransactionResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();

      if (url.isAbsolute == false) {
        _completer.complete(bcnTransactionResponse);
        return _completer.future;
      }

      mapParams = {
        'method': BcnTransactionRequest.METHOD_NAME,
        "params": [hash],
        'id': 101,
      };

      bcnTransactionRequest = BcnTransactionRequest.fromJson(mapParams);
      body = json.encode(bcnTransactionRequest.toJson());
      responseHttp = await http.post(url, body: body, headers: requestHeaders);
      if (responseHttp.statusCode == 200) {
        bcnTransactionResponse =
            bcnTransactionResponseFromJson(responseHttp.body);
        if (bcnTransactionResponse != null &&
            bcnTransactionResponse.result != null &&
            bcnTransactionResponse.result.from != address) {
          bcnTransactionResponse = null;
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(bcnTransactionResponse);
    return _completer.future;
  }

  Future<BcnSendRawTxResponse> sendRawTx(String rawTxSigned) async {
    BcnSendRawTxRequest bcnSendRawTxRequest;
    BcnSendRawTxResponse bcnSendRawTxResponse;

    Map<String, dynamic> mapParams;

    Completer<BcnSendRawTxResponse> _completer =
        new Completer<BcnSendRawTxResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();

      if (url.isAbsolute == false) {
        _completer.complete(bcnSendRawTxResponse);
        return _completer.future;
      }

      //print("transaction.toHex : " + rawTxSigned);
      mapParams = {
        'method': BcnSendRawTxRequest.METHOD_NAME,
        "params": [rawTxSigned],
        'id': 101
      };

      bcnSendRawTxRequest = BcnSendRawTxRequest.fromJson(mapParams);
      body = json.encode(bcnSendRawTxRequest.toJson());
      responseHttp = await http.post(url, body: body, headers: requestHeaders);
      if (responseHttp.statusCode == 200) {
        bcnSendRawTxResponse = bcnSendRawTxResponseFromJson(responseHttp.body);

        if (bcnSendRawTxResponse.error != null) {
          EventTaxiImpl.singleton().fire(TransactionSendEvent(
              response: bcnSendRawTxResponse.error.message));
        } else {
          EventTaxiImpl.singleton()
              .fire(TransactionSendEvent(response: "Success"));
        }
      } else {
        EventTaxiImpl.singleton()
            .fire(TransactionSendEvent(response: responseHttp.body));
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(bcnSendRawTxResponse);
    return _completer.future;
  }

  Future<DnaActivateInviteResponse> activateInvitation(
      String key, String address) async {
    throw "method not available";
  }

  Future<DnaSendInviteResponse> sendInvitation(
      String address, String amount, int nonce, int epoch) async {
    throw "method not available";
  }

  Future<DeepLinkParamSignin> signin(
      DeepLinkParamSignin deepLinkParam, String privateKey) async {
    Completer<DeepLinkParamSignin> _completer =
        new Completer<DeepLinkParamSignin>();

    deepLinkParam.signature = AppHelpers.toHexString(
        IdenaUrl().getNonceInternal(deepLinkParam.nonce, privateKey), true);
    _completer.complete(deepLinkParam);
    return _completer.future;
  }

  Future<int> getFeePerGas() async {
    throw "method not available";
  }
}
