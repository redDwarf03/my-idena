// @dart=2.9
// To parse this JSON data, do
//
//     final flipLongHashesRequest = flipLongHashesRequestFromJson(jsonString);

import 'dart:convert';

FlipLongHashesRequest flipLongHashesRequestFromJson(String str) => FlipLongHashesRequest.fromJson(json.decode(str));

String flipLongHashesRequestToJson(FlipLongHashesRequest data) => json.encode(data.toJson());

class FlipLongHashesRequest {
    FlipLongHashesRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<dynamic> params;
    int id;
    String key;

    static const String METHOD_NAME = "flip_longHashes";

    factory FlipLongHashesRequest.fromJson(Map<String, dynamic> json) => FlipLongHashesRequest(
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
