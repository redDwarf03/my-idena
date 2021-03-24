// @dart=2.9
// To parse this JSON data, do
//
//     final flipWordsRequest = flipWordsRequestFromJson(jsonString);

import 'dart:convert';

FlipWordsRequest flipWordsRequestFromJson(String str) => FlipWordsRequest.fromJson(json.decode(str));

String flipWordsRequestToJson(FlipWordsRequest data) => json.encode(data.toJson());

class FlipWordsRequest {
    FlipWordsRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<String> params;
    int id;
    String key;

    static const String METHOD_NAME = "flip_words";

    factory FlipWordsRequest.fromJson(Map<String, dynamic> json) => FlipWordsRequest(
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
