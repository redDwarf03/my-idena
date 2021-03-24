// @dart=2.9
// To parse this JSON data, do
//
//     final apiContractTxsResponse = apiContractTxsResponseFromJson(jsonString);

import 'dart:convert';

ApiContractTxsResponse apiContractTxsResponseFromJson(String str) => ApiContractTxsResponse.fromJson(json.decode(str));

String apiContractTxsResponseToJson(ApiContractTxsResponse data) => json.encode(data.toJson());

class ApiContractTxsResponse {
    ApiContractTxsResponse({
        this.result,
        this.continuationToken,
    });

    List<ApiContractTxsResponseResult> result;
    String continuationToken;

    factory ApiContractTxsResponse.fromJson(Map<String, dynamic> json) => ApiContractTxsResponse(
        result: json["result"] == null ? null : List<ApiContractTxsResponseResult>.from(json["result"].map((x) => ApiContractTxsResponseResult.fromJson(x))),
        continuationToken: json["continuationToken"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "continuationToken": continuationToken,
    };
}

class ApiContractTxsResponseResult {
    ApiContractTxsResponseResult({
        this.hash,
        this.type,
        this.timestamp,
        this.from,
        this.to,
        this.amount,
        this.tips,
        this.maxFee,
        this.fee,
        this.size,
        this.txReceipt,
        this.data,
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
    int size;
    ApiContractTxsResponseResultTxReceipt txReceipt;
    Data data;

    factory ApiContractTxsResponseResult.fromJson(Map<String, dynamic> json) => ApiContractTxsResponseResult(
        hash: json["hash"],
        type: json["type"],
        timestamp: DateTime.parse(json["timestamp"]),
        from: json["from"],
        to: json["to"] == null ? null : json["to"],
        amount: json["amount"],
        tips: json["tips"],
        maxFee: json["maxFee"],
        fee: json["fee"],
        size: json["size"],
        txReceipt: json["txReceipt"] == null ? null : ApiContractTxsResponseResultTxReceipt.fromJson(json["txReceipt"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
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
        "size": size,
        "txReceipt": txReceipt == null ? null : txReceipt.toJson(),
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.becomeOnline,
        this.dataBecomeOnline,
    });

    bool becomeOnline;
    bool dataBecomeOnline;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        becomeOnline: json["BecomeOnline"],
        dataBecomeOnline: json["becomeOnline"],
    );

    Map<String, dynamic> toJson() => {
        "BecomeOnline": becomeOnline,
        "becomeOnline": dataBecomeOnline,
    };
}

class ApiContractTxsResponseResultTxReceipt {
    ApiContractTxsResponseResultTxReceipt({
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

    factory ApiContractTxsResponseResultTxReceipt.fromJson(Map<String, dynamic> json) => ApiContractTxsResponseResultTxReceipt(
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
