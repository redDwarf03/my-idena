// To parse this JSON data, do
//
//     final bcnTransactionResponse = bcnTransactionResponseFromJson(jsonString);

import 'dart:convert';

BcnTransactionResponse bcnTransactionResponseFromJson(String str) => BcnTransactionResponse.fromJson(json.decode(str));

String bcnTransactionResponseToJson(BcnTransactionResponse data) => json.encode(data.toJson());

class BcnTransactionResponse {
    BcnTransactionResponse({
        this.jsonrpc,
        this.id,
        this.result,
        this.error,
    });

    String jsonrpc;
    int id;
    BcnTransactionResponseResult result;
    BcnTransactionResponseError error;

    factory BcnTransactionResponse.fromJson(Map<String, dynamic> json) => BcnTransactionResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null ? null : BcnTransactionResponseResult.fromJson(json["result"]),
        error: json["error"] == null ? null : BcnTransactionResponseError.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
        "error": error.toJson(),
    };
}

class BcnTransactionResponseResult {
    BcnTransactionResponseResult({
        this.hash,
        this.type,
        this.from,
        this.to,
        this.amount,
        this.tips,
        this.maxFee,
        this.nonce,
        this.epoch,
        this.payload,
        this.blockHash,
        this.usedFee,
        this.timestamp,
    });

    String hash;
    String type;
    String from;
    String to;
    String amount;
    String tips;
    String maxFee;
    int nonce;
    int epoch;
    String payload;
    String blockHash;
    String usedFee;
    int timestamp;

    factory BcnTransactionResponseResult.fromJson(Map<String, dynamic> json) => BcnTransactionResponseResult(
        hash: json["hash"],
        type: json["type"],
        from: json["from"],
        to: json["to"],
        amount: json["amount"],
        tips: json["tips"],
        maxFee: json["maxFee"],
        nonce: json["nonce"],
        epoch: json["epoch"],
        payload: json["payload"],
        blockHash: json["blockHash"],
        usedFee: json["usedFee"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "hash": hash,
        "type": type,
        "from": from,
        "to": to,
        "amount": amount,
        "tips": tips,
        "maxFee": maxFee,
        "nonce": nonce,
        "epoch": epoch,
        "payload": payload,
        "blockHash": blockHash,
        "usedFee": usedFee,
        "timestamp": timestamp,
    };
}

class BcnTransactionResponseError {
    BcnTransactionResponseError({
        this.code,
        this.message,
    });

    int code;
    String message;

    factory BcnTransactionResponseError.fromJson(Map<String, dynamic> json) => BcnTransactionResponseError(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}