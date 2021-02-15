// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:typed_data' show Uint8List;
import 'package:convert/convert.dart' show hex;
import 'package:hex/hex.dart' show HEX;
import 'package:web3dart/crypto.dart' as crypto show keccak256, hexToBytes, intToBytes, MsgSignature, sign;
import 'package:ethereum_util/ethereum_util.dart' as ethereum_util show toBuffer, intToBuffer, padToEven;
import 'package:my_idena/protos/models.pb.dart' show ProtoTransaction, ProtoTransaction_Data;

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
    if (this.nonce != null && this.amount != 0) {
      data.nonce = this.nonce;
    }
    if (this.epoch != null && this.amount != 0) {
      data.epoch = this.epoch;
    }
    if (this.type != null && this.type != 0) {
      data.type = this.type;
    }
    if (this.to != null) {
      data.to = ethereum_util.toBuffer(this.to);
    }
    if (this.amount != null && this.amount != 0) {
      data.amount = bigIntToBuffer(this.amount);
    }
    if (this.maxFee != null && this.maxFee != 0) {
      data.maxFee = ethereum_util.intToBuffer(this.maxFee);
    }
    if (this.tips != null && this.tips != 0) {
      data.tips = ethereum_util.intToBuffer(this.tips);
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
    //print("messageHash: " + hex.encode(messageHash));
    crypto.MsgSignature msgSignature =
        crypto.sign(messageHash, crypto.hexToBytes(privateKey));

    //print("signature: " + signature.toString());
    final header = msgSignature.v & 0xFF;
    var recId = header - 27;
    this.signature = Uint8List.fromList(([
      ...padUint8ListTo32(crypto.intToBytes(msgSignature.r)),
      ...padUint8ListTo32(crypto.intToBytes(msgSignature.s)),
      recId
    ]));

    //print("signature: " + hex.encode(this.signature));

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

  Uint8List padUint8ListTo32(Uint8List data) {
    assert(data.length <= 32);
    if (data.length == 32) return data;

    // todo there must be a faster way to do this?
    return Uint8List(32)..setRange(32 - data.length, 32, data);
  }

  /// Converts a [BigInt] into a hex [String]
  String bigIntToHex(BigInt i) {
    return "0x${i.toRadixString(16)}";
  }

  /// Converts an [BigInt] to a [Uint8List]
  Uint8List bigIntToBuffer(BigInt i) {
    return Uint8List.fromList(
        hex.decode(ethereum_util.padToEven(bigIntToHex(i).substring(2))));
  }
}
