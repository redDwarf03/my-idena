import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:my_idena/utils/crypto/aes_gcm.dart';
import 'package:my_idena/utils/crypto/pbkdf2.dart';


class Cryptor {
  static const SALT_LENGTH = 64;
  static const IV_LENGTH = 16;
  static const TAG_LENGTH = 16;
  static const KEY_LENGTH = 32;
  static const KEY_ITERATIONS_COUNT = 100000;

  /// Hashes passed [value] with sha512 algorithm
  static String hash(String value) {
    return base64.encode(sha512.convert(utf8.encode(value)).bytes);
  }

  /// Encrypts passed [cleartext] with key generated based on [password] argument
  static String encrypt(String cleartext, String password) {
    Uint8List salt = _generateSalt();
    Uint8List iv = _generateIV();
    Uint8List key = _pbkdf2(password, salt);

    String ciphertext = AesGcm(key).encrypt(cleartext, iv);
    return base64.encode(_combineInputs(salt, iv, _generateTag(), ciphertext));
  }

  /// Encrypts passed [cryptedtext] with key generated based on [password] argument
  static String decrypt(String cryptedtext, String password) {
    Uint8List bytes = base64.decode(cryptedtext);
    Uint8List salt = bytes.sublist(0, SALT_LENGTH);
    Uint8List iv = bytes.sublist(SALT_LENGTH, SALT_LENGTH + IV_LENGTH);
    String ciphertext = base64.encode(
        bytes.sublist(SALT_LENGTH + IV_LENGTH + TAG_LENGTH, bytes.length));
    Uint8List key = _pbkdf2(password, salt);
    return AesGcm(key).decrypt(ciphertext, iv);
  }

  static Uint8List _combineInputs(
      Uint8List salt, Uint8List iv, Uint8List tag, String ciphertext) {
    return Uint8List.fromList(salt + iv + tag + base64.decode(ciphertext));
  }

  /// Password Based Key Deriviation function
  static Uint8List _pbkdf2(String password, Uint8List salt) {
    PBKDF2 generator = new PBKDF2(sha512);
    return generator.generateKey(
        password, salt, KEY_ITERATIONS_COUNT, KEY_LENGTH);
  }

  /// Generates salt of given length and returns Uint8List result
  static Uint8List _generateTag() => _randomBytes(TAG_LENGTH);

  /// Generates salt of given length and returns Uint8List result
  static Uint8List _generateSalt() => _randomBytes(SALT_LENGTH);

  /// Generates initialization vector of given length and returns Uint8List result
  static Uint8List _generateIV() => _randomBytes(IV_LENGTH);

  /// Generates a random byte sequence of given [length]
  static Uint8List _randomBytes(int length) {
    Uint8List buffer = new Uint8List(length);
    Random range = new Random.secure();
    for (int i = 0; i < length; i++) {
      buffer[i] = range.nextInt(256);
    }
    return buffer;
  }
}