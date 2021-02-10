import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartssh/client.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/bus/events.dart';
import 'package:my_idena/bus/subscribe_event.dart';
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
import 'package:my_idena/network/model/response/bcn_mempool_response.dart';
import 'package:my_idena/network/model/response/bcn_send_raw_tx_response.dart';
import 'package:my_idena/network/model/response/bcn_transaction_response.dart';
import 'package:my_idena/network/model/response/dna_activate_invite_response.dart';
import 'package:my_idena/network/model/response/dna_send_invite_response.dart';
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
import 'package:my_idena/model/transaction.dart' as model;
import 'package:my_idena/network/model/response/simple_price_response.dart';
import 'package:my_idena/network/model/response/simple_price_response_aed.dart';
import 'package:my_idena/network/model/response/simple_price_response_ars.dart';
import 'package:my_idena/network/model/response/simple_price_response_aud.dart';
import 'package:my_idena/network/model/response/simple_price_response_brl.dart';
import 'package:my_idena/network/model/response/simple_price_response_btc.dart';
import 'package:my_idena/network/model/response/simple_price_response_cad.dart';
import 'package:my_idena/network/model/response/simple_price_response_chf.dart';
import 'package:my_idena/network/model/response/simple_price_response_clp.dart';
import 'package:my_idena/network/model/response/simple_price_response_cny.dart';
import 'package:my_idena/network/model/response/simple_price_response_czk.dart';
import 'package:my_idena/network/model/response/simple_price_response_dkk.dart';
import 'package:my_idena/network/model/response/simple_price_response_eur.dart';
import 'package:my_idena/network/model/response/simple_price_response_gbp.dart';
import 'package:my_idena/network/model/response/simple_price_response_hkd.dart';
import 'package:my_idena/network/model/response/simple_price_response_huf.dart';
import 'package:my_idena/network/model/response/simple_price_response_idr.dart';
import 'package:my_idena/network/model/response/simple_price_response_ils.dart';
import 'package:my_idena/network/model/response/simple_price_response_inr.dart';
import 'package:my_idena/network/model/response/simple_price_response_jpy.dart';
import 'package:my_idena/network/model/response/simple_price_response_krw.dart';
import 'package:my_idena/network/model/response/simple_price_response_kwd.dart';
import 'package:my_idena/network/model/response/simple_price_response_mxn.dart';
import 'package:my_idena/network/model/response/simple_price_response_myr.dart';
import 'package:my_idena/network/model/response/simple_price_response_nok.dart';
import 'package:my_idena/network/model/response/simple_price_response_nzd.dart';
import 'package:my_idena/network/model/response/simple_price_response_php.dart';
import 'package:my_idena/network/model/response/simple_price_response_pkr.dart';
import 'package:my_idena/network/model/response/simple_price_response_pln.dart';
import 'package:my_idena/network/model/response/simple_price_response_rub.dart';
import 'package:my_idena/network/model/response/simple_price_response_sar.dart';
import 'package:my_idena/network/model/response/simple_price_response_sek.dart';
import 'package:my_idena/network/model/response/simple_price_response_sgd.dart';
import 'package:my_idena/network/model/response/simple_price_response_thb.dart';
import 'package:my_idena/network/model/response/simple_price_response_try.dart';
import 'package:my_idena/network/model/response/simple_price_response_twd.dart';
import 'package:my_idena/network/model/response/simple_price_response_usd.dart';
import 'package:my_idena/network/model/response/simple_price_response_zar.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/util_demo_mode.dart';
import 'package:http/http.dart' as http;
import 'package:my_idena/util/util_node.dart';
import 'package:my_idena/util/util_vps.dart';
import 'package:dartssh/http.dart' as ssh;
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

    if (await NodeUtil().getNodeType() == DEMO_NODE) {
      dnaGetBalanceResponse = new DnaGetBalanceResponse();
      dnaGetBalanceResponse.result = new DnaGetBalanceResponseResult();
      dnaGetBalanceResponse.result.balance = DM_PORTOFOLIO_MAIN;
      dnaGetBalanceResponse.result.stake = DM_PORTOFOLIO_STAKE;
    } else {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (await NodeUtil().getNodeType() == PUBLIC_NODE) {
        if (url.isAbsolute == false) {
          _completer.complete(dnaGetBalanceResponse);
          return _completer.future;
        }

        mapParams = {
          'method': DnaGetBalanceRequest.METHOD_NAME,
          'params': [address],
          'id': 101,
        };
      } else {
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
      }

      try {
        if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
          sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
          var response = await ssh.HttpClientImpl(
                  clientFactory: () => ssh.SSHTunneledBaseClient(client))
              .request(url.toString(),
                  method: 'POST',
                  data: jsonEncode(mapParams),
                  headers: requestHeaders);
          if (response.status == 200) {
            dnaGetBalanceResponse =
                dnaGetBalanceResponseFromJson(response.text);
          }
        } else {
          dnaGetBalanceRequest = DnaGetBalanceRequest.fromJson(mapParams);
          body = json.encode(dnaGetBalanceRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            dnaGetBalanceResponse =
                dnaGetBalanceResponseFromJson(responseHttp.body);
          }
        }

        if (activeBus) {
          EventTaxiImpl.singleton()
              .fire(SubscribeEvent(response: dnaGetBalanceResponse));
        }
      } catch (e) {
        logger.e(e.toString());
      }
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
    BcnTransactionsRequest bcnTransactionsRequest;
    BcnTransactionsResponse bcnTransactionsResponse;

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(bcnTransactionsResponse);
      return _completer.future;
    }

    if (await NodeUtil().getNodeType() == DEMO_NODE) {
      bcnTransactionsResponse = new BcnTransactionsResponse();
      bcnTransactionsResponse.result = new BcnTransactionsResponseResult();
    } else {
      mapParams = {
        'method': BcnTransactionsRequest.METHOD_NAME,
        "params": [
          {"address": address, "count": count}
        ],
        'id': 101,
        'key': keyApp
      };

      try {
        if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
          sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
          var response = await ssh.HttpClientImpl(
                  clientFactory: () => ssh.SSHTunneledBaseClient(client))
              .request(url.toString(),
                  method: 'POST',
                  data: jsonEncode(mapParams),
                  headers: requestHeaders);
          if (response.status == 200) {
            bcnTransactionsResponse =
                bcnTransactionsResponseFromJson(response.text);
          }
        } else {
          bcnTransactionsRequest = BcnTransactionsRequest.fromJson(mapParams);
          body = json.encode(bcnTransactionsRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            bcnTransactionsResponse =
                bcnTransactionsResponseFromJson(responseHttp.body);
          }
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
          bcnTransactionsResponse.result.transactions = new List.from(
              bcnTransactionsResponse.result.transactions.reversed);
          if (listTxsMempool != null && listTxsMempool.length > 0) {
            bcnTransactionsResponse.result.transactions.addAll(listTxsMempool);
          }
        }
      } catch (e) {
        logger.e(e.toString());
      }
    }

    _completer.complete(bcnTransactionsResponse);

    return _completer.future;
  }

  Future<SimplePriceResponse> getSimplePrice(String currency) async {
    SimplePriceResponse simplePriceResponse = new SimplePriceResponse();
    simplePriceResponse.currency = currency;

    HttpClient httpClient = new HttpClient();
    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://api.coingecko.com/api/v3/simple/price?ids=idena&vs_currencies=BTC"));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        SimplePriceBtcResponse simplePriceBtcResponse =
            simplePriceBtcResponseFromJson(reply);
        simplePriceResponse.btcPrice = simplePriceBtcResponse.idena.btc;
      }

      request = await httpClient.getUrl(Uri.parse(
          "https://api.coingecko.com/api/v3/simple/price?ids=idena&vs_currencies=" +
              currency));
      request.headers.set('content-type', 'application/json');
      response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        switch (currency.toUpperCase()) {
          case "ARS":
            SimplePriceArsResponse simplePriceLocalResponse =
                simplePriceArsResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.ars;
            break;
          case "AUD":
            SimplePriceAudResponse simplePriceLocalResponse =
                simplePriceAudResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.aud;
            break;
          case "BRL":
            SimplePriceBrlResponse simplePriceLocalResponse =
                simplePriceBrlResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.brl;
            break;
          case "CAD":
            SimplePriceCadResponse simplePriceLocalResponse =
                simplePriceCadResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.cad;
            break;
          case "CHF":
            SimplePriceChfResponse simplePriceLocalResponse =
                simplePriceChfResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.chf;
            break;
          case "CLP":
            SimplePriceClpResponse simplePriceLocalResponse =
                simplePriceClpResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.clp;
            break;
          case "CNY":
            SimplePriceCnyResponse simplePriceLocalResponse =
                simplePriceCnyResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.cny;
            break;
          case "CZK":
            SimplePriceCzkResponse simplePriceLocalResponse =
                simplePriceCzkResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.czk;
            break;
          case "DKK":
            SimplePriceDkkResponse simplePriceLocalResponse =
                simplePriceDkkResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.dkk;
            break;
          case "EUR":
            SimplePriceEurResponse simplePriceLocalResponse =
                simplePriceEurResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.eur;
            break;
          case "GBP":
            SimplePriceGbpResponse simplePriceLocalResponse =
                simplePriceGbpResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.gbp;
            break;
          case "HKD":
            SimplePriceHkdResponse simplePriceLocalResponse =
                simplePriceHkdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.hkd;
            break;
          case "HUF":
            SimplePriceHufResponse simplePriceLocalResponse =
                simplePriceHufResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.huf;
            break;
          case "IDR":
            SimplePriceIdrResponse simplePriceLocalResponse =
                simplePriceIdrResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.idr;
            break;
          case "ILS":
            SimplePriceIlsResponse simplePriceLocalResponse =
                simplePriceIlsResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.ils;
            break;
          case "INR":
            SimplePriceInrResponse simplePriceLocalResponse =
                simplePriceInrResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.inr;
            break;
          case "JPY":
            SimplePriceJpyResponse simplePriceLocalResponse =
                simplePriceJpyResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.jpy;
            break;
          case "KRW":
            SimplePriceKrwResponse simplePriceLocalResponse =
                simplePriceKrwResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.krw;
            break;
          case "KWD":
            SimplePriceKwdResponse simplePriceLocalResponse =
                simplePriceKwdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.kwd;
            break;
          case "MXN":
            SimplePriceMxnResponse simplePriceLocalResponse =
                simplePriceMxnResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.mxn;
            break;
          case "MYR":
            SimplePriceMyrResponse simplePriceLocalResponse =
                simplePriceMyrResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.myr;
            break;
          case "NOK":
            SimplePriceNokResponse simplePriceLocalResponse =
                simplePriceNokResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.nok;
            break;
          case "NZD":
            SimplePriceNzdResponse simplePriceLocalResponse =
                simplePriceNzdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.nzd;
            break;
          case "PHP":
            SimplePricePhpResponse simplePriceLocalResponse =
                simplePricePhpResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.php;
            break;
          case "PKR":
            SimplePricePkrResponse simplePriceLocalResponse =
                simplePricePkrResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.pkr;
            break;
          case "PLN":
            SimplePricePlnResponse simplePriceLocalResponse =
                simplePricePlnResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.pln;
            break;
          case "RUB":
            SimplePriceRubResponse simplePriceLocalResponse =
                simplePriceRubResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.rub;
            break;
          case "SAR":
            SimplePriceSarResponse simplePriceLocalResponse =
                simplePriceSarResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.sar;
            break;
          case "SEK":
            SimplePriceSekResponse simplePriceLocalResponse =
                simplePriceSekResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.sek;
            break;
          case "SGD":
            SimplePriceSgdResponse simplePriceLocalResponse =
                simplePriceSgdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.sgd;
            break;
          case "THB":
            SimplePriceThbResponse simplePriceLocalResponse =
                simplePriceThbResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.thb;
            break;
          case "TRY":
            SimplePriceTryResponse simplePriceLocalResponse =
                simplePriceTryResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.tryl;
            break;
          case "TWD":
            SimplePriceTwdResponse simplePriceLocalResponse =
                simplePriceTwdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.twd;
            break;
          case "AED":
            SimplePriceAedResponse simplePriceLocalResponse =
                simplePriceAedResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.aed;
            break;
          case "ZAR":
            SimplePriceZarResponse simplePriceLocalResponse =
                simplePriceZarResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.zar;
            break;
          case "USD":
          default:
            SimplePriceUsdResponse simplePriceLocalResponse =
                simplePriceUsdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.idena.usd;
            break;
        }
      }
      // Post to callbacks
      EventTaxiImpl.singleton().fire(PriceEvent(response: simplePriceResponse));
    } catch (e) {} finally {
      httpClient.close();
    }
    return simplePriceResponse;
  }

  Future<bool> getWStatusGetResponse() async {
    DnaIdentityRequest dnaIdentityRequest;

    Map<String, dynamic> mapParams;
    Completer<bool> _completer = new Completer<bool>();

    if (await NodeUtil().getNodeType() == DEMO_NODE) {
      _completer.complete(true);
      return _completer.future;
    }

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url == null ||
        keyApp == null ||
        url.isAbsolute == false ||
        keyApp == "") {
      _completer.complete(false);
      return _completer.future;
    }

    mapParams = {
      'method': DnaIdentityRequest.METHOD_NAME,
      'params': [],
      'id': 101,
      'key': keyApp
    };

    try {
      if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
        sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
        var response = await ssh.HttpClientImpl(
                clientFactory: () => ssh.SSHTunneledBaseClient(client))
            .request(url.toString(),
                method: 'POST',
                data: jsonEncode(mapParams),
                headers: requestHeaders);
        if (response.status == 200) {
          if (dnaIdentityResponseFromJson(response.text).result == null) {
            _completer.complete(false);
          } else {
            _completer.complete(true);
          }
        }
      } else {
        dnaIdentityRequest = DnaIdentityRequest.fromJson(mapParams);
        body = json.encode(dnaIdentityRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          if (dnaIdentityResponseFromJson(responseHttp.body).result == null) {
            _completer.complete(false);
          } else {
            _completer.complete(true);
          }
        }
      }
    } catch (e) {
      _completer.complete(false);
    }

    return _completer.future;
  }

  Future<DnaGetCoinbaseAddrResponse> getDnaGetCoinbaseAddr() async {
    DnaGetCoinbaseAddrRequest dnaGetCoinbaseAddrRequest;
    DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponse;
    Map<String, dynamic> mapParams;

    Completer<DnaGetCoinbaseAddrResponse> _completer =
        new Completer<DnaGetCoinbaseAddrResponse>();

    if (await NodeUtil().getNodeType() == DEMO_NODE) {
      dnaGetCoinbaseAddrResponse.result = DM_IDENTITY_ADDRESS;
    } else {
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
        if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
          sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
          var response = await ssh.HttpClientImpl(
                  clientFactory: () => ssh.SSHTunneledBaseClient(client))
              .request(url.toString(),
                  method: 'POST',
                  data: jsonEncode(mapParams),
                  headers: requestHeaders);
          if (response.status == 200) {
            dnaGetCoinbaseAddrResponse =
                dnaGetCoinbaseAddrResponseFromJson(response.text);
          }
        } else {
          dnaGetCoinbaseAddrRequest =
              DnaGetCoinbaseAddrRequest.fromJson(mapParams);
          body = json.encode(dnaGetCoinbaseAddrRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            dnaGetCoinbaseAddrResponse =
                dnaGetCoinbaseAddrResponseFromJson(responseHttp.body);
          }
        }
      } catch (e) {
        logger.e(e.toString());
        dnaGetCoinbaseAddrResponse = new DnaGetCoinbaseAddrResponse();
        dnaGetCoinbaseAddrResponse.result =
            await sl.get<SharedPrefsUtil>().getAddress();
      }
    }
    _completer.complete(dnaGetCoinbaseAddrResponse);

    return _completer.future;
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

    if (await NodeUtil().getNodeType() == DEMO_NODE) {
      dnaIdentityResponse = new DnaIdentityResponse();
      dnaIdentityResponse.result = DnaIdentityResponseResult();
      dnaIdentityResponse.result.address = DM_IDENTITY_ADDRESS;
      dnaIdentityResponse.result.age = DM_IDENTITY_AGE;
      dnaIdentityResponse.result.state = DM_IDENTITY_STATE;
      dnaIdentityResponse.result.online = DM_IDENTITY_ONLINE;
      dnaIdentityResponse.result.flips = new List(DM_IDENTITY_MADE_FLIPS);
      dnaIdentityResponse.result.availableFlips =
          DM_IDENTITY_REQUIRED_FLIPS - DM_IDENTITY_MADE_FLIPS;
      dnaIdentityResponse.result.madeFlips = DM_IDENTITY_MADE_FLIPS;
      dnaIdentityResponse.result.requiredFlips = DM_IDENTITY_REQUIRED_FLIPS;
      dnaIdentityResponse.result.penalty = DM_IDENTITY_PENALTY;
      dnaIdentityResponse.result.invites = DM_INVITES;
      dnaIdentityResponse.result.totalQualifiedFlips =
          DM_IDENTITY_TOTAL_QUALIFIED_FLIPS;
      dnaIdentityResponse.result.totalShortFlipPoints =
          DM_IDENTITY_TOTAL_SHORT_FLIP_POINTS;
      List<int> _listWords1 = [DM_IDENTITY_KEYWORD_1, DM_IDENTITY_KEYWORD_2];
      dnaIdentityResponse.result.flipKeyWordPairs = new List<FlipKeyWordPair>();
      dnaIdentityResponse.result.flipKeyWordPairs
          .add(new FlipKeyWordPair(id: 1, words: _listWords1, used: false));
      List<int> _listWords2 = [DM_IDENTITY_KEYWORD_3, DM_IDENTITY_KEYWORD_4];
      dnaIdentityResponse.result.flipKeyWordPairs
          .add(new FlipKeyWordPair(id: 1, words: _listWords2, used: false));
    } else {
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
        if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
          sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
          var response = await ssh.HttpClientImpl(
                  clientFactory: () => ssh.SSHTunneledBaseClient(client))
              .request(url.toString(),
                  method: 'POST',
                  data: jsonEncode(mapParams),
                  headers: requestHeaders);
          if (response.status == 200) {
            dnaIdentityResponse = dnaIdentityResponseFromJson(response.text);
          }
        } else {
          dnaIdentityRequest = DnaIdentityRequest.fromJson(mapParams);
          body = json.encode(dnaIdentityRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            dnaIdentityResponse =
                dnaIdentityResponseFromJson(responseHttp.body);
          }
        }
      } catch (e) {
        //logger.e(e.toString());
        dnaIdentityResponse = new DnaIdentityResponse();
        dnaIdentityResponse.result = DnaIdentityResponseResult();
        dnaIdentityResponse.result.address = address;
      }
    }
    _completer.complete(dnaIdentityResponse);

    return _completer.future;
  }

  Future<DnaGetEpochResponse> getDnaGetEpoch() async {
    DnaGetEpochRequest dnaGetEpochRequest;
    DnaGetEpochResponse dnaGetEpochResponse;

    Map<String, dynamic> mapParams;

    Completer<DnaGetEpochResponse> _completer =
        new Completer<DnaGetEpochResponse>();

    if (await NodeUtil().getNodeType() == DEMO_NODE) {
      dnaGetEpochResponse = new DnaGetEpochResponse();
      dnaGetEpochResponse.result = new DnaGetEpochResponseResult();
      dnaGetEpochResponse.result.currentPeriod = DM_EPOCH_CURRENT_PERIOD;
      dnaGetEpochResponse.result.epoch = DM_EPOCH_EPOCH;
      dnaGetEpochResponse.result.nextValidation = DM_EPOCH_NEXT_VALIDATION;
    } else {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (await NodeUtil().getNodeType() == PUBLIC_NODE) {
        if (url.isAbsolute == false) {
          _completer.complete(dnaGetEpochResponse);
          return _completer.future;
        }

        mapParams = {
          'method': DnaGetEpochRequest.METHOD_NAME,
          'params': [],
          'id': 101,
        };
      } else {
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
      }

      try {
        if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
          sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
          var response = await ssh.HttpClientImpl(
                  clientFactory: () => ssh.SSHTunneledBaseClient(client))
              .request(url.toString(),
                  method: 'POST',
                  data: jsonEncode(mapParams),
                  headers: requestHeaders);
          if (response.status == 200) {
            dnaGetEpochResponse = dnaGetEpochResponseFromJson(response.text);
          }
        } else {
          dnaGetEpochRequest = DnaGetEpochRequest.fromJson(mapParams);
          body = json.encode(dnaGetEpochRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            dnaGetEpochResponse =
                dnaGetEpochResponseFromJson(responseHttp.body);
          }
        }
      } catch (e) {
        logger.e(e.toString());
      }
    }

    _completer.complete(dnaGetEpochResponse);

    return _completer.future;
  }

  Future<DnaCeremonyIntervalsResponse> getDnaCeremonyIntervals() async {
    DnaCeremonyIntervalsRequest dnaCeremonyIntervalsRequest;
    DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponse;

    Map<String, dynamic> mapParams;

    Completer<DnaCeremonyIntervalsResponse> _completer =
        new Completer<DnaCeremonyIntervalsResponse>();

    if (await NodeUtil().getNodeType() == DEMO_NODE) {
      dnaCeremonyIntervalsResponse = new DnaCeremonyIntervalsResponse();
      dnaCeremonyIntervalsResponse.result =
          new DnaCeremonyIntervalsResponseResult();
      dnaCeremonyIntervalsResponse.result.flipLotteryDuration =
          DM_CEREMONY_INTERVALS_FLIP_LOTTERY_DURATION;
      dnaCeremonyIntervalsResponse.result.longSessionDuration =
          DM_CEREMONY_INTERVALS_LONG_SESSION_DURATION;
      dnaCeremonyIntervalsResponse.result.shortSessionDuration =
          DM_CEREMONY_INTERVALS_SHORT_SESSION_DURATION;
    } else {
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

      try {
        if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
          sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
          var response = await ssh.HttpClientImpl(
                  clientFactory: () => ssh.SSHTunneledBaseClient(client))
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
        } else {
          dnaCeremonyIntervalsRequest =
              DnaCeremonyIntervalsRequest.fromJson(mapParams);
          body = json.encode(dnaCeremonyIntervalsRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            dnaCeremonyIntervalsResponse =
                dnaCeremonyIntervalsResponseFromJson(responseHttp.body);
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
        }
      } catch (e) {
        logger.e(e.toString());
      }
    }

    _completer.complete(dnaCeremonyIntervalsResponse);

    return _completer.future;
  }

  Future<String> getCurrentPeriod() async {
    String currentPeriod = "";
    Completer<String> _completer = new Completer<String>();

    Map<String, dynamic> mapParams;

    try {
      DnaGetEpochRequest dnaGetEpochRequest;
      DnaGetEpochResponse dnaGetEpochResponse;
      if (await NodeUtil().getNodeType() == DEMO_NODE) {
        currentPeriod = DM_EPOCH_CURRENT_PERIOD;
      } else {
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

        if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
          sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
          var response = await ssh.HttpClientImpl(
                  clientFactory: () => ssh.SSHTunneledBaseClient(client))
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
        } else {
          dnaGetEpochRequest = DnaGetEpochRequest.fromJson(mapParams);
          body = json.encode(dnaGetEpochRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            dnaGetEpochResponse =
                dnaGetEpochResponseFromJson(responseHttp.body);
            if (dnaGetEpochResponse.result != null) {
              currentPeriod = dnaGetEpochResponse.result.currentPeriod;
            } else {
              currentPeriod = EpochPeriod.None;
            }
          }
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
    DnaBecomeOnlineRequest dnaBecomeOnlineRequest;

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

      if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
        sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
        var response = await ssh.HttpClientImpl(
                clientFactory: () => ssh.SSHTunneledBaseClient(client))
            .request(url.toString(),
                method: 'POST',
                data: jsonEncode(mapParams),
                headers: requestHeaders);
        if (response.status == 200) {
          dnaBecomeOnlineResponse =
              dnaBecomeOnlineResponseFromJson(response.text);
        }
      } else {
        dnaBecomeOnlineRequest = DnaBecomeOnlineRequest.fromJson(mapParams);
        body = json.encode(dnaBecomeOnlineRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          dnaBecomeOnlineResponse =
              dnaBecomeOnlineResponseFromJson(responseHttp.body);
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(dnaBecomeOnlineResponse);
    return _completer.future;
  }

  Future<DnaBecomeOfflineResponse> becomeOffline() async {
    DnaBecomeOfflineResponse dnaBecomeOffLineResponse;
    DnaBecomeOfflineRequest dnaBecomeOffLineRequest;

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

      if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
        sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
        var response = await ssh.HttpClientImpl(
                clientFactory: () => ssh.SSHTunneledBaseClient(client))
            .request(url.toString(),
                method: 'POST',
                data: jsonEncode(mapParams),
                headers: requestHeaders);
        if (response.status == 200) {
          dnaBecomeOffLineResponse =
              dnaBecomeOfflineResponseFromJson(response.text);
        }
      } else {
        dnaBecomeOffLineRequest = DnaBecomeOfflineRequest.fromJson(mapParams);
        body = json.encode(dnaBecomeOffLineRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          dnaBecomeOffLineResponse =
              dnaBecomeOfflineResponseFromJson(responseHttp.body);
        }
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
        from, amount, "0xf429e36D68BE10428D730784391589572Ee0f72B", seed);

    _completer.complete(dnaSendTransactionResponse);
    return _completer.future;
  }

  Future<DnaSendTransactionResponse> sendTx(
      String from, String amount, String to, String seed) async {
    DnaSendTransactionRequest dnaSendTransactionRequest;
    DnaSendTransactionResponse dnaSendTransactionResponse;

    Map<String, dynamic> mapParams;

    Completer<DnaSendTransactionResponse> _completer =
        new Completer<DnaSendTransactionResponse>();

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(dnaSendTransactionResponse);
        return _completer.future;
      }

      mapParams = {
        'method': DnaSendTransactionRequest.METHOD_NAME,
        "params": [
          {"from": from, "to": to, 'amount': amount}
        ],
        'id': 101,
        'key': keyApp
      };

      if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
        sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
        var response = await ssh.HttpClientImpl(
                clientFactory: () => ssh.SSHTunneledBaseClient(client))
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
              .fire(TransactionSendEvent(response: responseHttp.body));
        }
      } else {
        if (await NodeUtil().getNodeType() == SHARED_NODE ||
            await NodeUtil().getNodeType() == PUBLIC_NODE) {
          int nonce = await getLastNonce(from);
          DnaGetEpochResponse dnaGetEpochResponse = await getDnaGetEpoch();
          int epoch = 0;
          if (dnaGetEpochResponse != null &&
              dnaGetEpochResponse.result != null &&
              dnaGetEpochResponse.result.epoch != null) {
            epoch = dnaGetEpochResponse.result.epoch;
          }
          var amountNumber = 1000000000000000000;
          var maxFee = 1000000000000000000;
          // Create Transaction
          model.Transaction transaction = new model.Transaction(
              nonce + 1, epoch, 0, to, amountNumber, maxFee, null, null);
          print("transaction.toHex() before sign : " + transaction.toHex());
          // Encode a RawTx
          //var rawTxEncoded = ethereum_util.addHexPrefix(transaction.toHex());
          //print("rawTxEncoded: " + rawTxEncoded);

          //transaction = new model.Transaction(
          //        null, null, null, null, null, null, null, null)
          //    .fromHex(rawTxEncoded);
          transaction.sign(seed);
          var rawTxSigned = ethereum_util.addHexPrefix(transaction.toHex());
          print("rawTxSigned : " + rawTxSigned);
          // Sign Raw Tx
          BcnSendRawTxResponse bcnSendRawTxResponse =
              await sendRawTx(rawTxSigned);
          if (bcnSendRawTxResponse.error != null) {
            EventTaxiImpl.singleton().fire(TransactionSendEvent(
                response: bcnSendRawTxResponse.error.message));
          } else {
            EventTaxiImpl.singleton()
                .fire(TransactionSendEvent(response: "Success"));
          }
        } else {
          dnaSendTransactionRequest =
              DnaSendTransactionRequest.fromJson(mapParams);
          body = json.encode(dnaSendTransactionRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            dnaSendTransactionResponse =
                dnaSendTransactionResponseFromJson(responseHttp.body);

            if (dnaSendTransactionResponse.error != null) {
              EventTaxiImpl.singleton().fire(TransactionSendEvent(
                  response: dnaSendTransactionResponse.error.message));
            } else {
              EventTaxiImpl.singleton()
                  .fire(TransactionSendEvent(response: "Success"));
            }
          } else {
            EventTaxiImpl.singleton()
                .fire(TransactionSendEvent(response: responseHttp.body));
          }
        }
      }
    } catch (e) {
      logger.e(e.toString());
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
      if (await NodeUtil().getNodeType() == DEMO_NODE ||
          await NodeUtil().getNodeType() == SHARED_NODE) {
        bcnSyncingResponse = new BcnSyncingResponse();
        bcnSyncingResponse.result = new BcnSyncingResponseResult();
        bcnSyncingResponse.result.syncing = DM_SYNC_SYNCING;
        bcnSyncingResponse.result.currentBlock = DM_SYNC_CURRENT_BLOCK;
        bcnSyncingResponse.result.highestBlock = DM_SYNC_HIGHEST_BLOCK;
      } else {
        Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
        String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

        if (await NodeUtil().getNodeType() == PUBLIC_NODE) {
          if (url.isAbsolute == false) {
            _completer.complete(bcnSyncingResponse);
            return _completer.future;
          }

          mapParams = {
            'method': BcnSyncingRequest.METHOD_NAME,
            'params': [],
            'id': 101,
          };
        } else {
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
        }

        if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
          sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
          var response = await ssh.HttpClientImpl(
                  clientFactory: () => ssh.SSHTunneledBaseClient(client))
              .request(url.toString(),
                  method: 'POST',
                  data: jsonEncode(mapParams),
                  headers: requestHeaders);
          if (response.status == 200) {
            bcnSyncingResponse = bcnSyncingResponseFromJson(response.text);
          }
        } else {
          bcnSyncingRequest = BcnSyncingRequest.fromJson(mapParams);
          body = json.encode(bcnSyncingRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            bcnSyncingResponse = bcnSyncingResponseFromJson(responseHttp.body);
          }
        }
      }
    } catch (e) {}

    _completer.complete(bcnSyncingResponse);
    return _completer.future;
  }

  double getFeesEstimation() {
    // TODO
    //print("getFeesEstimation: " + fees.toString());
    return 0;
  }

  Future<BcnMempoolResponse> getMemPool(String address) async {
    BcnMempoolResponse bcnMempoolResponse;
    BcnMempoolRequest bcnMempoolRequest;

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

      if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
        sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
        var response = await ssh.HttpClientImpl(
                clientFactory: () => ssh.SSHTunneledBaseClient(client))
            .request(url.toString(),
                method: 'POST',
                data: jsonEncode(mapParams),
                headers: requestHeaders);
        if (response.status == 200) {
          bcnMempoolResponse = bcnMempoolResponseFromJson(response.text);
        }
      } else {
        bcnMempoolRequest = BcnMempoolRequest.fromJson(mapParams);
        body = json.encode(bcnMempoolRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          bcnMempoolResponse = bcnMempoolResponseFromJson(responseHttp.body);
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(bcnMempoolResponse);
    return _completer.future;
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
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (await NodeUtil().getNodeType() == PUBLIC_NODE) {
        if (url.isAbsolute == false) {
          _completer.complete(bcnTransactionResponse);
          return _completer.future;
        }

        mapParams = {
          'method': BcnTransactionRequest.METHOD_NAME,
          "params": [hash],
          'id': 101,
        };
      } else {
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
      }

      if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
        sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
        var response = await ssh.HttpClientImpl(
                clientFactory: () => ssh.SSHTunneledBaseClient(client))
            .request(url.toString(),
                method: 'POST',
                data: jsonEncode(mapParams),
                headers: requestHeaders);
        if (response.status == 200) {
          bcnTransactionResponse =
              bcnTransactionResponseFromJson(response.text);
          if (bcnTransactionResponse != null &&
              bcnTransactionResponse.result != null &&
              bcnTransactionResponse.result.from != address) {
            bcnTransactionResponse = null;
          }
        }
      } else {
        bcnTransactionRequest = BcnTransactionRequest.fromJson(mapParams);
        body = json.encode(bcnTransactionRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          bcnTransactionResponse =
              bcnTransactionResponseFromJson(responseHttp.body);
          if (bcnTransactionResponse != null &&
              bcnTransactionResponse.result != null &&
              bcnTransactionResponse.result.from != address) {
            bcnTransactionResponse = null;
          }
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
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(bcnSendRawTxResponse);
        return _completer.future;
      }

      print("transaction.toHex : " + rawTxSigned);
      mapParams = {
        'method': BcnSendRawTxRequest.METHOD_NAME,
        "params": [rawTxSigned],
        'id': 101,
        'key': keyApp
      };

      if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
        sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
        var response = await ssh.HttpClientImpl(
                clientFactory: () => ssh.SSHTunneledBaseClient(client))
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
              .fire(TransactionSendEvent(response: responseHttp.body));
        }
      } else {
        bcnSendRawTxRequest = BcnSendRawTxRequest.fromJson(mapParams);
        body = json.encode(bcnSendRawTxRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          bcnSendRawTxResponse =
              bcnSendRawTxResponseFromJson(responseHttp.body);

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
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(bcnSendRawTxResponse);
    return _completer.future;
  }

  Future<DnaActivateInviteResponse> activateInvitation(String key, String address) async {
    DnaActivateInviteRequest dnaActivateInviteRequest;
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

      if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
        sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
        var response = await ssh.HttpClientImpl(
                clientFactory: () => ssh.SSHTunneledBaseClient(client))
            .request(url.toString(),
                method: 'POST',
                data: jsonEncode(mapParams),
                headers: requestHeaders);
        if (response.status == 200) {
          dnaActivateInviteResponse =
              dnaActivateInviteResponseFromJson(response.text);
        }
      } else {
        dnaActivateInviteRequest = DnaActivateInviteRequest.fromJson(mapParams);
        body = json.encode(dnaActivateInviteRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          dnaActivateInviteResponse =
              dnaActivateInviteResponseFromJson(responseHttp.body);
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(dnaActivateInviteResponse);
    return _completer.future;
  }

  Future<DnaSendInviteResponse> sendInvitation(
      String address, String amount, int nonce, int epoch) async {
    DnaSendInviteRequest dnaSendInviteRequest;
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

      if (await NodeUtil().getNodeType() == NORMAL_VPS_NODE) {
        sshClient = await VpsUtil().connectVps(url.toString(), keyApp);
        var response = await ssh.HttpClientImpl(
                clientFactory: () => ssh.SSHTunneledBaseClient(client))
            .request(url.toString(),
                method: 'POST',
                data: jsonEncode(mapParams),
                headers: requestHeaders);
        if (response.status == 200) {
          dnaSendInviteResponse = dnaSendInviteResponseFromJson(response.text);
        }
      } else {
        dnaSendInviteRequest = DnaSendInviteRequest.fromJson(mapParams);
        body = json.encode(dnaSendInviteRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          dnaSendInviteResponse =
              dnaSendInviteResponseFromJson(responseHttp.body);
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(dnaSendInviteResponse);
    return _completer.future;
  }
}
