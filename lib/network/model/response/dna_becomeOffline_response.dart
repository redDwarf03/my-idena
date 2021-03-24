// @dart=2.9
// To parse this JSON data, do
//
//     final dnaBecomeOfflineResponse = dnaBecomeOfflineResponseFromJson(jsonString);

import 'dart:convert';

DnaBecomeOfflineResponse dnaBecomeOfflineResponseFromJson(String str) => DnaBecomeOfflineResponse.fromJson(json.decode(str));

String dnaBecomeOfflineResponseToJson(DnaBecomeOfflineResponse data) => json.encode(data.toJson());

class DnaBecomeOfflineResponse {
    DnaBecomeOfflineResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    String result;

    factory DnaBecomeOfflineResponse.fromJson(Map<String, dynamic> json) => DnaBecomeOfflineResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result,
    };
}
