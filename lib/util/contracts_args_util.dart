// @dart=2.9
import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:decimal/decimal.dart';
import 'package:my_idena/network/model/request/contract/contract_deploy_request.dart';
import 'package:my_idena/util/crypto/bigint.dart' as bigint;
import 'package:my_idena/util/crypto/utils_crypto.dart';
import 'package:my_idena/pubdev/ethereum_util/utils.dart' as ethereum_utils;

const DNA_BASE = '1000000000000000000';

Uint8List toBytes(Arg data) {
  try {
    switch (data.format) {
      case 'byte': {
        int val = int.tryParse(data.value, radix: 10);
        if (val >= 0 && val <= 255) {
          return intToBuffer(val);
        }
        throw new Exception('invalid byte value');
      }
      case 'int8': {
        int val = int.tryParse(data.value, radix: 10);
        if (val >= 0 && val <= 255) {
          return intToBuffer(val);
        }
        throw new Exception('invalid int8 value');
      }
      case 'uint64': {
        if(BigInt.parse(data.value).isNegative) throw new Exception('invalid uint64 value');
        return Uint8List(8)..buffer.asByteData().setInt64(0, int.tryParse(data.value, radix: 10), Endian.little);
      }
      case 'int64': {
        return Uint8List(8)..buffer.asByteData().setInt64(0, int.tryParse(data.value, radix: 10), Endian.little);
      }
      case 'string': {
        return Uint8List.fromList(utf8.encode(data.value));
      }
      case 'bigint': {
        return Uint8List.fromList(bigint.encodeBigInt(BigInt.parse(data.value)));
      }
      case 'hex': {
        return Uint8List.fromList(
            hex.decode(ethereum_utils.padToEven(ethereum_utils.stripHexPrefix(data.value))));
      }
      case 'dna': {
         return Uint8List.fromList(bigint.encodeBigInt(BigInt.parse(
          (Decimal.parse(data.value) * Decimal.parse(DNA_BASE))
              .toString())));
      }
      default: {
        return Uint8List.fromList(
            hex.decode(ethereum_utils.padToEven(ethereum_utils.stripHexPrefix(data.value))));
      }
    }
  } catch (e) {
    throw new Exception(
      'cannot parse ${data.format} at index ${data.index}: ${e.message}'
    );
  }
}

List<Uint8List> argsToSlice(List<Arg> args) {

  List<Uint8List> result = new List.filled(args.length, null);

  args.forEach((element) => {
    result[element.index] = toBytes(element)
  });

  return result;
}
