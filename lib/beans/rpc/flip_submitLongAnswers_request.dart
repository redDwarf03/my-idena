// To parse this JSON data, do
//
//     final flipSubmitLongAnswersRequest = flipSubmitLongAnswersRequestFromJson(jsonString);

import 'dart:convert';

FlipSubmitLongAnswersRequest flipSubmitLongAnswersRequestFromJson(String str) => FlipSubmitLongAnswersRequest.fromJson(json.decode(str));

String flipSubmitLongAnswersRequestToJson(FlipSubmitLongAnswersRequest data) => json.encode(data.toJson());

class FlipSubmitLongAnswersRequest {
    FlipSubmitLongAnswersRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

    static const String METHOD_NAME = "flip_submitLongAnswers";

    factory FlipSubmitLongAnswersRequest.fromJson(Map<String, dynamic> json) => FlipSubmitLongAnswersRequest(
        method: json["method"],
        params: List<Param>.from(json["params"].map((x) => Param.fromJson(x))),
        id: json["id"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "params": List<dynamic>.from(params.map((x) => x.toJson())),
        "id": id,
        "key": key,
    };
}

class Param {
    Param({
        this.answers,
        this.nonce,
        this.epoch,
    });

    List<Answer> answers;
    int nonce;
    int epoch;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        nonce: json["nonce"],
        epoch: json["epoch"],
    );

    Map<String, dynamic> toJson() => {
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "nonce": nonce,
        "epoch": epoch,
    };
}

class Answer {
    Answer({
        this.hash,
        this.answer,
        this.easy,
    });

    String hash;
    int answer;
    bool easy;

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        hash: json["hash"],
        answer: json["answer"],
        easy: json["easy"],
    );

    Map<String, dynamic> toJson() => {
        "hash": hash,
        "answer": answer,
        "easy": easy,
    };
}
