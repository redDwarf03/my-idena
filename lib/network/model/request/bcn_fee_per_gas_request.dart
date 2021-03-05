// To parse this JSON data, do
//
//     final bcnFeePerGasRequest = bcnFeePerGasRequestFromJson(jsonString);

import 'dart:convert';

BcnFeePerGasRequest bcnFeePerGasRequestFromJson(String str) => BcnFeePerGasRequest.fromJson(json.decode(str));

String bcnFeePerGasRequestToJson(BcnFeePerGasRequest data) => json.encode(data.toJson());

class BcnFeePerGasRequest {
    BcnFeePerGasRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<dynamic> params;
    int id;
    String key;

    static const METHOD_NAME = "bcn_feePerGas";

    factory BcnFeePerGasRequest.fromJson(Map<String, dynamic> json) => BcnFeePerGasRequest(
        method: json["method"],
        params: List<dynamic>.from(json["params"].map((x) => x)),
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
