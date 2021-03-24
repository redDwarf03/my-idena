// To parse this JSON data, do
//
//     final bcnMempoolRequest = bcnMempoolRequestFromJson(jsonString);

import 'dart:convert';

BcnMempoolRequest bcnMempoolRequestFromJson(String str) => BcnMempoolRequest.fromJson(json.decode(str));

String bcnMempoolRequestToJson(BcnMempoolRequest data) => json.encode(data.toJson());

class BcnMempoolRequest {
    BcnMempoolRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String? method;
    List<dynamic>? params;
    int? id;
    String? key;

    static const METHOD_NAME = "bcn_mempool";

    factory BcnMempoolRequest.fromJson(Map<String, dynamic> json) => BcnMempoolRequest(
        method: json["method"],
        params: List<dynamic>.from(json["params"].map((x) => x)),
        id: json["id"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "params": List<dynamic>.from(params!.map((x) => x)),
        "id": id,
        "key": key,
    };
}
