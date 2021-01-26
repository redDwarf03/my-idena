// To parse this JSON data, do
//
//     final dnaIdentityResponse = dnaIdentityResponseFromJson(jsonString);

import 'dart:convert';

DnaIdentityResponse dnaIdentityResponseFromJson(String str) =>
    DnaIdentityResponse.fromJson(json.decode(str));

String dnaIdentityResponseToJson(DnaIdentityResponse data) =>
    json.encode(data.toJson());

class DnaIdentityResponse {
  DnaIdentityResponse({
    this.jsonrpc,
    this.id,
    this.result,
    this.error,
  });

  String jsonrpc;
  int id;
  DnaIdentityResponseResult result;
  DnaIdentityResponseError error;

  factory DnaIdentityResponse.fromJson(Map<String, dynamic> json) =>
      DnaIdentityResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null ? null : DnaIdentityResponseResult.fromJson(json["result"]),
        error: json["error"] == null ? null : DnaIdentityResponseError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
        "error": error.toJson(),
      };
}

class DnaIdentityResponseResult {
  DnaIdentityResponseResult({
    this.address,
    this.profileHash,
    this.stake,
    this.invites,
    this.age,
    this.state,
    this.pubkey,
    this.requiredFlips,
    this.availableFlips,
    this.flipKeyWordPairs,
    this.madeFlips,
    this.totalQualifiedFlips,
    this.totalShortFlipPoints,
    this.flips,
    this.online,
    this.generation,
    this.code,
    this.invitees,
    this.penalty,
    this.lastValidationFlags,
  });

  String address;
  String profileHash;
  String stake;
  int invites;
  int age;
  String state;
  String pubkey;
  int requiredFlips;
  int availableFlips;
  List<FlipKeyWordPair> flipKeyWordPairs;
  int madeFlips;
  int totalQualifiedFlips;
  double totalShortFlipPoints;
  dynamic flips;
  bool online;
  int generation;
  String code;
  List<Invitee> invitees;
  String penalty;
  dynamic lastValidationFlags;

  factory DnaIdentityResponseResult.fromJson(Map<String, dynamic> json) =>
      DnaIdentityResponseResult(
        address: json["address"],
        profileHash: json["profileHash"],
        stake: json["stake"],
        invites: json["invites"],
        age: json["age"],
        state: json["state"],
        pubkey: json["pubkey"],
        requiredFlips: json["requiredFlips"],
        availableFlips: json["availableFlips"],
        flipKeyWordPairs: json["flipKeyWordPairs"] == null
            ? null
            : List<FlipKeyWordPair>.from(json["flipKeyWordPairs"]
                .map((x) => FlipKeyWordPair.fromJson(x))),
        madeFlips: json["madeFlips"],
        totalQualifiedFlips: json["totalQualifiedFlips"],
        totalShortFlipPoints: json["totalShortFlipPoints"].toDouble(),
        flips: json["flips"],
        online: json["online"],
        generation: json["generation"],
        code: json["code"],
        invitees: json["invitees"] == null
            ? null
            : List<Invitee>.from(
                json["invitees"].map((x) => Invitee.fromJson(x))),
        penalty: json["penalty"],
        lastValidationFlags: json["lastValidationFlags"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "profileHash": profileHash,
        "stake": stake,
        "invites": invites,
        "age": age,
        "state": state,
        "pubkey": pubkey,
        "requiredFlips": requiredFlips,
        "availableFlips": availableFlips,
        "flipKeyWordPairs":
            List<dynamic>.from(flipKeyWordPairs.map((x) => x.toJson())),
        "madeFlips": madeFlips,
        "totalQualifiedFlips": totalQualifiedFlips,
        "totalShortFlipPoints": totalShortFlipPoints,
        "flips": flips,
        "online": online,
        "generation": generation,
        "code": code,
        "invitees": List<dynamic>.from(invitees.map((x) => x.toJson())),
        "penalty": penalty,
        "lastValidationFlags": lastValidationFlags,
      };
}

class FlipKeyWordPair {
  FlipKeyWordPair({
    this.words,
    this.used,
    this.id,
  });

  List<int> words;
  bool used;
  int id;

  factory FlipKeyWordPair.fromJson(Map<String, dynamic> json) =>
      FlipKeyWordPair(
        words: List<int>.from(json["words"].map((x) => x)),
        used: json["used"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "words": List<dynamic>.from(words.map((x) => x)),
        "used": used,
        "id": id,
      };
}

class Invitee {
  Invitee({
    this.txHash,
    this.address,
  });

  String txHash;
  String address;

  factory Invitee.fromJson(Map<String, dynamic> json) => Invitee(
        txHash: json["TxHash"],
        address: json["Address"],
      );

  Map<String, dynamic> toJson() => {
        "TxHash": txHash,
        "Address": address,
      };
}

class DnaIdentityResponseError {
  DnaIdentityResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory DnaIdentityResponseError.fromJson(Map<String, dynamic> json) =>
      DnaIdentityResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

