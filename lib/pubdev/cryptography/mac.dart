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


import 'package:my_idena/pubdev/cryptography/utils.dart';

/// A Message Authentication Code (MAC).
///
/// A MAC can be calculated with some [MacAlgorithm].
class Mac {
  /// Bytes of the MAC.
  final List<int> bytes;

  const Mac(this.bytes) : assert(bytes != null);

  @override
  int get hashCode => constantTimeBytesEquality.hash(bytes);

  @override
  bool operator ==(other) =>
      other is Mac && constantTimeBytesEquality.equals(other.bytes, bytes);

  @override
  String toString() => 'Mac(0x${hexFromBytes(bytes)})';
}

/// An exception thrown by [Cipher] when decrypted bytes have invalid [Mac].
class MacValidationException implements Exception {
  @override
  String toString() => 'Message authentication code (MAC) is invalid';
}
