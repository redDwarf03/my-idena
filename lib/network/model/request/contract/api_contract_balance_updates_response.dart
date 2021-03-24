// @dart=2.9
// @dart=2.9
// To parse this JSON data, do
//
//     final apiContractBalanceUpdatesResponse = apiContractBalanceUpdatesResponseFromJson(jsonString);

import 'dart:convert';

ApiContractBalanceUpdatesResponse apiContractBalanceUpdatesResponseFromJson(String str) => ApiContractBalanceUpdatesResponse.fromJson(json.decode(str));

String apiContractBalanceUpdatesResponseToJson(ApiContractBalanceUpdatesResponse data) => json.encode(data.toJson());

class ApiContractBalanceUpdatesResponse {
    ApiContractBalanceUpdatesResponse({
        this.result,
    });

    List<ApiContractBalanceUpdatesResponseResult> result;

    factory ApiContractBalanceUpdatesResponse.fromJson(Map<String, dynamic> json) => ApiContractBalanceUpdatesResponse(
        result: List<ApiContractBalanceUpdatesResponseResult>.from(json["result"].map((x) => ApiContractBalanceUpdatesResponseResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class ApiContractBalanceUpdatesResponseResult {
    ApiContractBalanceUpdatesResponseResult({
        this.hash,
        this.type,
        this.timestamp,
        this.from,
        this.to,
        this.amount,
        this.tips,
        this.maxFee,
        this.fee,
        this.address,
        this.contractAddress,
        this.contractType,
        this.txReceipt,
    });

    String hash;
    String type;
    DateTime timestamp;
    String from;
    String to;
    String amount;
    String tips;
    String maxFee;
    String fee;
    String address;
    String contractAddress;
    String contractType;
    ApiContractBalanceUpdatesResponseResultTxReceipt txReceipt;

    factory ApiContractBalanceUpdatesResponseResult.fromJson(Map<String, dynamic> json) => ApiContractBalanceUpdatesResponseResult(
        hash: json["hash"],
        type: json["type"],
        timestamp: DateTime.parse(json["timestamp"]),
        from: json["from"],
        to: json["to"] == null ? null : json["to"],
        amount: json["amount"],
        tips: json["tips"],
        maxFee: json["maxFee"],
        fee: json["fee"],
        address: json["address"],
        contractAddress: json["contractAddress"],
        contractType: json["contractType"],
        txReceipt: json["txReceipt"] == null ? null : ApiContractBalanceUpdatesResponseResultTxReceipt.fromJson(json["txReceipt"]),
    );

    Map<String, dynamic> toJson() => {
        "hash": hash,
        "type": type,
        "timestamp": timestamp.toIso8601String(),
        "from": from,
        "to": to == null ? null : to,
        "amount": amount,
        "tips": tips,
        "maxFee": maxFee,
        "fee": fee,
        "address": address,
        "contractAddress": contractAddress,
        "contractType": contractType,
        "txReceipt": txReceipt.toJson(),
    };
}

class ApiContractBalanceUpdatesResponseResultTxReceipt {
    ApiContractBalanceUpdatesResponseResultTxReceipt({
        this.success,
        this.gasUsed,
        this.gasCost,
        this.method,
        this.errorMsg,
    });

    bool success;
    int gasUsed;
    String gasCost;
    String method;
    String errorMsg;

    factory ApiContractBalanceUpdatesResponseResultTxReceipt.fromJson(Map<String, dynamic> json) => ApiContractBalanceUpdatesResponseResultTxReceipt(
        success: json["success"],
        gasUsed: json["gasUsed"],
        gasCost: json["gasCost"],
        method: json["method"],
        errorMsg: json["errorMsg"] == null ? null : json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "gasUsed": gasUsed,
        "gasCost": gasCost,
        "method": method,
        "errorMsg": errorMsg == null ? null : errorMsg,
    };
}
