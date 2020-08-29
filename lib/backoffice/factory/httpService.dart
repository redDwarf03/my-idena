import 'dart:convert';
import 'dart:io';
import 'package:my_idena/backoffice/bean/bcn_transactions_request.dart';
import 'package:my_idena/backoffice/bean/bcn_transactions_response.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/bean/dna_becomOnline_response.dart';
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
import 'package:my_idena/beans/deepLinkParam.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/utils/sharedPreferencesHelper.dart';
import 'package:http/http.dart' as http;

class HttpService {
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
  DnaBecomeOnlineRequest dnaBecomeOnlineRequest;
  DnaBecomeOnlineResponse dnaBecomeOnlineResponse;
  DnaBecomeOfflineRequest dnaBecomeOfflineRequest;
  DnaBecomeOfflineResponse dnaBecomeOfflineResponse;
  DnaSendTransactionRequest dnaSendTransactionRequest;
  DnaSendTransactionResponse dnaSendTransactionResponse;
  BcnTransactionsRequest bcnTransactionsRequest;
  BcnTransactionsResponse bcnTransactionsResponse;

  Future<bool> checkConnection(apiUrl, keyApp) async {
    try {

      if(apiUrl == null || keyApp == null || apiUrl == "" || keyApp == "")
      {
        return false;
      }
      bool _validURL = Uri.parse(apiUrl).isAbsolute;
      if(!_validURL)
      {
        return false;
      }
      final responseHttp = await http.get(Uri.encodeFull(apiUrl), 
      headers: {
         "accept": "application/json"
       });
      if (responseHttp.statusCode != 200) {
        return false;
      } else {
        HttpClient httpClient = new HttpClient();
        // get CoinBase Address
        HttpClientRequest request = await httpClient.postUrl(Uri.parse(apiUrl));
        request.headers.set('content-type', 'application/json');

        Map<String, dynamic> mapGetCoinBaseAddress = {
          'method': DnaGetCoinbaseAddrRequest.METHOD_NAME,
          'params': [],
          'id': 101,
          'key': keyApp
        };
        dnaGetCoinbaseAddrRequest =
            DnaGetCoinbaseAddrRequest.fromJson(mapGetCoinBaseAddress);
        request
            .add(utf8.encode(json.encode(dnaGetCoinbaseAddrRequest.toJson())));
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
      }
    } catch (e) {
      return false;
    }
  }

  Future<DnaAll> getDnaAll() async {
    DnaAll dnaAll = new DnaAll();

    try {
      HttpClient httpClient = new HttpClient();

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
    } finally {}

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
    try {
      HttpClient httpClient = new HttpClient();
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();

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
      dnaBecomeOnlineRequest = DnaBecomeOnlineRequest.fromJson(map);
      request.add(utf8.encode(json.encode(dnaBecomeOnlineRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaBecomeOnlineResponse = dnaBecomeOnlineResponseFromJson(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {}
    return dnaBecomeOnlineResponse;
  }

  Future<DnaBecomeOfflineResponse> becomeOffline() async {
    HttpClient httpClient = new HttpClient();
    IdenaSharedPreferences idenaSharedPreferences =
        await SharedPreferencesHelper.getIdenaSharedPreferences();

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
      dnaBecomeOfflineRequest = DnaBecomeOfflineRequest.fromJson(map);
      request.add(utf8.encode(json.encode(dnaBecomeOfflineRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaBecomeOfflineResponse = dnaBecomeOfflineResponseFromJson(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {}
    return dnaBecomeOfflineResponse;
  }

  Future<GetFlipRawResponse> getFlipRaw(String hash) async {
    GetFlipRawResponse getFlipRawResponse;

    try {
      HttpClient httpClient = new HttpClient();
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
    } finally {}
    return getFlipRawResponse;
  }

  Future<DnaSendTransactionResponse> sendTransaction(
      String from, double amount) async {
    if (amount <= 0) {
      return null;
    }
    try {
      HttpClient httpClient = new HttpClient();
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
            "to": "0x72563cb949bd0167acfff47b5865fe30e1960e70",
            'amount': amount.toString()
          }
        ],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      dnaSendTransactionRequest = DnaSendTransactionRequest.fromJson(map);
      request.add(utf8.encode(json.encode(dnaSendTransactionRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaSendTransactionResponse = dnaSendTransactionResponseFromJson(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {}
    return dnaSendTransactionResponse;
  }

  Future<BcnTransactionsResponse> getTransactions(
      String address, int count) async {
    try {
      HttpClient httpClient = new HttpClient();
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();

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
      bcnTransactionsRequest = BcnTransactionsRequest.fromJson(map);
      request.add(utf8.encode(json.encode(bcnTransactionsRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();

        bcnTransactionsResponse = bcnTransactionsResponseFromJson(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {}
    return bcnTransactionsResponse;
  }

  Future<DeepLinkParam> signin(deepLinkParam) async {
    DnaSignInRequest dnaSignInRequest;
    DnaSignInResponse dnaSignInResponse;
    try {
      HttpClient httpClient = new HttpClient();
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
      dnaSignInRequest = DnaSignInRequest.fromJson(map);
      request.add(utf8.encode(json.encode(dnaSignInRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaSignInResponse = dnaSignInResponseFromJson(reply);
        deepLinkParam.signature = dnaSignInResponse.result;
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {}
    return deepLinkParam;
  }
}
