import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ethereum_util/ethereum_util.dart';
import 'package:flutter/services.dart';
import 'package:my_idena/backoffice/bean/flip_get_request.dart';
import 'package:my_idena/backoffice/bean/flip_get_response.dart';
import 'package:my_idena/backoffice/bean/flip_longHashes_request.dart';
import 'package:my_idena/backoffice/bean/flip_shortHashes_request.dart';
import 'package:my_idena/backoffice/bean/flip_shortHashes_response.dart';
import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/utils/sharedPreferencesHelper.dart';
import 'package:ethereum_util/src/rlp.dart' as Rlp;
import 'package:shared_preferences/shared_preferences.dart';

class ValidationSessionInfoFlips {
  ValidationSessionInfoFlips(
      {this.hash,
      this.ready,
      this.extra,
      this.available,
      this.listWords,
      this.listImages1,
      this.listImages2,
      this.listOk});

  String hash;
  bool ready;
  bool extra;
  bool available;
  List<int> listWords;
  List<Uint8List> listImages1;
  List<Uint8List> listImages2;
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
  /*if (validationSessionInfoInput != null) {
    return validationSessionInfoInput;
  }*/

  ValidationSessionInfo validationSessionInfo = new ValidationSessionInfo();
  validationSessionInfo.typeSession = typeSession;
  String method;
  simulationMode = await getSimulationMode();

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
  List<ValidationSessionInfoFlips> listSessionValidationFlip;

