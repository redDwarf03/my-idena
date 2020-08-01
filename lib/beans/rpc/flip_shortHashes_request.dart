// To parse this JSON data, do
//
//     final flipShortHashesRequest = flipShortHashesRequestFromJson(jsonString);

import 'dart:convert';

FlipShortHashesRequest flipShortHashesRequestFromJson(String str) => FlipShortHashesRequest.fromJson(json.decode(str));

String flipShortHashesRequestToJson(FlipShortHashesRequest data) => json.encode(data.toJson());

class FlipShortHashesRequest {
    FlipShortHashesRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<dynamic> params;
    int id;
    String key;

    static const String METHOD_NAME = "flip_shortHashes";

    factory FlipShortHashesRequest.fromJson(Map<String, dynamic> json) => FlipShortHashesRequest(
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
