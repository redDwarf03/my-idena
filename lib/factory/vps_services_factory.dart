// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:event_taxi/event_taxi.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/bus/events.dart';
import 'package:my_idena/bus/subscribe_event.dart';
import 'package:my_idena/model/deepLinks/deepLinkParamSignin.dart';
import 'package:my_idena/network/model/request/bcn_fee_per_gas_request.dart';
import 'package:my_idena/network/model/request/bcn_mempool_request.dart';
import 'package:my_idena/network/model/request/bcn_send_raw_tx_request.dart';
import 'package:my_idena/network/model/request/bcn_syncing_request.dart';
import 'package:my_idena/network/model/request/bcn_transaction_request.dart';
import 'package:my_idena/network/model/request/bcn_transactions_request.dart';
import 'package:my_idena/network/model/request/dna_activate_invite_request.dart';
import 'package:my_idena/network/model/request/dna_becomeOffline_request.dart';
import 'package:my_idena/network/model/request/dna_becomeOnline_request.dart';
import 'package:my_idena/network/model/request/dna_ceremonyIntervals_request.dart';
import 'package:my_idena/network/model/request/dna_getBalance_request.dart';
import 'package:my_idena/network/model/request/dna_getCoinbaseAddr_request.dart';
import 'package:my_idena/network/model/request/dna_getEpoch_request.dart';
import 'package:my_idena/network/model/request/dna_identity_request.dart';
import 'package:my_idena/network/model/request/dna_sendTransaction_request.dart';
import 'package:my_idena/network/model/request/dna_send_invite_request.dart';
import 'package:my_idena/network/model/request/dna_signin_request.dart';
import 'package:my_idena/network/model/response/bcn_fee_per_gas_response.dart';
import 'package:my_idena/network/model/response/bcn_mempool_response.dart';
import 'package:my_idena/network/model/response/bcn_send_raw_tx_response.dart';
import 'package:my_idena/network/model/response/bcn_transaction_response.dart';
import 'package:my_idena/network/model/response/dna_activate_invite_response.dart';
import 'package:my_idena/network/model/response/dna_send_invite_response.dart';
import 'package:my_idena/network/model/response/dna_signin_response.dart';
import 'package:my_idena/pubdev/dartssh/client.dart';
import 'package:my_idena/pubdev/dartssh/http.dart' as ssh;
import 'package:my_idena/pubdev/ethereum_util/bytes.dart';
import 'package:my_idena/util/enums/epoch_period.dart' as EpochPeriod;
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
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/helpers.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/util_demo_mode.dart';
import 'package:my_idena/util/util_node.dart';
import 'package:my_idena/util/util_vps.dart';


