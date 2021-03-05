import 'dart:convert' show utf8;
import 'dart:typed_data';

import 'package:convert/convert.dart' show hex;
import 'package:my_idena/util/crypto/bigint.dart';
import 'package:quiver/check.dart';

bool isHexPrefixed(String str) {
  checkNotNull(str);

  return str.substring(0, 2) == '0x';
}

String stripHexPrefix(String str) {
  checkNotNull(str);

  return isHexPrefixed(str) ? str.substring(2) : str;
}

/// Attempts to turn a value into a [Uint8List]. As input it supports [Uint8List], [String], [int], [null], [BigInt] method.
Uint8List toBuffer(v) {
  if (!(v is Uint8List)) {
    if (v is List) {
      v = Uint8List.fromList(v);
    } else if (v is String) {
      if (isHexString(v)) {
        v = Uint8List.fromList(hex.decode(padToEven(stripHexPrefix(v))));
      } else {
        v = Uint8List.fromList(utf8.encode(v));
      }
    } else if (v is int) {
      v = intToBuffer(v);
    } else if (v == null) {
      v = Uint8List(0);
    } else if (v is BigInt) {
      v = Uint8List.fromList(encodeBigInt(v));
    } else {
      throw 'invalid type';
    }
  }

  return v;
}

/// Pads a [String] to have an even length
String padToEven(String value) {
  checkNotNull(value);

  var a = "$value";

  if (a.length % 2 == 1) {
    a = "0$a";
  }

  return a;
}

/// Converts a [int] into a hex [String]
String intToHex(int i) {
  checkNotNull(i);

  return "0x${i.toRadixString(16)}";
}

/// Converts an [int] to a [Uint8List]
Uint8List intToBuffer(int i) {
  checkNotNull(i);

  return Uint8List.fromList(hex.decode(padToEven(intToHex(i).substring(2))));
}

/// Get the binary size of a string
int getBinarySize(String str) {
  checkNotNull(str);

  return utf8.encode(str).length;
}

/// Returns TRUE if the first specified array contains all elements
/// from the second one. FALSE otherwise.
bool arrayContainsArray(List superset, List subset, {bool some: false}) {
  checkNotNull(superset);
  checkNotNull(subset);

  if (some) {
    return Set.from(superset).intersection(Set.from(subset)).length > 0;
  } else {
    return Set.from(superset).containsAll(subset);
  }
}

/// Should be called to get utf8 from it's hex representation
String toUtf8(String hexString) {
  checkNotNull(hexString);

  var bufferValue = hex.decode(
      padToEven(stripHexPrefix(hexString).replaceAll(RegExp('^0+|0+\$'), '')));

  return utf8.decode(bufferValue);
}

/// Should be called to get ascii from it's hex representation
String toAscii(String hexString) {
  checkNotNull(hexString);

  var start = hexString.startsWith(RegExp('^0x')) ? 2 : 0;
  return String.fromCharCodes(hex.decode(hexString.substring(start)));
}

/// Should be called to get hex representation (prefixed by 0x) of utf8 string
String fromUtf8(String stringValue) {
  checkNotNull(stringValue);

  var stringBuffer = utf8.encode(stringValue);

  return "0x${padToEven(hex.encode(stringBuffer)).replaceAll(RegExp('^0+|0+\$'), '')}";
}

/// Should be called to get hex representation (prefixed by 0x) of ascii string
String fromAscii(String stringValue) {
  checkNotNull(stringValue);

  var hexString = ''; // eslint-disable-line
  for (var i = 0; i < stringValue.length; i++) {
    // eslint-disable-line
    var code = stringValue.codeUnitAt(i);
    var n = hex.encode([code]);
    hexString += n.length < 2 ? "0$n" : n;
  }

  return "0x$hexString";
}

/// Is the string a hex string.
bool isHexString(String value, {int length = 0}) {
  checkNotNull(value);

  if (!RegExp('^0x[0-9A-Fa-f]*\$').hasMatch(value)) {
    return false;
  }

  if (length > 0 && value.length != 2 + 2 * length) {
    return false;
  }

  return true;
}

String remove0x(String hex) {
  if (hex.startsWith('0x') || hex.startsWith('0X')) {
    return hex.substring(2);
  }
  return hex;
}
