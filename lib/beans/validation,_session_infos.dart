import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:ethereum_util/ethereum_util.dart';
import 'package:flutter/services.dart';
import 'package:my_idena/beans/rpc/flip_get_request.dart';
import 'package:my_idena/beans/rpc/flip_get_response.dart';
import 'package:my_idena/beans/rpc/flip_longHashes_request.dart';
import 'package:my_idena/beans/rpc/flip_longHashes_response.dart';
import 'package:my_idena/beans/rpc/flip_shortHashes_request.dart';
import 'package:my_idena/beans/rpc/flip_shortHashes_response.dart';
import 'package:my_idena/beans/rpc/flip_words_request.dart';
import 'package:my_idena/beans/rpc/flip_words_response.dart';
import 'package:my_idena/beans/test/flip_examples.dart';
import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/utils/sharedPreferencesHelper.dart';
import 'package:ethereum_util/ethereum_util.dart';
import 'package:ethereum_util/src/rlp.dart' as Rlp;
import 'package:shared_preferences/shared_preferences.dart';

class ValidationSessionInfoFlips {
  ValidationSessionInfoFlips(
      {this.hash,
      this.ready,
      this.extra,
      this.available,
      this.listWords,
      this.listImagesLeft,
      this.listImagesRight,
      this.listOk});

  String hash;
  bool ready;
  bool extra;
  bool available;
  List<int> listWords;
  List<Uint8List> listImagesLeft;
  List<Uint8List> listImagesRight;
  int listOk;
}

class ValidationSessionInfo {
  ValidationSessionInfo({this.typeSession, this.listSessionValidationFlip});

  String typeSession;
  List<ValidationSessionInfoFlips> listSessionValidationFlip;
}

bool simulationMode;

Future<bool> getSimulationMode() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  simulationMode = sharedPreferences.getBool("simulation_mode");
  if (simulationMode == null) {
    simulationMode = true;
  }
  return simulationMode;
}

