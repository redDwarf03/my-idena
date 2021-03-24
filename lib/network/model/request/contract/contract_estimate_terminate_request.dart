// @dart=2.9
// To parse this JSON data, do
//
//     final contractEstimateTerminateRequest = contractEstimateTerminateRequestFromJson(jsonString);

import 'dart:convert';

ContractEstimateTerminateRequest contractEstimateTerminateRequestFromJson(String str) => ContractEstimateTerminateRequest.fromJson(json.decode(str));

String contractEstimateTerminateRequestToJson(ContractEstimateTerminateRequest data) => json.encode(data.toJson());

class ContractEstimateTerminateRequest {
    ContractEstimateTerminateRequest({
        this.method,
        this.params,
    });

    String method;
    List<Param> params;

    static const METHOD_NAME = "contract_estimateDeploy";

    factory ContractEstimateTerminateRequest.fromJson(Map<String, dynamic> json) => ContractEstimateTerminateRequest(
        method: json["method"],
        params: List<Param>.from(json["params"].map((x) => Param.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "params": List<dynamic>.from(params.map((x) => x.toJson())),
    };
}

class Param {
    Param({
        this.from,
        this.contract,
        this.maxFee,
        this.args,
    });

    String from;
    String contract;
    int maxFee;
    List<Arg> args;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        from: json["from"],
        contract: json["contract"],
        maxFee: json["maxFee"],
        args: List<Arg>.from(json["args"].map((x) => Arg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "contract": contract,
        "maxFee": maxFee,
        "args": List<dynamic>.from(args.map((x) => x.toJson())),
    };
}

class Arg {
    Arg({
        this.index,
        this.format,
        this.value,
    });

    int index;
    String format;
    String value;

    factory Arg.fromJson(Map<String, dynamic> json) => Arg(
        index: json["index"],
        format: json["format"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "format": format,
        "value": value,
    };
}
