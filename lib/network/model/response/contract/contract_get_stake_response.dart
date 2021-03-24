// @dart=2.9
// To parse this JSON data, do
//
//     final contractGetStakeResponse = contractGetStakeResponseFromJson(jsonString);

import 'dart:convert';

ContractGetStakeResponse contractGetStakeResponseFromJson(String str) => ContractGetStakeResponse.fromJson(json.decode(str));

String contractGetStakeResponseToJson(ContractGetStakeResponse data) => json.encode(data.toJson());

class ContractGetStakeResponse {
    ContractGetStakeResponse({
        this.jsonrpc,
        this.id,
        this.result,
        this.error
    });

    String jsonrpc;
    int id;
    ContractGetStakeResponseResult result;
    ContractGetStakeResponseError error;

    factory ContractGetStakeResponse.fromJson(Map<String, dynamic> json) => ContractGetStakeResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null ? null : ContractGetStakeResponseResult.fromJson(json["result"]),
        error: json["error"] == null ? null : ContractGetStakeResponseError.fromJson(json["error"]),
        
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
    };
}

class ContractGetStakeResponseResult {
    ContractGetStakeResponseResult({
        this.hash,
        this.stake,
    });

    String hash;
    String stake;

    factory ContractGetStakeResponseResult.fromJson(Map<String, dynamic> json) => ContractGetStakeResponseResult(
        hash: json["Hash"],
        stake: json["Stake"],
    );

    Map<String, dynamic> toJson() => {
        "Hash": hash,
        "Stake": stake,
    };

    
}


class ContractGetStakeResponseError {
    ContractGetStakeResponseError({
        this.code,
        this.message,
    });

    int code;
    String message;

    factory ContractGetStakeResponseError.fromJson(Map<String, dynamic> json) => ContractGetStakeResponseError(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}

