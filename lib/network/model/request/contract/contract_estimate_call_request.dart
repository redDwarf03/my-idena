// To parse this JSON data, do
//
//     final contractEstimateCallRequest = contractEstimateCallRequestFromJson(jsonString);

import 'dart:convert';

ContractEstimateCallRequest contractEstimateCallRequestFromJson(String str) => ContractEstimateCallRequest.fromJson(json.decode(str));

String contractEstimateCallRequestToJson(ContractEstimateCallRequest data) => json.encode(data.toJson());

class ContractEstimateCallRequest {
    ContractEstimateCallRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_estimateCall";

    factory ContractEstimateCallRequest.fromJson(Map<String, dynamic> json) => ContractEstimateCallRequest(
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
        this.from,
        this.contract,
        this.method,
        this.amount,
        this.maxFee,
        this.args,
    });

    String from;
    String contract;
    String method;
    int amount;
    int maxFee;
    List<Arg> args;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        from: json["from"],
        contract: json["contract"],
        method: json["method"],
        amount: json["amount"],
        maxFee: json["maxFee"],
        args: List<Arg>.from(json["args"].map((x) => Arg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "contract": contract,
        "method": method,
        "amount": amount,
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
