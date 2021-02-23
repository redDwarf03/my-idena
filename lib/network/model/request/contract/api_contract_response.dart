// To parse this JSON data, do
//
//     final apiContractResponse = apiContractResponseFromJson(jsonString);

import 'dart:convert';

ApiContractResponse apiContractResponseFromJson(String str) => ApiContractResponse.fromJson(json.decode(str));

String apiContractResponseToJson(ApiContractResponse data) => json.encode(data.toJson());

class ApiContractResponse {
    ApiContractResponse({
        this.continuationToken,
        this.error,
        this.result,
    });

    String continuationToken;
    ApiContractResponseError error;
    ApiContractResponseResult result;

    factory ApiContractResponse.fromJson(Map<String, dynamic> json) => ApiContractResponse(
        continuationToken: json["continuationToken"],
        error: json["error"] == null ? null : ApiContractResponseError.fromJson(json["error"]),
        result: json["result"] == null ? null : ApiContractResponseResult.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "continuationToken": continuationToken,
        "error": error.toJson(),
        "result": result.toJson(),
    };
}

class ApiContractResponseError {
    ApiContractResponseError({
        this.message,
    });

    String message;

    factory ApiContractResponseError.fromJson(Map<String, dynamic> json) => ApiContractResponseError(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}

class ApiContractResponseResult {
    ApiContractResponseResult({
        this.address,
        this.author,
        this.deployTx,
        this.terminationTx,
        this.type,
    });

    String address;
    String author;
    Tx deployTx;
    Tx terminationTx;
    String type;

    factory ApiContractResponseResult.fromJson(Map<String, dynamic> json) => ApiContractResponseResult(
        address: json["address"],
        author: json["author"],
        deployTx: json["deployTx"] == null ? null : Tx.fromJson(json["deployTx"]),
        terminationTx: json["terminationTx"] == null ? null : Tx.fromJson(json["terminationTx"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "author": author,
        "deployTx": deployTx.toJson(),
        "terminationTx": terminationTx.toJson(),
        "type": type,
    };
}

class Tx {
    Tx({
        this.amount,
        this.data,
        this.fee,
        this.from,
        this.hash,
        this.maxFee,
        this.size,
        this.timestamp,
        this.tips,
        this.to,
        this.type,
    });

    String amount;
    Data data;
    String fee;
    String from;
    String hash;
    String maxFee;
    int size;
    DateTime timestamp;
    String tips;
    String to;
    String type;

    factory Tx.fromJson(Map<String, dynamic> json) => Tx(
        amount: json["amount"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        fee: json["fee"],
        from: json["from"],
        hash: json["hash"],
        maxFee: json["maxFee"],
        size: json["size"],
        timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
        tips: json["tips"],
        to: json["to"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "data": data.toJson(),
        "fee": fee,
        "from": from,
        "hash": hash,
        "maxFee": maxFee,
        "size": size,
        "timestamp": timestamp.toIso8601String(),
        "tips": tips,
        "to": to,
        "type": type,
    };
}

class Data {
    Data();

    factory Data.fromJson(Map<String, dynamic> json) => Data(
    );

    Map<String, dynamic> toJson() => {
    };
}
