import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dartssh/client.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/bus/events.dart';
import 'package:my_idena/network/model/request/bcn_tx_receipt_request.dart';
import 'package:my_idena/network/model/request/contract/contract_call_request.dart';
import 'package:my_idena/network/model/request/contract/contract_deploy_request.dart';
import 'package:my_idena/network/model/request/contract/contract_estimate_deploy_request.dart';
import 'package:my_idena/network/model/request/contract/contract_terminate_request.dart';
import 'package:my_idena/network/model/response/bcn_tx_receipt_response.dart';
import 'package:my_idena/network/model/response/contract/contract_call_response.dart';
import 'package:my_idena/network/model/response/contract/contract_deploy_response.dart';
import 'package:my_idena/network/model/response/contract/contract_estimate_deploy_response.dart';
import 'package:my_idena/network/model/response/contract/contract_terminate_response.dart';
import 'package:my_idena/network/model/response/dna_getEpoch_response.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/helpers.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:http/http.dart' as http;
import 'package:my_idena/util/util_node.dart';
import 'package:my_idena/util/util_vps.dart';
import 'package:dartssh/http.dart' as ssh;
import 'package:ethereum_util/ethereum_util.dart' as ethereum_util;
import 'package:web3dart/crypto.dart' as crypto show keccak256;
import 'package:my_idena/network/model/request/contract/api_contract_balance_updates_response.dart';
import 'package:my_idena/network/model/request/contract/api_contract_response.dart';
import 'package:my_idena/network/model/request/contract/api_contract_txs_response.dart';