  try {
    HttpClient httpClient = new HttpClient();
    IdenaSharedPreferences idenaSharedPreferences =
        await SharedPreferencesHelper.getIdenaSharedPreferences();

    // Short or long Hashes
    if (simulationMode) {
      Map<String, dynamic> mapExemple = {
        "jsonrpc": "2.0",
        "id": 19,
        "result": [
          {
            "hash":
                "bafkreial55rw3dirdlrivcjsnnxaswfrloxuk4pbfssxbwhheqbo44crra",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreiasdvce4g2wlmkia5bmj27snlsa44imfeu2e5whg3r6rea57avmwa",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreiaxmbxoy3rystvl4hcfd46uvbxxqy4op7ivvixhqtf5fvk4vjijpq",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreidipdlvqzvguqpimwi5g72bu4kknrxczitsu2mrrod3ctazfynqem",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreiel3bwd35dq64zflh2oxxzh256kl57n2d4n5ezkl3eso7quollm5m",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreiewtcyikpwfrbrbnbmseehqpy3rxozo7fgyihjmck6ltjcxx6yn4q",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreihs62lgfparrtutsrzup55vpgxx7o7nocakwmcxhojf3fzuen5vqy",
            "ready": true,
            "extra": true,
            "available": true
          },
        ]
      };

      /*Map<String, dynamic> mapExemple = {
        "jsonrpc": "2.0",
        "id": 19,
        "result": [
          {
            "hash":
                "1",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "2",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "3",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "4",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "5",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "6",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "7",
            "ready": true,
            "extra": true,
            "available": true
          },
        ]
      };*/

      flipShortHashesResponse = FlipShortHashesResponse.fromJson(mapExemple);
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
      flipShortHashesRequest = FlipShortHashesRequest.fromJson(map);
      request.add(utf8.encode(json.encode(flipShortHashesRequest.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();

        flipShortHashesResponse = flipShortHashesResponseFromJson(reply);
      }

      // TODO : distinguer Short/long
      for (int i = 0; i < flipShortHashesResponse.result.length; i++) {
        ValidationSessionInfoFlips validationSessionInfoFlips =
            new ValidationSessionInfoFlips();
        validationSessionInfoFlips.hash =
            flipShortHashesResponse.result[i].hash;
        validationSessionInfoFlips.ready =
            flipShortHashesResponse.result[i].ready;
        validationSessionInfoFlips.extra =
            flipShortHashesResponse.result[i].extra;
        validationSessionInfoFlips.available =
            flipShortHashesResponse.result[i].available;
        listSessionValidationFlip.add(validationSessionInfoFlips);
      }

      validationSessionInfo.listSessionValidationFlip =
          listSessionValidationFlip;
    }
  } catch (e) {
    print("error: " + e.toString());
  } finally {}

  return validationSessionInfo;
}

Future<ValidationSessionInfoFlips> getValidationFlips(
    String typeSession, String hash) async {
  
  //
  HttpClient httpClient = new HttpClient();
  IdenaSharedPreferences idenaSharedPreferences =
      await SharedPreferencesHelper.getIdenaSharedPreferences();
  FlipGetResponse flipGetResponse;
  ValidationSessionInfoFlips validationSessionInfoFlips = new ValidationSessionInfoFlips();
  try {
    // get Flip
    if (simulationMode) {
      await rootBundle
          .loadString('lib/beans/test/' + hash + "_images.json", cache: true)
          .catchError((error) {
        print("error loadAssets: " + error);
      }).then((data) {
        flipGetResponse = flipGetResponseFromJson(data);
      });
    } else {
      HttpClientRequest requestFlip = await httpClient
          .postUrl(Uri.parse(idenaSharedPreferences.apiUrl))
          .catchError((error) {
        print(error);
      });
      requestFlip.headers.set('content-type', 'application/json');

      Map<String, dynamic> mapFlip = {
        'method': FlipGetRequest.METHOD_NAME,
        'params': [hash],
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

    Decoded images2;
    List orders = new List(2);
    if (flipGetResponse.result.privateHex != null &&
        flipGetResponse.result.privateHex != '0x') {
      // ;[images] = decode(publicHex || hex)
      if (flipGetResponse.result.publicHex != null) {
        images2 = Rlp.decode(
            Uint8List.fromList(toBuffer(flipGetResponse.result.publicHex)),
            true);
      } else {
        if (flipGetResponse.result.hex != null) {
          images2 = Rlp.decode(
              Uint8List.fromList(toBuffer(flipGetResponse.result.hex)), true);
        }
      }

      // let privateImages
      // ;[privateImages, orders] = decode(privateHex)
      Decoded privateImages;
      privateImages = Rlp.decode(
          Uint8List.fromList(toBuffer(flipGetResponse.result.privateHex)),
          true);

      // images = images.concat(privateImages)
      imageUint8_1 = images2.data[0][0];
      imageUint8_2 = images2.data[0][1];
      imageUint8_3 = privateImages.data[0][0];
      imageUint8_4 = privateImages.data[0][1];
      orders = privateImages.data[1];
    } else {
      // TODO: implement this case
      // ;[images, orders] = decode(hex)
      var images3;
      images3 = Rlp.decode(
          Uint8List.fromList(toBuffer(flipGetResponse.result.hex)), true);
    }

    // hash,
    // decoded: true,
    // images: images.map(buffer =>
    //  URL.createObjectURL(new Blob([buffer], {type: 'image/png'}))
    //),
    // orders: orders.map(order => order.map(([idx = 0]) => idx)),
    // hex: '',

    String order1 =
        orders[0][0].toString().replaceAll('[', '').replaceAll(']', '');
    String order2 =
        orders[0][1].toString().replaceAll('[', '').replaceAll(']', '');
    String order3 =
        orders[0][2].toString().replaceAll('[', '').replaceAll(']', '');
    String order4 =
        orders[0][3].toString().replaceAll('[', '').replaceAll(']', '');
    print("hash : " + hash +
        " - flip 1: " +
        order1 +
        ', ' +
        order2 +
        ', ' +
        order3 +
        ', ' +
        order4);
    validationSessionInfoFlips.listImages1 = new List<Uint8List>(4);
    validationSessionInfoFlips.listImages1[int.tryParse(order1) ?? 0] =
        imageUint8_1;
    validationSessionInfoFlips.listImages1[int.tryParse(order2) ?? 0] =
        imageUint8_2;
    validationSessionInfoFlips.listImages1[int.tryParse(order3) ?? 0] =
        imageUint8_3;
    validationSessionInfoFlips.listImages1[int.tryParse(order4) ?? 0] =
        imageUint8_4;

    // TODO .. dirty
    order1 = orders[1][0].toString().replaceAll('[', '').replaceAll(']', '');
    order2 = orders[1][1].toString().replaceAll('[', '').replaceAll(']', '');
    order3 = orders[1][2].toString().replaceAll('[', '').replaceAll(']', '');
    order4 = orders[1][3].toString().replaceAll('[', '').replaceAll(']', '');
    print("hash : " + hash +
        " - flip 2: " +
        order1 +
        ', ' +
        order2 +
        ', ' +
        order3 +
        ', ' +
        order4);
    validationSessionInfoFlips.listImages2 = new List<Uint8List>(4);
    validationSessionInfoFlips.listImages2[int.tryParse(order1) ?? 0] =
        imageUint8_1;
    validationSessionInfoFlips.listImages2[int.tryParse(order2) ?? 0] =
        imageUint8_2;
    validationSessionInfoFlips.listImages2[int.tryParse(order3) ?? 0] =
        imageUint8_3;
    validationSessionInfoFlips.listImages2[int.tryParse(order4) ?? 0] =
        imageUint8_4;

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
  } catch (e) {
    print("error: " + e.toString());
  } finally {}

  return validationSessionInfoFlips;
}

Future<String> loadAssets(String fileName) async {
  return await rootBundle
      .loadString('lib/beans/test/' + fileName + '.json', cache: true)
      .catchError((error) {
    print("error loadAssets: " + error);
  }).then((data) {
    return data.toString();
  });
}
