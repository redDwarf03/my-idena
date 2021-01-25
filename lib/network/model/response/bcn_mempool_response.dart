// To parse this JSON data, do
//
//     final bcnMempoolResponse = bcnMempoolResponseFromJson(jsonString);

import 'dart:convert';

BcnMempoolResponse bcnMempoolResponseFromJson(String str) => BcnMempoolResponse.fromJson(json.decode(str));

String bcnMempoolResponseToJson(BcnMempoolResponse data) => json.encode(data.toJson());

class BcnMempoolResponse {
    BcnMempoolResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    List<String> result;

    factory BcnMempoolResponse.fromJson(Map<String, dynamic> json) => BcnMempoolResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null ? null : List<String>.from(json["result"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": List<dynamic>.from(result.map((x) => x)),
    };
}