class AppService {
  var logger = Logger();
  final Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };

  SSHClient sshClient;

  Future<DnaGetBalanceResponse> getBalanceGetResponse(
      String address, bool activeBus) async {
    DnaGetBalanceResponse dnaGetBalanceResponse = new DnaGetBalanceResponse();
    Map<String, dynamic> mapParams;

    Completer<DnaGetBalanceResponse> _completer =
        new Completer<DnaGetBalanceResponse>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(dnaGetBalanceResponse);
      return _completer.future;
    }

    mapParams = {
      'method': DnaGetBalanceRequest.METHOD_NAME,
      'params': [address],
      'id': 101,
      'key': keyApp
    };

    try {
      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaGetBalanceResponse = dnaGetBalanceResponseFromJson(response.text);
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
    Completer<BcnTransactionsResponse> _completer =
        new Completer<BcnTransactionsResponse>();

    Map<String, dynamic> mapParams;
    BcnTransactionsResponse bcnTransactionsResponse;

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(bcnTransactionsResponse);
      return _completer.future;
    }

    mapParams = {
      'method': BcnTransactionsRequest.METHOD_NAME,
      "params": [
        {"address": address, "count": count}
      ],
      'id': 101,
      'key': keyApp
    };

    try {
      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        bcnTransactionsResponse =
            bcnTransactionsResponseFromJson(response.text);
      }

      List<Transaction> listTxsMempool = new List();
      BcnMempoolResponse bcnMempoolResponse = await getMemPool(address);
      if (bcnMempoolResponse != null && bcnMempoolResponse.result != null) {
        List<String> hashList = bcnMempoolResponse.result;
        if (hashList != null) {
          for (int i = 0; i < hashList.length; i++) {
            BcnTransactionResponse bcnTransactionResponse =
                await getTransaction(hashList[i], address);
            if (bcnTransactionResponse != null &&
                bcnTransactionResponse.result != null) {
              Transaction transaction = new Transaction();
              transaction.amount = bcnTransactionResponse.result.amount;
              transaction.blockHash = bcnTransactionResponse.result.blockHash;
              transaction.epoch = bcnTransactionResponse.result.epoch;
              transaction.from = bcnTransactionResponse.result.from;
              transaction.hash = bcnTransactionResponse.result.hash;
              transaction.maxFee = bcnTransactionResponse.result.maxFee;
              transaction.nonce = bcnTransactionResponse.result.nonce;
              transaction.payload = bcnTransactionResponse.result.payload;
              transaction.timestamp = bcnTransactionResponse.result.timestamp;
              transaction.tips = bcnTransactionResponse.result.tips;
              transaction.to = bcnTransactionResponse.result.to;
              transaction.type = bcnTransactionResponse.result.type;
              transaction.usedFee = bcnTransactionResponse.result.usedFee;
              listTxsMempool.add(transaction);
            }
          }
        }
      }

      if (bcnTransactionsResponse != null &&
          bcnTransactionsResponse.result != null &&
          bcnTransactionsResponse.result.transactions != null) {
        bcnTransactionsResponse.result.transactions =
            new List.from(bcnTransactionsResponse.result.transactions.reversed);
        if (listTxsMempool != null && listTxsMempool.length > 0) {
          bcnTransactionsResponse.result.transactions.addAll(listTxsMempool);
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(bcnTransactionsResponse);
    return _completer.future;
  }

  Future<String> getWStatusGetResponse() async {
    Map<String, dynamic> mapParams;
    Completer<String> _completer = new Completer<String>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url == null ||
        keyApp == null ||
        url.isAbsolute == false ||
        keyApp == "") {
      _completer.complete("Url and/or api key null");
      return _completer.future;
    }

    mapParams = {
      'method': DnaIdentityRequest.METHOD_NAME,
      'params': [],
      'id': 101,
      'key': keyApp
    };

    try {
      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        DnaIdentityResponse dnaIdentityResponse =
            dnaIdentityResponseFromJson(response.text);
        if (dnaIdentityResponse.result == null) {
          if (dnaIdentityResponse.error == null) {
            _completer.complete(response.text);
          } else {
            _completer.complete(dnaIdentityResponse.error.message);
          }
        } else {
          _completer.complete("true");
        }
      }
    } catch (e) {
      _completer.complete("Error getWStatusGetReponse : " + e.toString());
    }

    return _completer.future;
  }

  Future<DnaGetCoinbaseAddrResponse> getDnaGetCoinbaseAddr() async {
    DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponse;
    Map<String, dynamic> mapParams;

    Completer<DnaGetCoinbaseAddrResponse> _completer =
        new Completer<DnaGetCoinbaseAddrResponse>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(dnaGetCoinbaseAddrResponse);
      return _completer.future;
    }

    mapParams = {
      'method': DnaGetCoinbaseAddrRequest.METHOD_NAME,
      'params': [],
      'id': 101,
      'key': keyApp
    };

    try {
      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaGetCoinbaseAddrResponse =
            dnaGetCoinbaseAddrResponseFromJson(response.text);
      }
    } catch (e) {
      logger.e(e.toString());
      dnaGetCoinbaseAddrResponse = new DnaGetCoinbaseAddrResponse();
      dnaGetCoinbaseAddrResponse.result =
          await sl.get<SharedPrefsUtil>().getAddress();
    }

    _completer.complete(dnaGetCoinbaseAddrResponse);

    return _completer.future;
  }

  Future<DnaIdentityResponse> getDnaIdentity(String address) async {
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
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (await NodeUtil().getNodeType() == PUBLIC_NODE) {
      if (url.isAbsolute == false) {
        _completer.complete(dnaIdentityResponse);
        return _completer.future;
      }

      mapParams = {
        'method': DnaIdentityRequest.METHOD_NAME,
        'params': [address],
        'id': 101,
      };
    } else {
      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(dnaIdentityResponse);
        return _completer.future;
      }

      mapParams = {
        'method': DnaIdentityRequest.METHOD_NAME,
        'params': [address],
        'id': 101,
        'key': keyApp
      };
    }

    try {
      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaIdentityResponse = dnaIdentityResponseFromJson(response.text);
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

    Map<String, dynamic> mapParams;

    Completer<DnaGetEpochResponse> _completer =
        new Completer<DnaGetEpochResponse>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(dnaGetEpochResponse);
      return _completer.future;
    }

    mapParams = {
      'method': DnaGetEpochRequest.METHOD_NAME,
      'params': [],
      'id': 101,
      'key': keyApp
    };

    try {
      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaGetEpochResponse = dnaGetEpochResponseFromJson(response.text);
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(dnaGetEpochResponse);

    return _completer.future;
  }

  Future<DnaCeremonyIntervalsResponse> getDnaCeremonyIntervals() async {
    DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponse;

    Map<String, dynamic> mapParams;

    Completer<DnaCeremonyIntervalsResponse> _completer =
        new Completer<DnaCeremonyIntervalsResponse>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(dnaCeremonyIntervalsResponse);
      return _completer.future;
    }

    mapParams = {
      'method': DnaCeremonyIntervalsRequest.METHOD_NAME,
      'params': [],
      'id': 101,
      'key': keyApp
    };

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(dnaCeremonyIntervalsResponse);
      return _completer.future;
    }

    try {
      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaCeremonyIntervalsResponse =
            dnaCeremonyIntervalsResponseFromJson(response.text);
        if (dnaCeremonyIntervalsResponse.result == null) {
          dnaCeremonyIntervalsResponse.result =
              new DnaCeremonyIntervalsResponseResult();
          dnaCeremonyIntervalsResponse.result.flipLotteryDuration =
              DM_CEREMONY_INTERVALS_FLIP_LOTTERY_DURATION;
          dnaCeremonyIntervalsResponse.result.longSessionDuration =
              DM_CEREMONY_INTERVALS_LONG_SESSION_DURATION;
          dnaCeremonyIntervalsResponse.result.shortSessionDuration =
              DM_CEREMONY_INTERVALS_SHORT_SESSION_DURATION;
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(dnaCeremonyIntervalsResponse);

    return _completer.future;
  }

  Future<String> getCurrentPeriod() async {
    String currentPeriod = "";
    Completer<String> _completer = new Completer<String>();

    Map<String, dynamic> mapParams;

    try {
      DnaGetEpochResponse dnaGetEpochResponse;

      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(currentPeriod);
        return _completer.future;
      }

      mapParams = {
        'method': DnaGetEpochRequest.METHOD_NAME,
        'params': [],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaGetEpochResponse = dnaGetEpochResponseFromJson(response.text);
        if (dnaGetEpochResponse.result != null) {
          currentPeriod = dnaGetEpochResponse.result.currentPeriod;
        } else {
          currentPeriod = EpochPeriod.None;
        }
      }
    } catch (e) {
      logger.e(e.toString());
      currentPeriod = EpochPeriod.None;
    }

    _completer.complete(currentPeriod);
    return _completer.future;
  }

  Future<DnaBecomeOnlineResponse> becomeOnline() async {
    DnaBecomeOnlineResponse dnaBecomeOnlineResponse;

    Map<String, dynamic> mapParams;

    Completer<DnaBecomeOnlineResponse> _completer =
        new Completer<DnaBecomeOnlineResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(dnaBecomeOnlineResponse);
        return _completer.future;
      }

      mapParams = {
        'method': DnaBecomeOnlineRequest.METHOD_NAME,
        "params": [
          {"nonce": null, "epoch": null}
        ],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaBecomeOnlineResponse =
            dnaBecomeOnlineResponseFromJson(response.text);
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(dnaBecomeOnlineResponse);
    return _completer.future;
  }

  Future<DnaBecomeOfflineResponse> becomeOffline() async {
    DnaBecomeOfflineResponse dnaBecomeOffLineResponse;

    Map<String, dynamic> mapParams;

    Completer<DnaBecomeOfflineResponse> _completer =
        new Completer<DnaBecomeOfflineResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(dnaBecomeOffLineResponse);
        return _completer.future;
      }

      mapParams = {
        'method': DnaBecomeOfflineRequest.METHOD_NAME,
        "params": [
          {"nonce": null, "epoch": null}
        ],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaBecomeOffLineResponse =
            dnaBecomeOfflineResponseFromJson(response.text);
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(dnaBecomeOffLineResponse);
    return _completer.future;
  }

  Future<DnaSendTransactionResponse> sendTip(
      String from, String amount, String seed) async {
    DnaSendTransactionResponse dnaSendTransactionResponse;
    Completer<DnaSendTransactionResponse> _completer =
        new Completer<DnaSendTransactionResponse>();

    dnaSendTransactionResponse = await sendTx(
        from, amount, "0xf429e36D68BE10428D730784391589572Ee0f72B", seed, null);

    _completer.complete(dnaSendTransactionResponse);
    return _completer.future;
  }

  Future<DnaSendTransactionResponse> sendTx(String from, String amount,
      String to, String privateKey, String payload) async {
    DnaSendTransactionResponse dnaSendTransactionResponse;

    Map<String, dynamic> mapParams;

    Completer<DnaSendTransactionResponse> _completer =
        new Completer<DnaSendTransactionResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(dnaSendTransactionResponse);

        EventTaxiImpl.singleton()
            .fire(TransactionSendEvent(response: "Connection error"));

        return _completer.future;
      }

      if (payload != null && payload.trim().isEmpty == false) {
        String payloadHex =
            AppHelpers.toHexString(toBuffer(payload), true);
        mapParams = {
          'method': DnaSendTransactionRequest.METHOD_NAME,
          "params": [
            {"from": from, "to": to, 'amount': amount, 'payload': payloadHex}
          ],
          'id': 101,
          'key': keyApp
        };
      } else {
        mapParams = {
          'method': DnaSendTransactionRequest.METHOD_NAME,
          "params": [
            {"from": from, "to": to, 'amount': amount}
          ],
          'id': 101,
          'key': keyApp
        };
      }

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaSendTransactionResponse =
            dnaSendTransactionResponseFromJson(response.text);

        if (dnaSendTransactionResponse.error != null) {
          EventTaxiImpl.singleton().fire(TransactionSendEvent(
              response: dnaSendTransactionResponse.error.message));
        } else {
          EventTaxiImpl.singleton()
              .fire(TransactionSendEvent(response: "Success"));
        }
      } else {
        EventTaxiImpl.singleton()
            .fire(TransactionSendEvent(response: response.reason));
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
    BcnSyncingResponse bcnSyncingResponse;

    Map<String, dynamic> mapParams;

    Completer<BcnSyncingResponse> _completer =
        new Completer<BcnSyncingResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(bcnSyncingResponse);
        return _completer.future;
      }

      mapParams = {
        'method': BcnSyncingRequest.METHOD_NAME,
        'params': [],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        bcnSyncingResponse = bcnSyncingResponseFromJson(response.text);
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
    BcnMempoolResponse bcnMempoolResponse;

    Map<String, dynamic> mapParams;

    Completer<BcnMempoolResponse> _completer =
        new Completer<BcnMempoolResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(bcnMempoolResponse);
        return _completer.future;
      }

      mapParams = {
        'method': BcnMempoolRequest.METHOD_NAME,
        "params": [address],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        bcnMempoolResponse = bcnMempoolResponseFromJson(response.text);
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(bcnMempoolResponse);
    return _completer.future;
  }

  Future<BcnTransactionResponse> getTransaction(
      String hash, String address) async {
    BcnTransactionResponse bcnTransactionResponse;

    Map<String, dynamic> mapParams;

    Completer<BcnTransactionResponse> _completer =
        new Completer<BcnTransactionResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(bcnTransactionResponse);
        return _completer.future;
      }

      mapParams = {
        'method': BcnTransactionRequest.METHOD_NAME,
        "params": [hash],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        bcnTransactionResponse = bcnTransactionResponseFromJson(response.text);
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
    BcnSendRawTxResponse bcnSendRawTxResponse;

    Map<String, dynamic> mapParams;

    Completer<BcnSendRawTxResponse> _completer =
        new Completer<BcnSendRawTxResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(bcnSendRawTxResponse);
        return _completer.future;
      }

      //print("transaction.toHex : " + rawTxSigned);
      mapParams = {
        'method': BcnSendRawTxRequest.METHOD_NAME,
        "params": [rawTxSigned],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        bcnSendRawTxResponse = bcnSendRawTxResponseFromJson(response.text);

        if (bcnSendRawTxResponse.error != null) {
          EventTaxiImpl.singleton().fire(TransactionSendEvent(
              response: bcnSendRawTxResponse.error.message));
        } else {
          EventTaxiImpl.singleton()
              .fire(TransactionSendEvent(response: "Success"));
        }
      } else {
        EventTaxiImpl.singleton()
            .fire(TransactionSendEvent(response: response.reason));
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(bcnSendRawTxResponse);
    return _completer.future;
  }

  Future<DnaActivateInviteResponse> activateInvitation(
      String key, String address) async {
    DnaActivateInviteResponse dnaActivateInviteResponse;

    Map<String, dynamic> mapParams;

    Completer<DnaActivateInviteResponse> _completer =
        new Completer<DnaActivateInviteResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(dnaActivateInviteResponse);
        return _completer.future;
      }

      mapParams = {
        'method': DnaActivateInviteRequest.METHOD_NAME,
        "params": [
          {"key": key, "to": address}
        ],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaActivateInviteResponse =
            dnaActivateInviteResponseFromJson(response.text);
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(dnaActivateInviteResponse);
    return _completer.future;
  }

  Future<DnaSendInviteResponse> sendInvitation(
      String address, String amount, int nonce, int epoch) async {
    DnaSendInviteResponse dnaSendInviteResponse;

    Map<String, dynamic> mapParams;

    Completer<DnaSendInviteResponse> _completer =
        new Completer<DnaSendInviteResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(dnaSendInviteResponse);
        return _completer.future;
      }

      mapParams = {
        'method': DnaSendInviteRequest.METHOD_NAME,
        'params': [
          {'to': address, 'amount': amount, 'nonce': nonce, 'epoch': epoch}
        ],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaSendInviteResponse = dnaSendInviteResponseFromJson(response.text);
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(dnaSendInviteResponse);
    return _completer.future;
  }

  Future<DeepLinkParamSignin> signin(
      DeepLinkParamSignin deepLinkParam, String privateKey) async {
    DnaSignInResponse dnaSignInResponse;

    Completer<DeepLinkParamSignin> _completer =
        new Completer<DeepLinkParamSignin>();

    Map<String, dynamic> mapParams;

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(deepLinkParam);
        return _completer.future;
      }

      mapParams = {
        'method': DnaSignInRequest.METHOD_NAME,
        "params": [deepLinkParam.nonce != null ? deepLinkParam.nonce : ""],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        dnaSignInResponse = dnaSignInResponseFromJson(response.text);
        deepLinkParam.signature = dnaSignInResponse.result;
      }
    } catch (e) {
      logger.e(e.toString());
    }
    //print("signature: " + deepLinkParam.signature);
    _completer.complete(deepLinkParam);
    return _completer.future;
  }

  Future<int> getFeePerGas() async {
    int feePerGas = 0;
    Completer<int> _completer = new Completer<int>();

    Map<String, dynamic> mapParams;

    try {
      BcnFeePerGasResponse bcnFeePerGasResponse;

      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(feePerGas);
        return _completer.future;
      }

      mapParams = {
        'method': BcnFeePerGasRequest.METHOD_NAME,
        'params': [],
        'id': 101,
        'key': keyApp
      };

      SSHClientStatus sshClientStatus;
      sshClientStatus = await sl.get<VpsUtil>().connectVps(url.toString(), keyApp);
      if (sshClientStatus.sshClientStatus) {
        sshClient = sshClientStatus.sshClient;
      }
      var response = await ssh.HttpClientImpl(
              clientFactory: () => ssh.SSHTunneledBaseClient(sshClientStatus.sshClient))
          .request(url.toString(),
              method: 'POST',
              data: jsonEncode(mapParams),
              headers: requestHeaders);
      if (response.status == 200) {
        bcnFeePerGasResponse = bcnFeePerGasResponseFromJson(response.text);

        feePerGas = bcnFeePerGasResponse.result;
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(feePerGas);

    return _completer.future;
  }
}
