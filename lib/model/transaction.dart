// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:hex/hex.dart';
import 'package:my_idena/util/crypto/ecurve.dart';
import 'package:web3dart/crypto.dart' as crypto;
import 'package:ethereum_util/ethereum_util.dart' as ethereum_util;
import 'package:my_idena/protos/models.pb.dart';

class Transaction {
  Transaction(nonce, epoch, type, to, amount, maxFee, tips, payload) {
    this.nonce = nonce == null ? 0 : nonce;
    this.epoch = epoch == null ? 0 : epoch;
    this.type = type == null ? 0 : type;
    this.to = to == null ? "" : to;
    this.amount = amount == null ? 0 : amount;
    this.maxFee = maxFee == null ? 0 : maxFee;
    this.tips = tips == null ? 0 : tips;
    this.payload = payload == null ? null : payload;
    this.signature = null;
  }

  var nonce;
  var epoch;
  var type;
  var to;
  var amount;
  var maxFee;
  var tips;
  var payload;
  var signature;

  String toHex() {
   
    return hex.encode(this.toBytes());
    
  }

  Uint8List toBytes() {
    ProtoTransaction transaction = new ProtoTransaction();
    transaction.data = this._createProtoTxData();
    if (this.signature != null) {
      transaction.signature = ethereum_util.toBuffer(this.signature);
    }
    return transaction.writeToBuffer();
  }

  ProtoTransaction_Data _createProtoTxData() {
    ProtoTransaction_Data data = new ProtoTransaction_Data();
    data.nonce = this.nonce;
    data.epoch = this.epoch;
    data.type = this.type;
    if (this.to != null) {
      data.to = ethereum_util.toBuffer(this.to);
    }
    if (this.amount != null) {
      data.amount = ethereum_util.toBuffer(this.amount);
    }
    if (this.maxFee != null) {
      data.maxFee = ethereum_util.toBuffer(this.maxFee);
    }
    if (this.tips != null) {
      data.tips = ethereum_util.toBuffer(this.tips);
    }
    if (this.payload != null) {
      data.payload = ethereum_util.toBuffer(this.payload);
    }
    
    return data;
  }

  String toHexString(byteArray, bool withPrefix) {
    return ((withPrefix ? '0x' : '') +
        HEX.encode(ethereum_util.toBuffer(byteArray)));
  }

  Transaction sign(String privateKey) {
    //print("this._createProtoTxData().writeToBuffer() : " +
    //    this._createProtoTxData().toString());

    //print(hex.encode(this._createProtoTxData().writeToBuffer()));

    Uint8List messageHash =
        crypto.keccak256(this._createProtoTxData().writeToBuffer());

    //print("messageHash: " + messageHash.toString());
    print("messageHash: " + hex.encode(messageHash));
    this.signature =
        signECSignature(messageHash, crypto.hexToBytes(privateKey));

    //print("signature: " + signature.toString());

    this.signature = Uint8List.fromList(([...this.signature, 0]));
    
    print("signature: " + hex.encode(this.signature));
    //print("signature: " + signature.toString());

    return this;
  }

  fromHex(var hex) {
    return this.fromBytes(ethereum_util.toBuffer(hex));
  }

  Transaction fromBytes(bytes) {
    ProtoTransaction protoTx = ProtoTransaction.fromBuffer(bytes);
    ProtoTransaction_Data protoTxData = protoTx.data;
    this.nonce = protoTxData.nonce;
    this.epoch = protoTxData.epoch;
    this.type = protoTxData.type;
    this.to = toHexString(protoTxData.to, true);

    this.amount = Uint8List.fromList(protoTxData.amount);
    this.maxFee = Uint8List.fromList(protoTxData.maxFee);
    this.tips = Uint8List.fromList(protoTxData.tips);
    this.payload = protoTxData.payload;
    this.signature = HEX.encode(protoTx.signature);

    return this;
  }
}
