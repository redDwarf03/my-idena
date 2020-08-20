// To parse this JSON data, do
//
//     final flipSubmitShortAnswersRequest = flipSubmitShortAnswersRequestFromJson(jsonString);

import 'dart:convert';

FlipSubmitShortAnswersRequest flipSubmitShortAnswersRequestFromJson(String str) => FlipSubmitShortAnswersRequest.fromJson(json.decode(str));

String flipSubmitShortAnswersRequestToJson(FlipSubmitShortAnswersRequest data) => json.encode(data.toJson());

class FlipSubmitShortAnswersRequest {
    FlipSubmitShortAnswersRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<ParamShortAnswer> params;
    int id;
    String key;

    static const String METHOD_NAME = "flip_submitLongAnswers";

    factory FlipSubmitShortAnswersRequest.fromJson(Map<String, dynamic> json) => FlipSubmitShortAnswersRequest(
        method: json["method"],
        params: List<ParamShortAnswer>.from(json["params"].map((x) => ParamShortAnswer.fromJson(x))),
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

class ParamShortAnswer {
    ParamShortAnswer({
        this.answers,
        this.nonce,
        this.epoch,
    });

    List<ShortAnswer> answers;
    int nonce;
    int epoch;

    factory ParamShortAnswer.fromJson(Map<String, dynamic> json) => ParamShortAnswer(
        answers: List<ShortAnswer>.from(json["answers"].map((x) => ShortAnswer.fromJson(x))),
        nonce: json["nonce"],
        epoch: json["epoch"],
    );

    Map<String, dynamic> toJson() => {
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "nonce": nonce,
        "epoch": epoch,
    };
}

class ShortAnswer {
    ShortAnswer({
        this.hash,
        this.answer,
        this.wrongWords,
    });

    String hash;
    int answer;
    bool wrongWords;

    factory ShortAnswer.fromJson(Map<String, dynamic> json) => ShortAnswer(
        hash: json["hash"],
        answer: json["answer"],
        wrongWords: json["wrongWords"],
    );

    Map<String, dynamic> toJson() => {
        "hash": hash,
        "answer": answer,
        "wrongWords": wrongWords,
    };
}
