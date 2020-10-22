// To parse this JSON data, do
//
//     final bcnSyncingRequest = bcnSyncingRequestFromJson(jsonString);

import 'dart:convert';

BcnSyncingRequest bcnSyncingRequestFromJson(String str) => BcnSyncingRequest.fromJson(json.decode(str));

String bcnSyncingRequestToJson(BcnSyncingRequest data) => json.encode(data.toJson());

class BcnSyncingRequest {
    BcnSyncingRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<dynamic> params;
    int id;
    String key;

    static const METHOD_NAME = "bcn_syncing";

    factory BcnSyncingRequest.fromJson(Map<String, dynamic> json) => BcnSyncingRequest(
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
