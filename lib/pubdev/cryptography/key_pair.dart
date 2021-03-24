// @dart=2.9
// Copyright 2019-2020 Gohilla Ltd.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:meta/meta.dart';
import 'package:my_idena/pubdev/cryptography/private_key.dart';
import 'package:my_idena/pubdev/cryptography/public_key.dart';

/// A pair of keys ([PrivateKey] and a [PublicKey]).
///
/// ## Example
/// An example of using [x25519]:
/// ```
/// final keyPair = x25519.newKeyPair();
/// print('private key: ${keyPair.privateKey.extractSync()}');
/// print('public key: ${keyPair.publicKey.bytes}');
/// ```
class KeyPair {
  /// Private key.
  final PrivateKey privateKey;

  /// Public key.
  final PublicKey publicKey;

  @override
  KeyPair({@required this.privateKey, @required this.publicKey})
      : assert(privateKey != null),
        assert(publicKey != null);

  @override
  int get hashCode => publicKey.hashCode;

  @override
  bool operator ==(other) =>
      other is KeyPair &&
      publicKey == other.publicKey &&
      privateKey == other.privateKey;

  @override
  String toString() => 'KeyPair(..., publicKey: $publicKey)';
}
