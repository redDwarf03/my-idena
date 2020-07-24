import 'dart:convert';
import 'dart:io';

import 'package:my_idena/beans/rpc/dna_all.dart';
import 'package:my_idena/beans/rpc/dna_becomOnline_response.dart';
import 'package:my_idena/beans/rpc/dna_becomeOffline_request.dart';
import 'package:my_idena/beans/rpc/dna_becomeOffline_response.dart';
import 'package:my_idena/beans/rpc/dna_becomeOnline_request.dart';
import 'package:my_idena/beans/rpc/dna_ceremonyIntervals_request.dart';
import 'package:my_idena/beans/rpc/dna_ceremonyIntervals_response.dart';
import 'package:my_idena/beans/rpc/dna_flipShortHashesRequest.dart';
import 'package:my_idena/beans/rpc/dna_flipShortHashesResponse.dart';
import 'package:my_idena/beans/rpc/dna_getBalance_request.dart';
import 'package:my_idena/beans/rpc/dna_getBalance_response.dart';
import 'package:my_idena/beans/rpc/dna_getCoinbaseAddr_request.dart';
import 'package:my_idena/beans/rpc/dna_getCoinbaseAddr_response.dart';
import 'package:my_idena/beans/rpc/dna_getEpoch_request.dart';
import 'package:my_idena/beans/rpc/dna_getEpoch_response.dart';
import 'package:my_idena/beans/rpc/dna_getFlipRaw_request.dart';
import 'package:my_idena/beans/rpc/dna_getFlipRaw_response.dart';
import 'package:my_idena/beans/rpc/dna_identity_request.dart';
import 'package:my_idena/beans/rpc/dna_identity_response.dart';
import 'package:my_idena/utils/sharedPreferencesHelper.dart';

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
  FlipShortHashesRequest flipShortHashesRequest;
  FlipShortHashesResponse flipShortHashesResponse;

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

      // get Balance
      HttpClientRequest request3 =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request3.headers.set('content-type', 'application/json');

      Map<String, dynamic> mapGetBalance = {
        'method': DnaGetBalanceRequest.METHOD_NAME,
        'params': [dnaGetCoinbaseAddrResponse.result],
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
      print("erreur : " + e.toString());
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

      Map<String, dynamic> mapActivateMining = {
        'method': DnaBecomeOnlineRequest.METHOD_NAME,
        "params": [
          {"nonce": null, "epoch": null}
        ],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      dnaBecomeOnlineRequest =
          DnaBecomeOnlineRequest.fromJson(mapActivateMining);
      request.add(utf8.encode(json.encode(dnaBecomeOnlineRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaBecomeOnlineResponse = dnaBecomeOnlineResponseFromJson(reply);
      }
    } catch (e) {
      print("erreur: " + e.toString());
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

      Map<String, dynamic> mapDesactivateMining = {
        'method': DnaBecomeOfflineRequest.METHOD_NAME,
        "params": [
          {"nonce": null, "epoch": null}
        ],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      dnaBecomeOfflineRequest =
          DnaBecomeOfflineRequest.fromJson(mapDesactivateMining);
      request.add(utf8.encode(json.encode(dnaBecomeOfflineRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        dnaBecomeOfflineResponse = dnaBecomeOfflineResponseFromJson(reply);
      }
    } catch (e) {
      print("erreur: " + e.toString());
    } finally {}
    return dnaBecomeOfflineResponse;
  }

  Future<FlipShortHashesResponse> getFlipShortHashes() async {
    try {
      HttpClient httpClient = new HttpClient();
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();

      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': FlipShortHashesRequest.METHOD_NAME,
        "params": [],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };

      Map<String, dynamic> mapExemple = {
        "jsonrpc": "2.0",
        "id": 101,
        "result": [
          {"hash": "1", "ready": true},
          {"hash": "2", "ready": false},
          {"hash": "3", "ready": false},
          {"hash": "4", "ready": true, "extra": true},
          {"hash": "5", "ready": false, "extra": true}
        ]
      };

      flipShortHashesResponse = FlipShortHashesResponse.fromJson(mapExemple);
      // TODO : simulate
      /* flipShortHashesRequest =
          FlipShortHashesRequest.fromJson(map);
      request.add(utf8.encode(json.encode(flipShortHashesRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();

       flipShortHashesResponse = flipShortHashesResponseFromJson(reply);
      }*/
    } catch (e) {
      print("erreur: " + e.toString());
    } finally {}
    return flipShortHashesResponse;
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

      Map<String, dynamic> mapGetFlipRaw = {
        'method': GetFlipRawRequest.METHOD_NAME,
        'params': [hash],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };

      GetFlipRawRequest getFlipRawRequest =
          GetFlipRawRequest.fromJson(mapGetFlipRaw);
      request.add(utf8.encode(json.encode(getFlipRawRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        getFlipRawResponse =
            getFlipRawResponseFromJson(reply);
      }
    } catch (e) {
      print("erreur: " + e.toString());
    } finally {}
    return getFlipRawResponse;
  }
}
