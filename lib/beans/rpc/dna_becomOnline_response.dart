// To parse this JSON data, do
//
//     final dnaBecomeOnlineResponse = dnaBecomeOnlineResponseFromJson(jsonString);

import 'dart:convert';

DnaBecomeOnlineResponse dnaBecomeOnlineResponseFromJson(String str) => DnaBecomeOnlineResponse.fromJson(json.decode(str));

String dnaBecomeOnlineResponseToJson(DnaBecomeOnlineResponse data) => json.encode(data.toJson());

class DnaBecomeOnlineResponse {
    DnaBecomeOnlineResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    String result;

    factory DnaBecomeOnlineResponse.fromJson(Map<String, dynamic> json) => DnaBecomeOnlineResponse(
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
