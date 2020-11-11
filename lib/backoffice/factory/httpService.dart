import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
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
import 'package:my_idena/utils/util_demo_mode.dart';
import 'package:my_idena/backoffice/factory/sharedPreferencesHelper.dart';
import 'package:http/http.dart' as http;

class HttpService {
  var logger = Logger();
  bool demoMode = false;

  Future<bool> checkConnection(apiUrl, keyApp) async {
    if (await getDemoModeStatus(keyApp)) {
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
/*      final responseHttp = await http
          .get(Uri.encodeFull(apiUrl), headers: {"accept": "application/json"}).timeout(const Duration(seconds: 5), onTimeout: () {return null;});
      if (responseHttp == null || responseHttp.statusCode != 200) {
        return false;
      } else {*/

      // get CoinBase Address
      HttpClientRequest request = await httpClient
          .postUrl(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 5), onTimeout: () {
        return null;
      });
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> mapGetCoinBaseAddress = {
        'method': DnaGetCoinbaseAddrRequest.METHOD_NAME,
        'params': [],
        'id': 101,
        'key': keyApp
      };
      DnaGetCoinbaseAddrRequest dnaGetCoinbaseAddrRequest =
          DnaGetCoinbaseAddrRequest.fromJson(mapGetCoinBaseAddress);
      request.add(utf8.encode(json.encode(dnaGetCoinbaseAddrRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        if (dnaGetCoinbaseAddrResponseFromJson(reply).result == null) {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
      /*}*/

    } catch (e) {
      return false;
    } finally {
      httpClient.close();
    }
  }

  Future<DnaAll> getDnaAll() async {
    DnaGetCoinbaseAddrRequest dnaGetCoinbaseAddrRequest;
    DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponse;
    DnaIdentityRequest dnaIdentityRequest;
    DnaIdentityResponse dnaIdentityResponse;
    DnaGetBalanceRequest dnaGetBalanceRequest;
    DnaGetBalanceResponse dnaGetBalanceResponse;
    DnaGetEpochRequest dnaGetEpochRequest;
    DnaGetEpochResponse dnaGetEpochResponse;
    DnaCeremonyIntervalsRequest dnaCeremonyIntervalsRequest;
    DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponse;
    DnaAll dnaAll = new DnaAll();
    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();
      if (idenaSharedPreferences == null) {
        return null;
      }

      HttpClientResponse response;

      // get CoinBase Address
      if (await getDemoModeStatus(idenaSharedPreferences.keyApp)) {
        dnaGetCoinbaseAddrResponse = new DnaGetCoinbaseAddrResponse();
        dnaGetCoinbaseAddrResponse.result = DM_IDENTITY_ADDRESS;
      } else {
        HttpClientRequest request1 =
            await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
        request1.headers.set('content-type', 'application/json');

        Map<String, dynamic> mapGetCoinBaseAddress = {
          'method': DnaGetCoinbaseAddrRequest.METHOD_NAME,
          'params': [],
          'id': 101,
          'key': idenaSharedPreferences.keyApp
        };
        dnaGetCoinbaseAddrRequest =
            DnaGetCoinbaseAddrRequest.fromJson(mapGetCoinBaseAddress);
        request1
            .add(utf8.encode(json.encode(dnaGetCoinbaseAddrRequest.toJson())));
        response = await request1.close();
        if (response.statusCode == 200) {
          String reply = await response.transform(utf8.decoder).join();
          dnaGetCoinbaseAddrResponse =
              dnaGetCoinbaseAddrResponseFromJson(reply);
        }
      }

      if (await getDemoModeStatus(idenaSharedPreferences.keyApp)) {
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
        dnaIdentityResponse.result.totalQualifiedFlips =
            DM_IDENTITY_TOTAL_QUALIFIED_FLIPS;
        dnaIdentityResponse.result.totalShortFlipPoints =
            DM_IDENTITY_TOTAL_SHORT_FLIP_POINTS;
        List<int> listWords1 = [DM_IDENTITY_KEYWORD_1, DM_IDENTITY_KEYWORD_2];
        dnaIdentityResponse.result.flipKeyWordPairs = new List<FlipKeyWordPair>();
        dnaIdentityResponse.result.flipKeyWordPairs.add(new FlipKeyWordPair(id: 1, words: listWords1, used: false));
        List<int> listWords2 = [DM_IDENTITY_KEYWORD_3, DM_IDENTITY_KEYWORD_4];
        dnaIdentityResponse.result.flipKeyWordPairs.add(new FlipKeyWordPair(id: 1, words: listWords2, used: false));

        dnaGetBalanceResponse = new DnaGetBalanceResponse();
        dnaGetBalanceResponse.result = new DnaGetBalanceResponseResult();
        dnaGetBalanceResponse.result.balance = DM_PORTOFOLIO_MAIN;
        dnaGetBalanceResponse.result.stake = DM_PORTOFOLIO_STAKE;

        dnaGetEpochResponse = new DnaGetEpochResponse();
        dnaGetEpochResponse.result = new DnaGetEpochResponseResult();
        dnaGetEpochResponse.result.currentPeriod = DM_EPOCH_CURRENT_PERIOD;
        dnaGetEpochResponse.result.epoch = DM_EPOCH_EPOCH;
        dnaGetEpochResponse.result.nextValidation = DM_EPOCH_NEXT_VALIDATION;

        dnaCeremonyIntervalsResponse = new DnaCeremonyIntervalsResponse();
        dnaCeremonyIntervalsResponse.result =
            new DnaCeremonyIntervalsResponseResult();
        dnaCeremonyIntervalsResponse.result.flipLotteryDuration =
            DM_CEREMONY_INTERVALS_FLIP_LOTTERY_DURATION;
        dnaCeremonyIntervalsResponse.result.longSessionDuration =
            DM_CEREMONY_INTERVALS_LONG_SESSION_DURATION;
        dnaCeremonyIntervalsResponse.result.shortSessionDuration =
            DM_CEREMONY_INTERVALS_SHORT_SESSION_DURATION;

        dnaAll.dnaGetCoinbaseAddrResponse = dnaGetCoinbaseAddrResponse;
        dnaAll.dnaIdentityResponse = dnaIdentityResponse;
        dnaAll.dnaGetBalanceResponse = dnaGetBalanceResponse;
        dnaAll.dnaGetEpochResponse = dnaGetEpochResponse;
        dnaAll.dnaCeremonyIntervalsResponse = dnaCeremonyIntervalsResponse;
        return dnaAll;
      }

      // get Identity
      HttpClientRequest request2 =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request2.headers.set('content-type', 'application/json');

      Map<String, dynamic> mapGetIdentity = {
        'method': DnaIdentityRequest.METHOD_NAME,
        'params': [dnaGetCoinbaseAddrResponse.result],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };

      dnaIdentityRequest = DnaIdentityRequest.fromJson(mapGetIdentity);
      request2.add(utf8.encode(json.encode(dnaIdentityRequest.toJson())));
      response = await request2.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaIdentityResponse = dnaIdentityResponseFromJson(reply);

        // get Balance
        HttpClientRequest request3 =
            await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
        request3.headers.set('content-type', 'application/json');

        Map<String, dynamic> mapGetBalance = {
          'method': DnaGetBalanceRequest.METHOD_NAME,
          'params': [dnaIdentityResponse.result.address],
          'id': 101,
          'key': idenaSharedPreferences.keyApp
        };

        dnaGetBalanceRequest = DnaGetBalanceRequest.fromJson(mapGetBalance);
        request3.add(utf8.encode(json.encode(dnaGetBalanceRequest.toJson())));
        response = await request3.close();
        if (response.statusCode == 200) {
          String reply = await response.transform(utf8.decoder).join();
          dnaGetBalanceResponse = dnaGetBalanceResponseFromJson(reply);
        }

        // get Epoch
        HttpClientRequest request4 =
            await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
        request4.headers.set('content-type', 'application/json');

        Map<String, dynamic> mapGetEpoch = {
          'method': DnaGetEpochRequest.METHOD_NAME,
          'params': [],
          'id': 101,
          'key': idenaSharedPreferences.keyApp
        };

        dnaGetEpochRequest = DnaGetEpochRequest.fromJson(mapGetEpoch);
        request4.add(utf8.encode(json.encode(dnaGetEpochRequest.toJson())));
        response = await request4.close();
        if (response.statusCode == 200) {
          String reply = await response.transform(utf8.decoder).join();
          dnaGetEpochResponse = dnaGetEpochResponseFromJson(reply);
        }

        // get Ceremony intervals
        HttpClientRequest request5 =
            await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
        request5.headers.set('content-type', 'application/json');

        Map<String, dynamic> mapGetCeremonyIntervals = {
          'method': DnaCeremonyIntervalsRequest.METHOD_NAME,
          'params': [],
          'id': 101,
          'key': idenaSharedPreferences.keyApp
        };

        dnaCeremonyIntervalsRequest =
            DnaCeremonyIntervalsRequest.fromJson(mapGetCeremonyIntervals);
        request5.add(
            utf8.encode(json.encode(dnaCeremonyIntervalsRequest.toJson())));
        response = await request5.close();
        if (response.statusCode == 200) {
          String reply = await response.transform(utf8.decoder).join();
          dnaCeremonyIntervalsResponse =
              dnaCeremonyIntervalsResponseFromJson(reply);
        }
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }

    dnaAll.dnaGetCoinbaseAddrRequest = dnaGetCoinbaseAddrRequest;
    dnaAll.dnaGetCoinbaseAddrResponse = dnaGetCoinbaseAddrResponse;
    dnaAll.dnaIdentityRequest = dnaIdentityRequest;
    dnaAll.dnaIdentityResponse = dnaIdentityResponse;
    dnaAll.dnaGetBalanceRequest = dnaGetBalanceRequest;
    dnaAll.dnaGetBalanceResponse = dnaGetBalanceResponse;
    dnaAll.dnaGetEpochRequest = dnaGetEpochRequest;
    dnaAll.dnaGetEpochResponse = dnaGetEpochResponse;
    dnaAll.dnaCeremonyIntervalsRequest = dnaCeremonyIntervalsRequest;
    dnaAll.dnaCeremonyIntervalsResponse = dnaCeremonyIntervalsResponse;
    return dnaAll;
  }

  Future<DnaBecomeOnlineResponse> becomeOnline() async {
    DnaBecomeOnlineResponse dnaBecomeOnlineResponse;
    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();

      if (await getDemoModeStatus(idenaSharedPreferences.keyApp)) {
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
    IdenaSharedPreferences idenaSharedPreferences =
        await SharedPreferencesHelper.getIdenaSharedPreferences();

    if (await getDemoModeStatus(idenaSharedPreferences.keyApp)) {
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
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
    return dnaBecomeOfflineResponse;
  }

  Future<GetFlipRawResponse> getFlipRaw(String hash) async {
    GetFlipRawResponse getFlipRawResponse;
    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();

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
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();

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
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();

      if (await getDemoModeStatus(idenaSharedPreferences.keyApp)) {
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
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();

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

  Future<bool> getMiningStatus(int waitForMiningStatus) async {
    DnaGetCoinbaseAddrRequest dnaGetCoinbaseAddrRequest;
    DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponse;
    DnaIdentityRequest dnaIdentityRequest;
    DnaIdentityResponse dnaIdentityResponse;
    bool miningStatus;
    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();
      if (idenaSharedPreferences == null) {
        return null;
      }

      // get CoinBase Address
      HttpClientRequest request1 =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request1.headers.set('content-type', 'application/json');

      Map<String, dynamic> mapGetCoinBaseAddress = {
        'method': DnaGetCoinbaseAddrRequest.METHOD_NAME,
        'params': [],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      dnaGetCoinbaseAddrRequest =
          DnaGetCoinbaseAddrRequest.fromJson(mapGetCoinBaseAddress);
      request1
          .add(utf8.encode(json.encode(dnaGetCoinbaseAddrRequest.toJson())));
      HttpClientResponse response = await request1.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaGetCoinbaseAddrResponse = dnaGetCoinbaseAddrResponseFromJson(reply);
      }

      // get Identity
      HttpClientRequest request2 =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request2.headers.set('content-type', 'application/json');

      Map<String, dynamic> mapGetIdentity = {
        'method': DnaIdentityRequest.METHOD_NAME,
        'params': [dnaGetCoinbaseAddrResponse.result],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };

      dnaIdentityRequest = DnaIdentityRequest.fromJson(mapGetIdentity);
      request2.add(utf8.encode(json.encode(dnaIdentityRequest.toJson())));
      response = await request2.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaIdentityResponse = dnaIdentityResponseFromJson(reply);
        miningStatus = dnaIdentityResponse.result.online;
        // waitForMiningStatus.value : 1 = wait for become offline, 2 = wait for become online
        if (miningStatus && waitForMiningStatus == 1) {
          return null;
        }
        if (!miningStatus && waitForMiningStatus == 2) {
          return null;
        }
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
    return miningStatus;
  }

  Future<String> getCurrentPeriod() async {
    String currentPeriod;
    HttpClient httpClient = new HttpClient();
    try {
      DnaGetEpochRequest dnaGetEpochRequest;
      DnaGetEpochResponse dnaGetEpochResponse;

      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();
      if (idenaSharedPreferences == null) {
        return null;
      }

      if (await getDemoModeStatus(idenaSharedPreferences.keyApp)) {
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
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();
      if (idenaSharedPreferences == null) {
        return null;
      }

      if (await getDemoModeStatus(idenaSharedPreferences.keyApp)) {
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
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
    return bcnSyncingResponse;
  }



    Future<FlipSubmitResponse> submitFlip(
      String publicHex, String privateHex) async {
    FlipSubmitResponse flipSubmitResponse;

    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();

      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': DnaSendTransactionRequest.METHOD_NAME,
        "params": [
          {
            "publicHex": publicHex,
            "privateHex": privateHex,
            "pairId": 1
          }
        ],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      FlipSubmitRequest flipSubmitRequest =
          FlipSubmitRequest.fromJson(map);
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
