// @dart=2.9
// To parse this JSON data, do
//
//     final bcnTxReceiptResponse = bcnTxReceiptResponseFromJson(jsonString);

import 'dart:convert';

BcnTxReceiptResponse bcnTxReceiptResponseFromJson(String str) => BcnTxReceiptResponse.fromJson(json.decode(str));

String bcnTxReceiptResponseToJson(BcnTxReceiptResponse data) => json.encode(data.toJson());

class BcnTxReceiptResponse {
    BcnTxReceiptResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    Result result;

    factory BcnTxReceiptResponse.fromJson(Map<String, dynamic> json) => BcnTxReceiptResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
    };
}

class Result {
    Result({
        this.contract,
        this.method,
        this.success,
        this.gasUsed,
        this.txHash,
        this.error,
        this.gasCost,
        this.txFee,
    });

    String contract;
    String method;
    bool success;
    int gasUsed;
    String txHash;
    String error;
    String gasCost;
    String txFee;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        contract: json["contract"],
        method: json["method"],
        success: json["success"],
        gasUsed: json["gasUsed"],
        txHash: json["txHash"],
        error: json["error"],
        gasCost: json["gasCost"],
        txFee: json["txFee"],
    );

    Map<String, dynamic> toJson() => {
        "contract": contract,
        "method": method,
        "success": success,
        "gasUsed": gasUsed,
        "txHash": txHash,
        "error": error,
        "gasCost": gasCost,
        "txFee": txFee,
    };
}
