// To parse this JSON data, do
//
//     final bcnTransactionsResponse = bcnTransactionsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/model/address.dart';
import 'package:my_idena/util/numberutil.dart';

BcnTransactionsResponse bcnTransactionsResponseFromJson(String str) =>
    BcnTransactionsResponse.fromJson(json.decode(str));

String bcnTransactionsResponseToJson(BcnTransactionsResponse data) =>
    json.encode(data.toJson());

class BcnTransactionsResponse {
  BcnTransactionsResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  String jsonrpc;
  int id;
  BcnTransactionsResponseResult result;

  factory BcnTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      BcnTransactionsResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: BcnTransactionsResponseResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
      };
}

class BcnTransactionsResponseResult {
  BcnTransactionsResponseResult({
    this.transactions,
  });

  List<Transaction> transactions;

  factory BcnTransactionsResponseResult.fromJson(Map<String, dynamic> json) =>
      BcnTransactionsResponseResult(
        transactions: json["transactions"] == null
            ? null
            : List<Transaction>.from(
                json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.hash,
    this.type,
    this.from,
    this.to,
    this.amount,
    this.tips,
    this.maxFee,
    this.nonce,
    this.epoch,
    this.payload,
    this.blockHash,
    this.usedFee,
    this.timestamp,
  });

  String hash;
  String type;
  String from;
  dynamic to;
  String amount;
  String tips;
  String maxFee;
  int nonce;
  int epoch;
  String payload;
  String blockHash;
  String usedFee;
  int timestamp;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        hash: json["hash"],
        type: json["type"],
        from: json["from"],
        to: json["to"],
        amount: json["amount"],
        tips: json["tips"],
        maxFee: json["maxFee"],
        nonce: json["nonce"],
        epoch: json["epoch"],
        payload: json["payload"],
        blockHash: json["blockHash"],
        usedFee: json["usedFee"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "hash": hash,
        "type": type,
        "from": from,
        "to": to,
        "amount": amount,
        "tips": tips,
        "maxFee": maxFee,
        "nonce": nonce,
        "epoch": epoch,
        "payload": payload,
        "blockHash": blockHash,
        "usedFee": usedFee,
        "timestamp": timestamp,
      };

  String getFormattedAmount() {
    return NumberUtil.getRawAsUsableString(amount.toString());
  }

  String getShortString(BuildContext context) {
    if (this.from != StateContainer.of(context).selectedAccount.address) {
      return new Address(this.from).getShorterString();
    } else {
      return new Address(this.to).getShorterString();
    }
  }

  String getShorterString(BuildContext context) {
    if (this.from != StateContainer.of(context).selectedAccount.address) {
      return new Address(this.from).getShorterString();
    } else {
      return new Address(this.to).getShorterString();
    }
  }
}
