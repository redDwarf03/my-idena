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
    List<ParamLongAnswer> params;
    int id;
    String key;

    static const String METHOD_NAME = "flip_submitLongAnswers";

    factory FlipSubmitLongAnswersRequest.fromJson(Map<String, dynamic> json) => FlipSubmitLongAnswersRequest(
        method: json["method"],
        params: List<ParamLongAnswer>.from(json["params"].map((x) => ParamLongAnswer.fromJson(x))),
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

class ParamLongAnswer {
    ParamLongAnswer({
        this.answers,
        this.nonce,
        this.epoch,
    });

    List<LongAnswer> answers;
    int nonce;
    int epoch;

    factory ParamLongAnswer.fromJson(Map<String, dynamic> json) => ParamLongAnswer(
        answers: List<LongAnswer>.from(json["answers"].map((x) => LongAnswer.fromJson(x))),
        nonce: json["nonce"],
        epoch: json["epoch"],
    );

    Map<String, dynamic> toJson() => {
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "nonce": nonce,
        "epoch": epoch,
    };
}

class LongAnswer {
    LongAnswer({
        this.hash,
        this.answer,
        this.easy,
    });

    String hash;
    int answer;
    bool easy;

    factory LongAnswer.fromJson(Map<String, dynamic> json) => LongAnswer(
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
