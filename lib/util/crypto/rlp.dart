import 'dart:convert' show utf8;
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:my_idena/util/crypto/bigint.dart';
import 'package:my_idena/util/crypto/utils_crypto.dart';


class Decoded {
  dynamic data;
  Uint8List remainder;
  Decoded(this.data, this.remainder);
}

Uint8List encodeRlp(dynamic input) {
  if (input is List && !(input is Uint8List)) {
    final output = <Uint8List>[];
    for (var data in input) {
      output.add(encodeRlp(data));
    }

    final data = _concat(output);
    return _concat([encodeLength(data.length, 192), data]);
  } else {
    final data = _toBuffer(input);

    if (data.length == 1 && data[0] < 128) {
      return data;
    } else {
      return _concat([encodeLength(data.length, 128), data]);
    }
  }
}

Uint8List encodeLength(int length, int offset) {
  if (length < 56) {
    return Uint8List.fromList([length + offset]);
  } else {
    final hexLen = _intToHex(length);
    final lLength = hexLen.length ~/ 2;

    return _concat([
      Uint8List.fromList([offset + 55 + lLength]),
      Uint8List.fromList(hex.decode(hexLen))
    ]);
  }
}

dynamic decodeRlp(Uint8List input, [bool stream = false]) {
  if (input == null || input.length == 0) {
    return <dynamic>[];
  }

  Uint8List inputBuffer = _toBuffer(input);
  Decoded decoded = _decode(inputBuffer);

  if (stream) {
    return decoded;
  }
  if (decoded.remainder.length != 0) {
    throw FormatException('invalid remainder');
  }

  return decoded.data;
}

Decoded _decode(Uint8List input) {
  int firstByte = input[0];
  if (firstByte <= 0x7f) {
    // a single byte whose value is in the [0x00, 0x7f] range, that byte is its own RLP encoding.
    return Decoded(input.sublist(0, 1), input.sublist(1));
  } else if (firstByte <= 0xb7) {
    // string is 0-55 bytes long. A single byte with value 0x80 plus the length of the string followed by the string
    // The range of the first byte is [0x80, 0xb7]
    int length = firstByte - 0x7f;

    // set 0x80 null to 0
    Uint8List data =
        firstByte == 0x80 ? Uint8List(0) : input.sublist(1, length);

    if (length == 2 && data[0] < 0x80) {
      throw FormatException('invalid rlp encoding: byte must be less 0x80');
    }

    return Decoded(data, input.sublist(length));
  } else if (firstByte <= 0xbf) {
    int llength = firstByte - 0xb6;
    int length = safeParseInt(hex.encode(input.sublist(1, llength)), 16);
    Uint8List data = input.sublist(llength, length + llength);
    if (data.length < length) {
      throw FormatException('invalid RLP');
    }

    return Decoded(data, input.sublist(length + llength));
  } else if (firstByte <= 0xf7) {
    // a list between  0-55 bytes long
    List<dynamic> decoded = <dynamic>[];
    int length = firstByte - 0xbf;
    Uint8List innerRemainder = input.sublist(1, length);
    while (innerRemainder.length > 0) {
      Decoded d = _decode(innerRemainder);
      decoded.add(d.data);
      innerRemainder = d.remainder;
    }

    return Decoded(decoded, input.sublist(length));
  } else {
    // a list  over 55 bytes long
    List<dynamic> decoded = <dynamic>[];
    int llength = firstByte - 0xf6;
    int length = safeParseInt(hex.encode(input.sublist(1, llength)), 16);
    int totalLength = llength + length;
    if (totalLength > input.length) {
      throw FormatException(
          'invalid rlp: total length is larger than the data');
    }

    Uint8List innerRemainder = input.sublist(llength, totalLength);
    if (innerRemainder.length == 0) {
      throw FormatException('invalid rlp, List has a invalid length');
    }

    while (innerRemainder.length > 0) {
      Decoded d = _decode(innerRemainder);
      decoded.add(d.data);
      innerRemainder = d.remainder;
    }
    return Decoded(decoded, input.sublist(totalLength));
  }
}

int safeParseInt(String v, [int base]) {
  if (v.startsWith('00')) {
    throw FormatException('invalid RLP: extra zeros');
  }

  return int.parse(v, radix: base);
}

Uint8List _toBuffer(dynamic data) {
  if (data is Uint8List) return data;

  if (data is String) {
    if (isHexString(data)) {
      return Uint8List.fromList(hex.decode(padToEven(stripHexPrefix(data))));
    } else {
      return Uint8List.fromList(utf8.encode(data));
    }
  } else if (data is int) {
    if (data == 0) return Uint8List(0);

    return Uint8List.fromList(intToBuffer(data));
  } else if (data is BigInt) {
    if (data == BigInt.zero) return Uint8List(0);

    return Uint8List.fromList(encodeBigInt(data));
  } else if (data is List<int>) {
    return Uint8List.fromList(data);
  }

  throw TypeError();
}

Uint8List _concat(List<Uint8List> lists) {
  final list = <int>[];

  lists.forEach(list.addAll);

  return Uint8List.fromList(list);
}

String _intToHex(int a) {
  return hex.encode(_toBuffer(a));
}
