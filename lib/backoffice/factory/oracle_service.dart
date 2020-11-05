import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:my_idena/backoffice/bean/votings_list_response.dart';
import 'package:my_idena/backoffice/factory/sharedPreferencesHelper.dart';
import 'package:my_idena/backoffice/bean/flip_shortHashes_request.dart';

class OracleService {
  var logger = Logger();

  Future<VotingsListResponse> getVotingsListResponse(int nbVotings) async {
    VotingsListResponse votingsListResponse;
    HttpClient httpClient = new HttpClient();
    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "http://195.201.2.44:18888/api/OracleVotingContracts?limit=" +
              nbVotings.toString() +
              "&all=true"));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        votingsListResponse = votingsListResponseFromJson(reply);
        logger.i(new JsonEncoder.withIndent('  ').convert(votingsListResponse));
      }
    } catch (e, s) {
      logger.e("pb votingsListResponse exception : " + e.toString());
      logger.e("pb votingsListResponse stack : " + s.toString());
    } finally {
      httpClient.close();
    }
    return votingsListResponse;
  }

  createContractDataReader() async {
    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();
      if (idenaSharedPreferences == null) {
        return null;
      }

      FlipShortHashesRequest flipShortHashesRequest;
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': "contract_readData",
        'contractHash': "0xeE505638DB670108C0713bdE5999d8a628Da9E04",
        'contract': "0xeE505638DB670108C0713bdE5999d8a628Da9E04",
        'from': "0xa9f77a239cf0a3b15c4d8457fa3570a8894b4836",
        'votingMinPayment': 0,
        'gasCost': 0,
        'txFee': 0,
        'amount': 0,
        'broadcastBlock': '',
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      flipShortHashesRequest = FlipShortHashesRequest.fromJson(map);
      logger
          .i(new JsonEncoder.withIndent('  ').convert(flipShortHashesRequest));
      request.add(utf8.encode(json.encode(flipShortHashesRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        print(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
  }

  contractReadonlyCall() async {
    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();
      if (idenaSharedPreferences == null) {
        return null;
      }

      FlipShortHashesRequest flipShortHashesRequest;
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': "contract_readonlyCall",
        'params': [],
        'contractHash': "0xeE505638DB670108C0713bdE5999d8a628Da9E04",
        'contract': "0xeE505638DB670108C0713bdE5999d8a628Da9E04",
        'format': "hex",
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      flipShortHashesRequest = FlipShortHashesRequest.fromJson(map);
      logger
          .i(new JsonEncoder.withIndent('  ').convert(flipShortHashesRequest));
      request.add(utf8.encode(json.encode(flipShortHashesRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        print(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
  }

  contractCall() async {
    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();
      if (idenaSharedPreferences == null) {
        return null;
      }

      FlipShortHashesRequest flipShortHashesRequest;
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': "contract_call",
        'params': [],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      flipShortHashesRequest = FlipShortHashesRequest.fromJson(map);
      logger
          .i(new JsonEncoder.withIndent('  ').convert(flipShortHashesRequest));
      request.add(utf8.encode(json.encode(flipShortHashesRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        print(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
  }

  contractEstimateCall() async {
    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();
      if (idenaSharedPreferences == null) {
        return null;
      }

      FlipShortHashesRequest flipShortHashesRequest;
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': "contract_estimateCall",
        'params': [],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      flipShortHashesRequest = FlipShortHashesRequest.fromJson(map);
      logger
          .i(new JsonEncoder.withIndent('  ').convert(flipShortHashesRequest));
      request.add(utf8.encode(json.encode(flipShortHashesRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        print(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
  }

  sendVoteProof() async {
    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();
      if (idenaSharedPreferences == null) {
        return null;
      }

      FlipShortHashesRequest flipShortHashesRequest;
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': "sendVoteProof",
        'params': [],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      flipShortHashesRequest = FlipShortHashesRequest.fromJson(map);
      logger
          .i(new JsonEncoder.withIndent('  ').convert(flipShortHashesRequest));
      request.add(utf8.encode(json.encode(flipShortHashesRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        print(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
  }

  sendVote() async {
    HttpClient httpClient = new HttpClient();
    try {
      IdenaSharedPreferences idenaSharedPreferences =
          await SharedPreferencesHelper.getIdenaSharedPreferences();
      if (idenaSharedPreferences == null) {
        return null;
      }

      FlipShortHashesRequest flipShortHashesRequest;
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': "sendVote",
        'params': [],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };
      flipShortHashesRequest = FlipShortHashesRequest.fromJson(map);
      logger
          .i(new JsonEncoder.withIndent('  ').convert(flipShortHashesRequest));
      request.add(utf8.encode(json.encode(flipShortHashesRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        print(reply);
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      httpClient.close();
    }
  }
}
