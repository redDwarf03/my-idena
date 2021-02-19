// To parse this JSON data, do
//
//     final bcnTxReceiptRequest = bcnTxReceiptRequestFromJson(jsonString);

import 'dart:convert';

BcnTxReceiptRequest bcnTxReceiptRequestFromJson(String str) => BcnTxReceiptRequest.fromJson(json.decode(str));

String bcnTxReceiptRequestToJson(BcnTxReceiptRequest data) => json.encode(data.toJson());

class BcnTxReceiptRequest {
    BcnTxReceiptRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<String> params;
    int id;
    String key;

    static const METHOD_NAME = "bcn_txReceipt";

    factory BcnTxReceiptRequest.fromJson(Map<String, dynamic> json) => BcnTxReceiptRequest(
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