Future<ValidationSessionInfo> getValidationSessionInfo(String typeSession,
    ValidationSessionInfo validationSessionInfoInput) async {
  if (validationSessionInfoInput != null) {
    return validationSessionInfoInput;
  }

  ValidationSessionInfo validationSessionInfo = new ValidationSessionInfo();
  validationSessionInfo.typeSession = typeSession;
  String method;
  simulationMode = await getSimulationMode();

  Map<String, dynamic> mapExemple;
  switch (typeSession) {
    case EpochPeriod.ShortSession:
      {
        method = FlipShortHashesRequest.METHOD_NAME;
      }
      break;
    case EpochPeriod.LongSession:
      {
        method = FlipLongHashesRequest.METHOD_NAME;
      }
      break;
    default:
      return validationSessionInfo;
  }

  FlipShortHashesRequest flipShortHashesRequest;
  FlipShortHashesResponse flipShortHashesResponse;
  FlipLongHashesRequest flipLongHashesRequest;
  FlipLongHashesResponse flipLongHashesResponse;

  try {
    HttpClient httpClient = new HttpClient();
    IdenaSharedPreferences idenaSharedPreferences =
        await SharedPreferencesHelper.getIdenaSharedPreferences();

    if (simulationMode) {
      if (typeSession == EpochPeriod.ShortSession) {
        flipShortHashesResponse = FlipShortHashesResponse.fromJson(
            FlipExamples().getMapExample(typeSession));
      }
      if (typeSession == EpochPeriod.LongSession) {
        flipLongHashesResponse = FlipLongHashesResponse.fromJson(
            FlipExamples().getMapExample(typeSession));
      }
    } else {
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
      request.headers.set('content-type', 'application/json');

      Map<String, dynamic> map = {
        'method': method,
        "params": [],
        'id': 101,
        'key': idenaSharedPreferences.keyApp
      };

      if (typeSession == EpochPeriod.ShortSession) {
        flipShortHashesRequest = FlipShortHashesRequest.fromJson(map);
        request.add(utf8.encode(json.encode(flipShortHashesRequest.toJson())));
        HttpClientResponse response = await request.close();
        if (response.statusCode == 200) {
          String reply = await response.transform(utf8.decoder).join();

          flipShortHashesResponse = flipShortHashesResponseFromJson(reply);
        }
      }
      if (typeSession == EpochPeriod.LongSession) {
        flipLongHashesRequest = FlipLongHashesRequest.fromJson(map);
        request.add(utf8.encode(json.encode(flipLongHashesRequest.toJson())));
        HttpClientResponse response = await request.close();
        if (response.statusCode == 200) {
          String reply = await response.transform(utf8.decoder).join();

          flipLongHashesResponse = flipLongHashesResponseFromJson(reply);
        }
      }
    }

    FlipGetResponse flipGetResponse;
    FlipWordsResponse flipWordsResponse;
    List<ValidationSessionInfoFlips> listSessionValidationFlip;
    if (typeSession == EpochPeriod.ShortSession) {
      listSessionValidationFlip =
          new List(flipShortHashesResponse.result.length);
    }
    if (typeSession == EpochPeriod.LongSession) {
      listSessionValidationFlip =
          new List(flipLongHashesResponse.result.length);
    }

    // TODO : distinguer Short/long
    for (int i = 0; i < listSessionValidationFlip.length; i++) {
      ValidationSessionInfoFlips validationSessionInfoFlips =
          new ValidationSessionInfoFlips();
      if (typeSession == EpochPeriod.ShortSession) {
        validationSessionInfoFlips.hash =
            flipShortHashesResponse.result[i].hash;
        validationSessionInfoFlips.ready =
            flipShortHashesResponse.result[i].ready;
        validationSessionInfoFlips.extra =
            flipShortHashesResponse.result[i].extra;
        validationSessionInfoFlips.available =
            flipShortHashesResponse.result[i].available;
      }
      if (typeSession == EpochPeriod.LongSession) {
        validationSessionInfoFlips.hash = flipLongHashesResponse.result[i].hash;
        validationSessionInfoFlips.ready =
            flipLongHashesResponse.result[i].ready;
        validationSessionInfoFlips.extra =
            flipLongHashesResponse.result[i].extra;
        validationSessionInfoFlips.available =
            flipLongHashesResponse.result[i].available;
      }

      // get Flip
      if (simulationMode) {
        String data =
            await loadAssets(validationSessionInfoFlips.hash + "_images");
        flipGetResponse = flipGetResponseFromJson(data);
      } else {
        HttpClientRequest requestFlip =
            await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
        requestFlip.headers.set('content-type', 'application/json');

        Map<String, dynamic> mapFlip = {
          'method': FlipGetRequest.METHOD_NAME,
          'params': [validationSessionInfoFlips.hash],
          'id': 101,
          'key': idenaSharedPreferences.keyApp
        };

        FlipGetRequest flipGetRequest = FlipGetRequest.fromJson(mapFlip);
        requestFlip.add(utf8.encode(json.encode(flipGetRequest.toJson())));
        HttpClientResponse responseFlip = await requestFlip.close();
        if (responseFlip.statusCode == 200) {
          String replyFlip = await responseFlip.transform(utf8.decoder).join();
          flipGetResponse = flipGetResponseFromJson(replyFlip);
        }
      }

      Uint8List imageUint8_1;
      Uint8List imageUint8_2;
      Uint8List imageUint8_3;
      Uint8List imageUint8_4;

      Decoded images;
      Decoded privateImages;
      List listImages = new List(4);
      List orders = new List(2);
      if (flipGetResponse.result.privateHex != null &&
          flipGetResponse.result.privateHex != '0x') {
        // ;[images] = decode(publicHex || hex)
        if (flipGetResponse.result.publicHex != null) {
          images = Rlp.decode(
              Uint8List.fromList(toBuffer(flipGetResponse.result.publicHex)),
              true);
        } else {
          if (flipGetResponse.result.hex != null) {
            images = Rlp.decode(
                Uint8List.fromList(toBuffer(flipGetResponse.result.hex)), true);
          }
        }

        // let privateImages
        // ;[privateImages, orders] = decode(privateHex)
        privateImages = Rlp.decode(
            Uint8List.fromList(toBuffer(flipGetResponse.result.privateHex)),
            true);

        // images = images.concat(privateImages)
        imageUint8_1 = images.data[0][0];
        imageUint8_2 = images.data[0][1];
        imageUint8_3 = privateImages.data[0][0];
        imageUint8_4 = privateImages.data[0][1];
        listImages[0] = imageUint8_1;
        listImages[1] = imageUint8_2;
        listImages[2] = imageUint8_3;
        listImages[3] = imageUint8_4;
        orders = privateImages.data[1];
      } else {
        // TODO: implement this case
        // ;[images, orders] = decode(hex)
        var images3;
        images3 = Rlp.decode(
            Uint8List.fromList(toBuffer(flipGetResponse.result.hex)), true);
      }

      String order1 =
          orders[0][0].toString().replaceAll('[', '').replaceAll(']', '');
      String order2 =
          orders[0][1].toString().replaceAll('[', '').replaceAll(']', '');
      String order3 =
          orders[0][2].toString().replaceAll('[', '').replaceAll(']', '');
      String order4 =
          orders[0][3].toString().replaceAll('[', '').replaceAll(']', '');
      print(i.toString() +
          " - flip 1: " +
          order1 +
          ', ' +
          order2 +
          ', ' +
          order3 +
          ', ' +
          order4);
      validationSessionInfoFlips.listImagesLeft = new List<Uint8List>(4);
      validationSessionInfoFlips.listImagesLeft[0] =
          listImages[int.tryParse(order1) ?? 0];
      validationSessionInfoFlips.listImagesLeft[1] =
          listImages[int.tryParse(order2) ?? 0];
      validationSessionInfoFlips.listImagesLeft[2] =
          listImages[int.tryParse(order3) ?? 0];
      validationSessionInfoFlips.listImagesLeft[3] =
          listImages[int.tryParse(order4) ?? 0];

      // TODO .. dirty
      order1 = orders[1][0].toString().replaceAll('[', '').replaceAll(']', '');
      order2 = orders[1][1].toString().replaceAll('[', '').replaceAll(']', '');
      order3 = orders[1][2].toString().replaceAll('[', '').replaceAll(']', '');
      order4 = orders[1][3].toString().replaceAll('[', '').replaceAll(']', '');
      print(i.toString() +
          " - flip 2: " +
          order1 +
          ', ' +
          order2 +
          ', ' +
          order3 +
          ', ' +
          order4);
      validationSessionInfoFlips.listImagesRight = new List<Uint8List>(4);
      validationSessionInfoFlips.listImagesRight[0] =
          listImages[int.tryParse(order1) ?? 0];
      validationSessionInfoFlips.listImagesRight[1] =
          listImages[int.tryParse(order2) ?? 0];
      validationSessionInfoFlips.listImagesRight[2] =
          listImages[int.tryParse(order3) ?? 0];
      validationSessionInfoFlips.listImagesRight[3] =
          listImages[int.tryParse(order4) ?? 0];

      // get Words
      /*if (simulationMode) {
        String data =
            await loadAssets(flipShortHashesResponse.result[i].hash + "_words");
        flipWordsResponse = flipWordsResponseFromJson(data);
      } else {
        HttpClientRequest requestWords =
            await httpClient.postUrl(Uri.parse(idenaSharedPreferences.apiUrl));
        requestWords.headers.set('content-type', 'application/json');
        Map<String, dynamic> mapWords = {
          'method': FlipWordsRequest.METHOD_NAME,
          'params': [flipShortHashesResponse.result[i].hash],
          'id': 101,
          'key': idenaSharedPreferences.keyApp
        };
        FlipWordsRequest flipWordsRequest = FlipWordsRequest.fromJson(mapWords);
        requestWords.add(utf8.encode(json.encode(flipWordsRequest.toJson())));
        HttpClientResponse responseWords = await requestWords.close();
        if (responseWords.statusCode == 200) {
          String replyWords =
              await responseWords.transform(utf8.decoder).join();
          flipWordsResponse = flipWordsResponseFromJson(replyWords);
        }
      }
      List<int> listWords = new List(flipWordsResponse.result.words.length);
      for (int j = 0; j < flipWordsResponse.result.words.length; j++) {
        listWords[j] = flipWordsResponse.result.words[j];
      }
      validationSessionInfoFlips.listWords = listWords;
    */
      listSessionValidationFlip[i] = validationSessionInfoFlips;
    }

    validationSessionInfo.listSessionValidationFlip = listSessionValidationFlip;
  } catch (e) {
    print("error: " + e.toString());
  } finally {}

  return validationSessionInfo;
}

Future<String> loadAssets(String fileName) async {
  try {
    return await rootBundle.loadString('lib/beans/test/' + fileName + '.json');
  } catch (e) {
    print("error loadAssets: " + e.toString());
  } finally {}
}
