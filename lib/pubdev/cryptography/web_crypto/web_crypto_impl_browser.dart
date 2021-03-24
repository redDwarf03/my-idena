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

library web_crypto;

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:js_util' as js;
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:my_idena/pubdev/cryptography/hash.dart';
import 'package:my_idena/pubdev/cryptography/jwk.dart';
import 'package:my_idena/pubdev/cryptography/key_pair.dart';
import 'package:my_idena/pubdev/cryptography/mac.dart';
import 'package:my_idena/pubdev/cryptography/nonce.dart';
import 'package:my_idena/pubdev/cryptography/private_key.dart';
import 'package:my_idena/pubdev/cryptography/public_key.dart';
import 'package:my_idena/pubdev/cryptography/secret_key.dart';
import 'package:my_idena/pubdev/cryptography/signature.dart';

import 'javascript_bindings.dart' as web_crypto;

part 'impl/aes.dart';
part 'impl/ec_dh.dart';
part 'impl/ec_dsa.dart';
part 'impl/other.dart';
part 'impl/rsa.dart';

final bool isWebCryptoSupported = web_crypto.subtle != null;

ByteBuffer _jsArrayBufferFrom(List<int> data) {
  // Avoid copying if possible
  if (data is Uint8List &&
      data.offsetInBytes == 0 &&
      data.lengthInBytes == data.buffer.lengthInBytes) {
    return data.buffer;
  }
  // Copy
  return Uint8List.fromList(data).buffer;
}
