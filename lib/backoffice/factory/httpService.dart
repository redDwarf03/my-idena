import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:convert/convert.dart';
import 'package:my_idena/backoffice/bean/bcn_syncing_request.dart';
import 'package:my_idena/backoffice/bean/bcn_syncing_response.dart';
import 'package:my_idena/backoffice/bean/bcn_transactions_request.dart';
import 'package:my_idena/backoffice/bean/bcn_transactions_response.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/bean/dna_becomeOnline_response.dart';
import 'package:my_idena/backoffice/bean/dna_becomeOffline_request.dart';
import 'package:my_idena/backoffice/bean/dna_becomeOffline_response.dart';
import 'package:my_idena/backoffice/bean/dna_becomeOnline_request.dart';
import 'package:my_idena/backoffice/bean/dna_ceremonyIntervals_request.dart';
import 'package:my_idena/backoffice/bean/dna_ceremonyIntervals_response.dart';
import 'package:my_idena/backoffice/bean/dna_getBalance_request.dart';
import 'package:my_idena/backoffice/bean/dna_getBalance_response.dart';
import 'package:my_idena/backoffice/bean/dna_getCoinbaseAddr_request.dart';
import 'package:my_idena/backoffice/bean/dna_getCoinbaseAddr_response.dart';
import 'package:my_idena/backoffice/bean/dna_getEpoch_request.dart';
import 'package:my_idena/backoffice/bean/dna_getEpoch_response.dart';
import 'package:my_idena/backoffice/bean/dna_getFlipRaw_request.dart';
import 'package:my_idena/backoffice/bean/dna_getFlipRaw_response.dart';
import 'package:my_idena/backoffice/bean/dna_identity_request.dart';
import 'package:my_idena/backoffice/bean/dna_identity_response.dart';
import 'package:my_idena/backoffice/bean/dna_sendTransaction_request.dart';
import 'package:my_idena/backoffice/bean/dna_sendTransaction_response.dart';
import 'package:my_idena/backoffice/bean/dna_signin_request.dart';
import 'package:my_idena/backoffice/bean/dna_signin_response.dart';
import 'package:my_idena/backoffice/bean/flip_submit_request.dart';
import 'package:my_idena/backoffice/bean/flip_submit_response.dart';
import 'package:my_idena/beans/deepLinkParam.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/utils/crypto/rlp.dart';
import 'package:my_idena/utils/util_demo_mode.dart';
import 'package:http/http.dart' as http;
import 'package:my_idena/utils/util_public_node.dart';

Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
};
String body;
http.Response responseHttp;
Map<String, dynamic> mapParams;

class HttpService {
  var logger = Logger();
  bool demoMode = false;