class SmartContractService {
  var logger = Logger();
  final Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };
  String body;
  http.Response responseHttp;

  SSHClient sshClient;

  Future<BcnTxReceiptResponse> getTxReceipt(String txHash) async {
    BcnTxReceiptRequest bcnTxReceiptRequest;
    BcnTxReceiptResponse bcnTxReceiptResponse;

    Map<String, dynamic> mapParams;

    Completer<BcnTxReceiptResponse> _completer =
        new Completer<BcnTxReceiptResponse>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (await NodeUtil().getNodeType() == PUBLIC_NODE) {
      if (url.isAbsolute == false) {
        _completer.complete(bcnTxReceiptResponse);
        return _completer.future;
      }

      mapParams = {
        'method': BcnTxReceiptRequest.METHOD_NAME,
        'params': [txHash],
        'id': 101,
      };
    } else {
      if (url.isAbsolute == false || keyApp == "") {
        _completer.complete(bcnTxReceiptResponse);
        return _completer.future;
      }

      mapParams = {
        'method': BcnTxReceiptRequest.METHOD_NAME,
        'params': [txHash],
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
          bcnTxReceiptResponse = bcnTxReceiptResponseFromJson(response.text);
        }
      } else {
        bcnTxReceiptRequest = BcnTxReceiptRequest.fromJson(mapParams);
        body = json.encode(bcnTxReceiptRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          bcnTxReceiptResponse =
              bcnTxReceiptResponseFromJson(responseHttp.body);
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(bcnTxReceiptResponse);

    return _completer.future;
  }

  Future<String> getPredictSmartContractAddress(String address) async {
    var addr = ethereum_util.toBuffer(address);
    var epoch;
    DnaGetEpochResponse dnaGetEpochResponse =
        await sl.get<AppService>().getDnaGetEpoch();
    if (dnaGetEpochResponse != null && dnaGetEpochResponse.result != null) {
      epoch = ethereum_util.intToBuffer(dnaGetEpochResponse.result.epoch);
    }
    var nonce = ethereum_util
        .intToBuffer(await sl.get<AppService>().getLastNonce(address) + 1);
    var res = Uint8List.fromList([
      ...addr,
      ...epoch,
      ...Uint8List(2 - epoch.length),
      ...nonce,
      ...Uint8List(4 - nonce.length)
    ]);
    var hash = crypto.keccak256(res);
    String addressSC =
        AppHelpers.toHexString(hash.sublist(hash.length - 20), true);
    //print('addressSC: ' + addressSC);
    return addressSC;
  }

  Future<ContractDeployResponse> contractDeployTimeLock(
      String owner, int timestamp, int amount, int maxFee) async {
    ContractDeployRequest contractDeployRequest;
    ContractDeployResponse contractDeployResponse;

    Map<String, dynamic> mapParams;

    Completer<ContractDeployResponse> _completer =
        new Completer<ContractDeployResponse>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(contractDeployResponse);

      EventTaxiImpl.singleton()
          .fire(ContractDeployEvent(response: "Connection error"));

      return _completer.future;
    }

    mapParams = {
      'method': ContractDeployRequest.METHOD_NAME,
      'params': [
        {
          "from": owner,
          "codeHash": "0x01",
          "amount": amount,
          "maxFee": maxFee,
          "args": [
            {"index": 0, "format": "uint64", "value": timestamp.toString()}
          ]
        }
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
          contractDeployResponse =
              contractDeployResponseFromJson(response.text);

          if (contractDeployResponse.error != null) {
            EventTaxiImpl.singleton().fire(ContractDeployEvent(
                response: contractDeployResponse.error.message));
          } else {
            EventTaxiImpl.singleton()
                .fire(ContractDeployEvent(response: "Success"));
          }
        }
      } else {
        contractDeployRequest = ContractDeployRequest.fromJson(mapParams);
        body = json.encode(contractDeployRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          contractDeployResponse =
              contractDeployResponseFromJson(responseHttp.body);

          if (contractDeployResponse.error != null) {
            EventTaxiImpl.singleton().fire(ContractDeployEvent(
                response: contractDeployResponse.error.message));
          } else {
            EventTaxiImpl.singleton()
                .fire(ContractDeployEvent(response: "Success"));
          }
        }
      }
    } catch (e) {
      logger.e(e.toString());

      EventTaxiImpl.singleton()
          .fire(ContractDeployEvent(response: e.toString()));
    }

    _completer.complete(contractDeployResponse);

    return _completer.future;
  }

  Future<ContractEstimateDeployResponse> contractEstimateDeployTimeLock(
      String owner, int timestamp, int amount) async {
    ContractEstimateDeployRequest contractEstimateDeployRequest;
    ContractEstimateDeployResponse contractEstimateDeployResponse;

    Map<String, dynamic> mapParams;

    Completer<ContractEstimateDeployResponse> _completer =
        new Completer<ContractEstimateDeployResponse>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(contractEstimateDeployResponse);
      return _completer.future;
    }

    mapParams = {
      'method': ContractEstimateDeployRequest.METHOD_NAME,
      'params': [
        {
          "from": owner,
          "codeHash": "0x01",
          "amount": amount,
          "maxFee": 1,
          "args": [
            {"index": 0, "format": "uint64", "value": timestamp.toString()}
          ]
        }
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
          contractEstimateDeployResponse =
              contractEstimateDeployResponseFromJson(response.text);
        }
      } else {
        contractEstimateDeployRequest =
            ContractEstimateDeployRequest.fromJson(mapParams);
        body = json.encode(contractEstimateDeployRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          contractEstimateDeployResponse =
              contractEstimateDeployResponseFromJson(responseHttp.body);
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(contractEstimateDeployResponse);

    return _completer.future;
  }

  Future<ContractCallResponse> contractCallTimeLock(String owner,
      String contract, double maxFee, String destinationAddress) async {
    ContractCallRequest contractCallRequest;
    ContractCallResponse contractCallResponse;

    Map<String, dynamic> mapParams;

    Completer<ContractCallResponse> _completer =
        new Completer<ContractCallResponse>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(contractCallResponse);
      return _completer.future;
    }

    mapParams = {
      'method': ContractCallRequest.METHOD_NAME,
      'params': [
        {
          "from": owner,
          "contract": contract,
          "method": "transfer",
          "maxFee": maxFee,
          "args": [
            {"index": 0, "format": "hex", "value": destinationAddress}
          ]
        }
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
          contractCallResponse = contractCallResponseFromJson(response.text);
        }
      } else {
        contractCallRequest = ContractCallRequest.fromJson(mapParams);
        body = json.encode(contractCallRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          contractCallResponse =
              contractCallResponseFromJson(responseHttp.body);
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(contractCallResponse);

    return _completer.future;
  }

  Future<ContractTerminateResponse> contractTerminateTimeLock(String owner,
      String contract, double maxFee, String destinationAddress) async {
    ContractTerminateRequest contractTerminateRequest;
    ContractTerminateResponse contractTerminateResponse;

    Map<String, dynamic> mapParams;

    Completer<ContractTerminateResponse> _completer =
        new Completer<ContractTerminateResponse>();

    Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
    String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

    if (url.isAbsolute == false || keyApp == "") {
      _completer.complete(contractTerminateResponse);
      return _completer.future;
    }

    mapParams = {
      'method': ContractTerminateRequest.METHOD_NAME,
      'params': [
        {
          "from": owner,
          "contract": contract,
          "maxFee": maxFee,
          "args": [
            {"index": 0, "format": "hex", "value": destinationAddress}
          ]
        }
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
          contractTerminateResponse =
              contractTerminateResponseFromJson(response.text);
        }
      } else {
        contractTerminateRequest = ContractTerminateRequest.fromJson(mapParams);
        body = json.encode(contractTerminateRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          contractTerminateResponse =
              contractTerminateResponseFromJson(responseHttp.body);
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }

    _completer.complete(contractTerminateResponse);

    return _completer.future;
  }


  Future<ApiContractResponse> getContract(String contractAddress) async {
    HttpClient httpClient = new HttpClient();
    ApiContractResponse apiContractResponse;
    Completer<ApiContractResponse> _completer =
        new Completer<ApiContractResponse>();

    try {
      HttpClientRequest request = await httpClient.getUrl(
          Uri.parse("http://api.idena.io/api/Contract/" + contractAddress));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        apiContractResponse = apiContractResponseFromJson(reply);
      }
    } catch (e) {
      print("exception : " + e.toString());
    } finally {
      httpClient.close();
    }

    _completer.complete(apiContractResponse);

    return _completer.future;
  }

  Future<ApiContractBalanceUpdatesResponse> getContractBalanceUpdates(
      String address, String contractAddress, int limit) async {
    HttpClient httpClient = new HttpClient();
    ApiContractBalanceUpdatesResponse apiContractBalanceUpdatesResponse;
    Completer<ApiContractBalanceUpdatesResponse> _completer =
        new Completer<ApiContractBalanceUpdatesResponse>();

    String uri;
    if (address != null) {
      uri = "http://api.idena.io/api/Address/" +
          address +
          "/Contract/" +
          contractAddress +
          "/BalanceUpdates?limit=" +
          limit.toString();
    } else {
      uri = "http://api.idena.io/api/Contract/" +
          contractAddress +
          "/BalanceUpdates?limit=" +
          limit.toString();
    }

    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(uri));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        apiContractBalanceUpdatesResponse =
            apiContractBalanceUpdatesResponseFromJson(reply);
      }
    } catch (e) {
      print("exception : " + e.toString());
    } finally {
      httpClient.close();
    }

    _completer.complete(apiContractBalanceUpdatesResponse);

    return _completer.future;
  }

  Future<ApiContractTxsResponse> getContractTxs(
      String address, int limit, String typeOfContract) async {
    HttpClient httpClient = new HttpClient();
    ApiContractTxsResponse apiContractTxsResponse = new ApiContractTxsResponse();
    apiContractTxsResponse.result = new List<ApiContractTxsResponseResult>();
    Completer<ApiContractTxsResponse> _completer =
        new Completer<ApiContractTxsResponse>();

    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "http://api.idena.io/api/Address/" + address + "/Txs?limit=10"));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        ApiContractTxsResponse apiContractTxsResponseTmp = apiContractTxsResponseFromJson(reply);
        if (apiContractTxsResponseTmp != null &&
            apiContractTxsResponseTmp.result != null) {
          for (int i = 0; i < apiContractTxsResponseTmp.result.length; i++) {
            if(apiContractTxsResponseTmp.result[i].type == "CallContract")
            {
              ApiContractResponse apiContractResponse = await getContract(apiContractTxsResponseTmp.result[i].to);
                if(apiContractResponse != null && apiContractResponse.result != null && apiContractResponse.result.type == typeOfContract)
                {
                    apiContractTxsResponse.result.add(apiContractTxsResponseTmp.result[i]);
                }
            }
          }  
        }
      }
    } catch (e) {
      print("exception : " + e.toString());
    } finally {
      httpClient.close();
    }

    _completer.complete(apiContractTxsResponse);

    return _completer.future;
  }
}
