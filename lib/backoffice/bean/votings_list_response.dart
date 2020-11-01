// To parse this JSON data, do
//
//     final votingsListResponse = votingsListResponseFromJson(jsonString);

import 'dart:convert';
import 'package:convert/convert.dart';

VotingsListResponse votingsListResponseFromJson(String str) =>
    VotingsListResponse.fromJson(json.decode(str));

String votingsListResponseToJson(VotingsListResponse data) =>
    json.encode(data.toJson());

class VotingsListResponse {
  VotingsListResponse({
    this.result,
  });

  List<VotingsListResponseResult> result;

  factory VotingsListResponse.fromJson(Map<String, dynamic> json) =>
      VotingsListResponse(
        result: List<VotingsListResponseResult>.from(
            json["result"].map((x) => VotingsListResponseResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class VotingsListResponseResult {
  VotingsListResponseResult({
    this.contractAddress,
    this.balance,
    this.fact,
    this.title,
    this.desc,
    this.voteProofsCount,
    this.votesCount,
    this.state,
    this.votes,
  });

  String contractAddress;
  String balance;
  String fact;
  String title;
  String desc;
  int voteProofsCount;
  int votesCount;
  String state;
  List<Vote> votes;

  factory VotingsListResponseResult.fromJson(Map<String, dynamic> json) =>
      VotingsListResponseResult(
        contractAddress: json["contractAddress"],
        balance: json["balance"],
        fact: json["fact"],
        title: jsonDecode(String.fromCharCodes(
            hex.decode(json["fact"].substring(2))))["title"],
        desc: jsonDecode(String.fromCharCodes(
            hex.decode(json["fact"].substring(2))))["desc"],
        voteProofsCount: json["voteProofsCount"],
        votesCount: json["votesCount"],
        state: json["state"],
        votes: json["votes"] == null
            ? null
            : List<Vote>.from(json["votes"].map((x) => Vote.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contractAddress": contractAddress,
        "balance": balance,
        "fact": fact,
        "title": title,
        "desc": desc,
        "voteProofsCount": voteProofsCount,
        "votesCount": votesCount,
        "state": state,
        "votes": votes == null
            ? null
            : List<dynamic>.from(votes.map((x) => x.toJson())),
      };
}

class Vote {
  Vote({
    this.option,
    this.count,
  });

  int option;
  int count;

  factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        option: json["option"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "option": option,
        "count": count,
      };
}