  Future<bool> checkConnection(apiUrl, keyApp) async {
    if (getDemoModeStatus()) {
      return true;
    }

    HttpClient httpClient = new HttpClient();
    try {
      if (apiUrl == null || keyApp == null || apiUrl == "" || keyApp == "") {
        return false;
      }
      bool _validURL = Uri.parse(apiUrl).isAbsolute;
      if (!_validURL) {
        return false;
      }
      HttpClientRequest request = await httpClient
          .postUrl(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 5), onTimeout: () {
        return null;
      });
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> mapGetIdentity = {
        'method': DnaIdentityRequest.METHOD_NAME,
        'params': [],
        'id': 101,
        'key': keyApp
      };

      DnaIdentityRequest dnaIdentityRequest =
          DnaIdentityRequest.fromJson(mapGetIdentity);
      request.add(utf8.encode(json.encode(dnaIdentityRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        if (dnaIdentityResponseFromJson(reply).result == null) {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      httpClient.close();
    }
  }

  Future<DnaGetBalanceResponse> getDnaGetBalance(
      Uri url, String keyApp) async {
    DnaGetBalanceRequest dnaGetBalanceRequest;
    DnaGetBalanceResponse dnaGetBalanceResponse;

      mapParams = {
        'method': DnaGetBalanceRequest.METHOD_NAME,
        'params': [idenaAddress],
        'id': 101,
        'key': keyApp
      };

      try {
        dnaGetBalanceRequest = DnaGetBalanceRequest.fromJson(mapParams);
        body = json.encode(dnaGetBalanceRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          dnaGetBalanceResponse =
              dnaGetBalanceResponseFromJson(responseHttp.body);
        }
      } catch (e) {
        logger.e(e.toString());
      }
    

    return dnaGetBalanceResponse;
  }

  Future<DnaIdentityResponse> getDnaIdentity(
      Uri url, String keyApp) async {
    DnaIdentityRequest dnaIdentityRequest;
    DnaIdentityResponse dnaIdentityResponse;
  
      mapParams = {
        'method': DnaIdentityRequest.METHOD_NAME,
        'params': [idenaAddress],
        'id': 101,
        'key': keyApp
      };

      try {
        dnaIdentityRequest = DnaIdentityRequest.fromJson(mapParams);
        body = json.encode(dnaIdentityRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          dnaIdentityResponse = dnaIdentityResponseFromJson(responseHttp.body);
        }
      } catch (e) {
        logger.e(e.toString());
      }
    

    return dnaIdentityResponse;
  }

  Future<DnaGetEpochResponse> getDnaGetEpoch(Uri url, String keyApp) async {
    DnaGetEpochRequest dnaGetEpochRequest;
    DnaGetEpochResponse dnaGetEpochResponse;

    mapParams = {
      'method': DnaGetEpochRequest.METHOD_NAME,
      'params': [],
      'id': 101,
      'key': keyApp
    };

    try {
      dnaGetEpochRequest = DnaGetEpochRequest.fromJson(mapParams);
      body = json.encode(dnaGetEpochRequest.toJson());
      responseHttp = await http.post(url, body: body, headers: requestHeaders);
      if (responseHttp.statusCode == 200) {
        dnaGetEpochResponse = dnaGetEpochResponseFromJson(responseHttp.body);
      }
    } catch (e) {
      logger.e(e.toString());
    }

    return dnaGetEpochResponse;
  }

  Future<DnaCeremonyIntervalsResponse> getDnaCeremonyIntervals(
      Uri url, String keyApp) async {
    DnaCeremonyIntervalsRequest dnaCeremonyIntervalsRequest;
    DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponse;

    mapParams = {
      'method': DnaCeremonyIntervalsRequest.METHOD_NAME,
      'params': [],
      'id': 101,
      'key': keyApp
    };

    try {
      dnaCeremonyIntervalsRequest =
          DnaCeremonyIntervalsRequest.fromJson(mapParams);
      body = json.encode(dnaCeremonyIntervalsRequest.toJson());
      responseHttp = await http.post(url, body: body, headers: requestHeaders);
      if (responseHttp.statusCode == 200) {
        dnaCeremonyIntervalsResponse =
            dnaCeremonyIntervalsResponseFromJson(responseHttp.body);
      }
    } catch (e) {
      logger.e(e.toString());
    }

    return dnaCeremonyIntervalsResponse;
  }

  Future<DnaGetCoinbaseAddrResponse> getDnaGetCoinbaseAddr(
      Uri url, String keyApp) async {
    DnaGetCoinbaseAddrRequest dnaGetCoinbaseAddrRequest;
    DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponse;

    mapParams = {
      'method': DnaGetCoinbaseAddrRequest.METHOD_NAME,
      'params': [],
      'id': 101,
      'key': keyApp
    };

    try {
      dnaGetCoinbaseAddrRequest = DnaGetCoinbaseAddrRequest.fromJson(mapParams);
      body = json.encode(dnaGetCoinbaseAddrRequest.toJson());
      responseHttp = await http.post(url, body: body, headers: requestHeaders);
      if (responseHttp.statusCode == 200) {
        dnaGetCoinbaseAddrResponse =
            dnaGetCoinbaseAddrResponseFromJson(responseHttp.body);
      }
    } catch (e) {
      logger.e(e.toString());
    }

    return dnaGetCoinbaseAddrResponse;
  }

  DnaAll populateDemo() {
    DnaAll _dnaAll = new DnaAll();
    DnaGetCoinbaseAddrResponse _dnaGetCoinbaseAddrResponse;
    DnaIdentityResponse _dnaIdentityResponse;
    DnaGetBalanceResponse _dnaGetBalanceResponse;
    DnaGetEpochResponse _dnaGetEpochResponse;
    DnaCeremonyIntervalsResponse _dnaCeremonyIntervalsResponse;
    _dnaGetCoinbaseAddrResponse = new DnaGetCoinbaseAddrResponse();
    _dnaGetCoinbaseAddrResponse.result = DM_IDENTITY_ADDRESS;
    _dnaIdentityResponse = new DnaIdentityResponse();
    _dnaIdentityResponse.result = DnaIdentityResponseResult();
    _dnaIdentityResponse.result.address = DM_IDENTITY_ADDRESS;
    _dnaIdentityResponse.result.age = DM_IDENTITY_AGE;
    _dnaIdentityResponse.result.state = DM_IDENTITY_STATE;
    _dnaIdentityResponse.result.online = DM_IDENTITY_ONLINE;
    _dnaIdentityResponse.result.flips = new List(DM_IDENTITY_MADE_FLIPS);
    _dnaIdentityResponse.result.availableFlips =
        DM_IDENTITY_REQUIRED_FLIPS - DM_IDENTITY_MADE_FLIPS;
    _dnaIdentityResponse.result.madeFlips = DM_IDENTITY_MADE_FLIPS;
    _dnaIdentityResponse.result.requiredFlips = DM_IDENTITY_REQUIRED_FLIPS;
    _dnaIdentityResponse.result.penalty = DM_IDENTITY_PENALTY;
    _dnaIdentityResponse.result.totalQualifiedFlips =
        DM_IDENTITY_TOTAL_QUALIFIED_FLIPS;
    _dnaIdentityResponse.result.totalShortFlipPoints =
        DM_IDENTITY_TOTAL_SHORT_FLIP_POINTS;
    List<int> _listWords1 = [DM_IDENTITY_KEYWORD_1, DM_IDENTITY_KEYWORD_2];
    _dnaIdentityResponse.result.flipKeyWordPairs = new List<FlipKeyWordPair>();
    _dnaIdentityResponse.result.flipKeyWordPairs
        .add(new FlipKeyWordPair(id: 1, words: _listWords1, used: false));
    List<int> _listWords2 = [DM_IDENTITY_KEYWORD_3, DM_IDENTITY_KEYWORD_4];
    _dnaIdentityResponse.result.flipKeyWordPairs
        .add(new FlipKeyWordPair(id: 1, words: _listWords2, used: false));

    _dnaGetBalanceResponse = new DnaGetBalanceResponse();
    _dnaGetBalanceResponse.result = new DnaGetBalanceResponseResult();
    _dnaGetBalanceResponse.result.balance = DM_PORTOFOLIO_MAIN;
    _dnaGetBalanceResponse.result.stake = DM_PORTOFOLIO_STAKE;

    _dnaGetEpochResponse = new DnaGetEpochResponse();
    _dnaGetEpochResponse.result = new DnaGetEpochResponseResult();
    _dnaGetEpochResponse.result.currentPeriod = DM_EPOCH_CURRENT_PERIOD;
    _dnaGetEpochResponse.result.epoch = DM_EPOCH_EPOCH;
    _dnaGetEpochResponse.result.nextValidation = DM_EPOCH_NEXT_VALIDATION;

    _dnaCeremonyIntervalsResponse = new DnaCeremonyIntervalsResponse();
    _dnaCeremonyIntervalsResponse.result =
        new DnaCeremonyIntervalsResponseResult();
    _dnaCeremonyIntervalsResponse.result.flipLotteryDuration =
        DM_CEREMONY_INTERVALS_FLIP_LOTTERY_DURATION;
    _dnaCeremonyIntervalsResponse.result.longSessionDuration =
        DM_CEREMONY_INTERVALS_LONG_SESSION_DURATION;
    _dnaCeremonyIntervalsResponse.result.shortSessionDuration =
        DM_CEREMONY_INTERVALS_SHORT_SESSION_DURATION;

    _dnaAll.dnaGetCoinbaseAddrResponse = _dnaGetCoinbaseAddrResponse;
    _dnaAll.dnaIdentityResponse = _dnaIdentityResponse;
    _dnaAll.dnaGetBalanceResponse = _dnaGetBalanceResponse;
    _dnaAll.dnaGetEpochResponse = _dnaGetEpochResponse;
    _dnaAll.dnaCeremonyIntervalsResponse = _dnaCeremonyIntervalsResponse;

    return _dnaAll;
  }

  Future<DnaBecomeOnlineResponse> becomeOnline() async {
    DnaBecomeOnlineResponse dnaBecomeOnlineResponse;
    HttpClient httpClient = new HttpClient();
    try {
      if (getDemoModeStatus()) {
        return dnaBecomeOnlineResponse;
      }
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': DnaBecomeOnlineRequest.METHOD_NAME,
        "params": [
          {"nonce": null, "epoch": null}
        ],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      DnaBecomeOnlineRequest dnaBecomeOnlineRequest =
          DnaBecomeOnlineRequest.fromJson(map);
      request.add(utf8.encode(json.encode(dnaBecomeOnlineRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaBecomeOnlineResponse = dnaBecomeOnlineResponseFromJson(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
    return dnaBecomeOnlineResponse;
  }

  Future<DnaBecomeOfflineResponse> becomeOffline() async {
    DnaBecomeOfflineResponse dnaBecomeOfflineResponse;
    HttpClient httpClient = new HttpClient();

    if (getDemoModeStatus()) {
      return dnaBecomeOfflineResponse;
    }
    try {
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': DnaBecomeOfflineRequest.METHOD_NAME,
        "params": [
          {"nonce": null, "epoch": null}
        ],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      DnaBecomeOfflineRequest dnaBecomeOfflineRequest =
          DnaBecomeOfflineRequest.fromJson(map);
      request.add(utf8.encode(json.encode(dnaBecomeOfflineRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaBecomeOfflineResponse = dnaBecomeOfflineResponseFromJson(reply);
      }
    } catch (e) {} finally {
      httpClient.close();
    }
    return dnaBecomeOfflineResponse;
  }

  Future<GetFlipRawResponse> getFlipRaw(String hash) async {
    GetFlipRawResponse getFlipRawResponse;
    HttpClient httpClient = new HttpClient();
    try {
      // get Flip Raw
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': GetFlipRawRequest.METHOD_NAME,
        'params': [hash],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };

      GetFlipRawRequest getFlipRawRequest = GetFlipRawRequest.fromJson(map);
      request.add(utf8.encode(json.encode(getFlipRawRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        getFlipRawResponse = getFlipRawResponseFromJson(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
    return getFlipRawResponse;
  }

  Future<DnaSendTransactionResponse> sendTransaction(
      String from, double amount) async {
    DnaSendTransactionResponse dnaSendTransactionResponse;
    if (amount <= 0) {
      return null;
    }

    HttpClient httpClient = new HttpClient();
    try {
    
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': DnaSendTransactionRequest.METHOD_NAME,
        "params": [
          {
            "from": from,
            "to": "0xf429e36D68BE10428D730784391589572Ee0f72B",
            'amount': amount.toString()
          }
        ],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      DnaSendTransactionRequest dnaSendTransactionRequest =
          DnaSendTransactionRequest.fromJson(map);
      request.add(utf8.encode(json.encode(dnaSendTransactionRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaSendTransactionResponse = dnaSendTransactionResponseFromJson(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
    return dnaSendTransactionResponse;
  }

  Future<BcnTransactionsResponse> getTransactions(
      String address, int count) async {
    BcnTransactionsResponse bcnTransactionsResponse;
    HttpClient httpClient = new HttpClient();
    try {
      if (getDemoModeStatus()) {
        bcnTransactionsResponse = new BcnTransactionsResponse();
        bcnTransactionsResponse.result = new BcnTransactionsResponseResult();

        return bcnTransactionsResponse;
      }

      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': BcnTransactionsRequest.METHOD_NAME,
        "params": [
          {"address": address, "count": count}
        ],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      BcnTransactionsRequest bcnTransactionsRequest =
          BcnTransactionsRequest.fromJson(map);
      request.add(utf8.encode(json.encode(bcnTransactionsRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();

        bcnTransactionsResponse = bcnTransactionsResponseFromJson(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
    return bcnTransactionsResponse;
  }

  Future<DeepLinkParam> signin(deepLinkParam) async {
    DnaSignInResponse dnaSignInResponse;
    HttpClient httpClient = new HttpClient();
    try {
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': DnaSignInRequest.METHOD_NAME,
        "params": [deepLinkParam.nonce != null ? deepLinkParam.nonce : ""],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      DnaSignInRequest dnaSignInRequest = DnaSignInRequest.fromJson(map);
      request.add(utf8.encode(json.encode(dnaSignInRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaSignInResponse = dnaSignInResponseFromJson(reply);
        deepLinkParam.signature = dnaSignInResponse.result;
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
    return deepLinkParam;
  }

  Future<String> getCurrentPeriod() async {
    String currentPeriod;
    HttpClient httpClient = new HttpClient();
    try {
      DnaGetEpochRequest dnaGetEpochRequest;
      DnaGetEpochResponse dnaGetEpochResponse;
      if (getDemoModeStatus()) {
        currentPeriod = DM_EPOCH_CURRENT_PERIOD;
        return currentPeriod;
      }

      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> mapGetEpoch = {
        'method': DnaGetEpochRequest.METHOD_NAME,
        'params': [],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };

      dnaGetEpochRequest = DnaGetEpochRequest.fromJson(mapGetEpoch);
      request.add(utf8.encode(json.encode(dnaGetEpochRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaGetEpochResponse = dnaGetEpochResponseFromJson(reply);
        currentPeriod = dnaGetEpochResponse.result.currentPeriod;
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
    return currentPeriod;
  }

  Future<BcnSyncingResponse> checkSync() async {
    HttpClient httpClient = new HttpClient();

    BcnSyncingRequest bcnSyncingRequest;
    BcnSyncingResponse bcnSyncingResponse;
    try {
      if (getDemoModeStatus() ||
          getPublicNode()) {
        bcnSyncingResponse = new BcnSyncingResponse();
        bcnSyncingResponse.result = new BcnSyncingResponseResult();
        bcnSyncingResponse.result.syncing = DM_SYNC_SYNCING;
        bcnSyncingResponse.result.currentBlock = DM_SYNC_CURRENT_BLOCK;
        bcnSyncingResponse.result.highestBlock = DM_SYNC_HIGHEST_BLOCK;
        return bcnSyncingResponse;
      }

      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': BcnSyncingRequest.METHOD_NAME,
        'params': [],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };

      bcnSyncingRequest = BcnSyncingRequest.fromJson(map);
      request.add(utf8.encode(json.encode(bcnSyncingRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        bcnSyncingResponse = bcnSyncingResponseFromJson(reply);
      }
    } catch (e) {} finally {
      httpClient.close();
    }
    return bcnSyncingResponse;
  }

  Future<FlipSubmitResponse> submitFlip(List images) async {
    FlipSubmitResponse flipSubmitResponse;
    String publicHex;
    String privateHex;

    List imagesShuffle = images;
    imagesShuffle = images;
    var random = new Random();

    for (var i = imagesShuffle.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = imagesShuffle[i];
      imagesShuffle[i] = imagesShuffle[n];
      imagesShuffle[n] = temp;
    }
    ByteData byteData_1 = await images[0].getByteData();
    Uint8List imageUint8_1 = byteData_1.buffer.asUint8List();
    ByteData byteData_2 = await images[1].getByteData();
    Uint8List imageUint8_2 = byteData_2.buffer.asUint8List();
    ByteData byteData_3 = await images[2].getByteData();
    Uint8List imageUint8_3 = byteData_3.buffer.asUint8List();
    ByteData byteData_4 = await images[3].getByteData();
    Uint8List imageUint8_4 = byteData_4.buffer.asUint8List();

    //
    ByteData byteData_1_shuffle = await imagesShuffle[0].getByteData();
    Uint8List imageUint8_1_shuffle = byteData_1_shuffle.buffer.asUint8List();
    ByteData byteData_2_shuffle = await imagesShuffle[1].getByteData();
    Uint8List imageUint8_2_shuffle = byteData_2_shuffle.buffer.asUint8List();
    ByteData byteData_3_shuffle = await imagesShuffle[2].getByteData();
    Uint8List imageUint8_3_shuffle = byteData_3_shuffle.buffer.asUint8List();
    ByteData byteData_4_shuffle = await imagesShuffle[3].getByteData();
    Uint8List imageUint8_4_shuffle = byteData_4_shuffle.buffer.asUint8List();
    Uint8List image1_2_Uint8 =
        encodeRlp([imageUint8_1_shuffle, imageUint8_2_shuffle]);
    publicHex = hex.encode(image1_2_Uint8);

    Uint8List image3_4_Uint8 = encodeRlp([
      [imageUint8_3_shuffle, imageUint8_4_shuffle],
      "[], [3], [1], [2]",
      "[1], [2], [3], []"
    ]);
    privateHex = hex.encode(image3_4_Uint8);

    HttpClient httpClient = new HttpClient();
    try {
      Map<String, dynamic> map = {
        'method': DnaSendTransactionRequest.METHOD_NAME,
        "params": [
          {"publicHex": publicHex, "privateHex": privateHex, "pairId": 1}
        ],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      FlipSubmitRequest flipSubmitRequest = FlipSubmitRequest.fromJson(map);
      logger.i(new JsonEncoder.withIndent('  ').convert(flipSubmitRequest));

      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(flipSubmitRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        flipSubmitResponse = flipSubmitResponseFromJson(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
    return flipSubmitResponse;
  }
}
