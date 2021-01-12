import 'dart:convert' show utf8;
import 'dart:typed_data';

import 'package:convert/convert.dart' show hex;
import 'package:cryptography/cryptography.dart';
import 'package:my_idena/util/crypto/bigint.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:quiver/check.dart';

import 'package:pointycastle/export.dart' as pc;

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
        v = Uint8List.fromList(
            hex.decode(padToEven(stripHexPrefix(v))));
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

  var a = "${value}";

  if (a.length % 2 == 1) {
    a = "0${a}";
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
    hexString += n.length < 2 ? "0${n}" : n;
  }

  return "0x${hexString}";
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

String remove0x(String hex)
{
  if (hex.startsWith('0x') || hex.startsWith('0X')) {
    return hex.substring(2);
  }
  return hex;
}

Future<String> decrypt(String key, String data) async
{
  data = "04ef28fc7a8ec35b090b25452ceb4d2aeed22886b075e146a7240e7e2e258de157df2d8fd3e69c50f411f3782d73daf9eb2c8fbf17d835d77bf0e7a3e8d92d1476da677c3a4d1d9ba913fc809476ba289b7df3fa88e8cb2df4357bae339f2a4601e8a2be3e9a8d614456a0a157025801430c85f8";
  key = "afd4fee14dd189f3191ac044a72e9da661656ff89bb7d52e33b56681aa465547";

  int ephemKeyLength = 65;
  int ivLength = 16;
  int macLength = 32;
  List<int> privateKey = utf8.encode(remove0x(key));
  List<int> encrypted = utf8.encode(remove0x(data));
  int metaLength = ephemKeyLength + ivLength + macLength;

  if(encrypted.length > metaLength)
  {
    print('Invalid Ciphertext. Data is too small');
    return null;
  }
   if(encrypted[0] >= 2 && encrypted[0] <= 4)
  {
    print('Not valid ciphertext.');
    return null;
  } 

  // deserialise
  List<int> ephemPublicKey = encrypted.sublist(0, ephemKeyLength);
  int cipherTextLength = encrypted.length - metaLength;
  List<int> iv = encrypted.sublist(ephemKeyLength, ephemKeyLength + ivLength);
  List<int> cipherAndIv = encrypted.sublist(
    ephemKeyLength,
    ephemKeyLength + ivLength + cipherTextLength
  );
  List<int> ciphertext = cipherAndIv.sublist(ivLength);
  List<int> msgMac = encrypted.sublist(ephemKeyLength + ivLength + cipherTextLength);
 
 /* final _privateKey = ECPrivateKey(
      BigInt.parse(remove0x(key), radix: 16),
      ECDomainParameters('secp256k1'),
    );

  var privParams = PrivateKeyParameter(_privateKey);

  var px = null;
  List<int> hash = kdf(px, 32);
  List<int> encryptionKey = hash.sublist(0, 16);


// iv: 255a8b29e96ab4c347898ecf29953cac
// encryptedKey: a05f64ad7a5e67568f9bc82742c9b526
  var iv = utf8.encode("cac3ea1e5df23fec082b64c874973bf2").sublist(0,16);
  var encryptionKey = utf8.encode("3a0bd6d9f2a28c2f4af4ec78d608b1b7");
  String ciphertext = "91254d";

  // decrypt message
  SecretKey secretKey = new SecretKey(encryptionKey);
  Nonce nonce = new Nonce(iv);
  //print(aes128CtrDecrypt(iv,  encryptionKey,  ciphertext));
  encrypt.IV iv_ = encrypt.IV.fromUtf8(utf8.decode(iv));
  print(aesDecrypt(ciphertext, utf8.decode(encryptionKey), iv_));
*/
  //Uint8List decrypted = await aesCtr.decrypt(utf8.encode(ciphertext), secretKey: secretKey, nonce: nonce);
  //print("decrypt : " + utf8.decode(decrypted));
  //return utf8.decode(decrypted);
/*
  const ecdh = crypto.createECDH('secp256k1');
  ecdh.setPrivateKey(privateKey);
  let px = ecdh.computeSecret(ephemPublicKey);

  // create encryption key and mac key
  let hash = kdf(px, 32);
  let encryptionKey = hash.slice(0, 16);
  //let macKey = sha256(hash.slice(16));

  // check HMAC
  //let currentHMAC = hmacSha256(macKey, cipherAndIv);
  //assert(equalConstTime(currentHMAC, msgMac), 'Incorrect MAC');

  // decrypt message
  return aes128CtrDecrypt(iv, encryptionKey, ciphertext);

  
*/

}
/*
aesDecrypt(String ciphertext, String hash, encrypt.IV iv) async {
		encrypt.Key key = encrypt.Key.fromUtf8(hash);
		
		encrypt.Encrypter aes = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ctr));
		
		encrypt.Encrypted encrypted = encrypt.Encrypted.fromUtf8(ciphertext);
		
		String decrypted = aes.decrypt(encrypted, iv: iv);
		
		return decrypted;
	}

String aes128CtrDecrypt(Uint8List iv, Uint8List key, String cipher) {

 
 final encryptedText = encrypt.Encrypted.fromBase16(cipher);
  final ctr = pc.CTRStreamCipher(pc.AESFastEngine())
    ..init(false, pc.ParametersWithIV(pc.KeyParameter(key), iv));
  Uint8List decrypted = ctr.process(encryptedText.bytes);

  print(String.fromCharCodes(decrypted));

  return String.fromCharCodes(decrypted);
}

List<int> kdf(secret, outputLength) {
 /* int ctr = 1;
  int written = 0;
  List<int> result;

  while (written < outputLength) {


    let ctrs = Buffer.from([ctr >> 24, ctr >> 16, ctr >> 8, ctr]);
    let hashResult = sha256(Buffer.concat([ctrs, secret]));
    result.addAll(hashResult);
    written += 32;
    ctr += 1;
  }*/
  return null;
}*/