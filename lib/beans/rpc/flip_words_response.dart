// To parse this JSON data, do
//
//     final flipWordsResponse = flipWordsResponseFromJson(jsonString);

import 'dart:convert';

FlipWordsResponse flipWordsResponseFromJson(String str) => FlipWordsResponse.fromJson(json.decode(str));

String flipWordsResponseToJson(FlipWordsResponse data) => json.encode(data.toJson());

class FlipWordsResponse {
    FlipWordsResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    Result result;

    factory FlipWordsResponse.fromJson(Map<String, dynamic> json) => FlipWordsResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
    };
}

class Result {
    Result({
        this.words,
    });

    List<int> words;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        words: List<int>.from(json["words"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "words": List<dynamic>.from(words.map((x) => x)),
    };
}
