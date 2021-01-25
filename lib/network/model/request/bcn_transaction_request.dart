// To parse this JSON data, do
//
//     final bcnTransactionRequest = bcnTransactionRequestFromJson(jsonString);

import 'dart:convert';

BcnTransactionRequest bcnTransactionRequestFromJson(String str) => BcnTransactionRequest.fromJson(json.decode(str));

String bcnTransactionRequestToJson(BcnTransactionRequest data) => json.encode(data.toJson());

class BcnTransactionRequest {
    BcnTransactionRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<String> params;
    int id;
    String key;

    static const METHOD_NAME = "bcn_transaction";

    factory BcnTransactionRequest.fromJson(Map<String, dynamic> json) => BcnTransactionRequest(
        method: json["method"],
        params: List<String>.from(json["params"].map((x) => x)),
        id: json["id"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "params": List<dynamic>.from(params.map((x) => x)),
        "id": id,
        "key": key,
    };
}
