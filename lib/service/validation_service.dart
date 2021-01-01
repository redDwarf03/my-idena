import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:my_idena/network/model/dictWords.dart';
import 'package:my_idena/network/model/flip_examples.dart';
import 'package:my_idena/network/model/request/flip_get_request.dart';
import 'package:my_idena/network/model/request/flip_longHashes_request.dart';
import 'package:my_idena/network/model/request/flip_shortHashes_request.dart';
import 'package:my_idena/network/model/request/flip_submitLongAnswers_request.dart';
import 'package:my_idena/network/model/request/flip_submitShortAnswers_request.dart';
import 'package:my_idena/network/model/request/flip_words_request.dart';
import 'package:my_idena/network/model/response/flip_get_response.dart';
import 'package:my_idena/network/model/response/flip_longHashes_response.dart';
import 'package:my_idena/network/model/response/flip_shortHashes_response.dart';
import 'package:my_idena/network/model/response/flip_submitLongAnswers_response.dart';
import 'package:my_idena/network/model/response/flip_submitShortAnswers_response.dart';
import 'package:my_idena/network/model/response/flip_words_response.dart';
import 'package:my_idena/network/model/validation_session_infos.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/crypto/rlp.dart';
import 'package:my_idena/util/crypto/utils_crypto.dart';
import 'package:my_idena/util/enums/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/util/enums/relevance_type.dart' as RelevantType;
import 'package:my_idena/util/enums/answer_type.dart' as AnswerType;
import 'package:my_idena/util/sharedprefsutil.dart';

class ValidationService {
  var logger = Logger();
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };
  String body;
  http.Response responseHttp;
  Map<String, dynamic> mapParams;

  Future<ValidationSessionInfo> getValidationSessionFlipsList(
      String typeSession,
      ValidationSessionInfo validationSessionInfoInput,
      bool simulationMode) async {
    Completer<ValidationSessionInfo> _completer =
        new Completer<ValidationSessionInfo>();

    if (validationSessionInfoInput != null) {
      _completer.complete(validationSessionInfoInput);
      return _completer.future;
    }

    ValidationSessionInfo validationSessionInfo = new ValidationSessionInfo();
    validationSessionInfo.typeSession = typeSession;
    String method;

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
        Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
        String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

        mapParams = {'method': method, "params": [], 'id': 101, 'key': keyApp};

        if (typeSession == EpochPeriod.ShortSession) {
          flipShortHashesRequest = FlipShortHashesRequest.fromJson(mapParams);
          logger.i(
              new JsonEncoder.withIndent('  ').convert(flipShortHashesRequest));
          body = json.encode(flipShortHashesRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            flipShortHashesResponse =
                flipShortHashesResponseFromJson(responseHttp.body);
          }
        }
        if (typeSession == EpochPeriod.LongSession) {
          flipLongHashesRequest = FlipLongHashesRequest.fromJson(mapParams);
          logger.i(
              new JsonEncoder.withIndent('  ').convert(flipLongHashesRequest));
          body = json.encode(flipLongHashesRequest.toJson());
          responseHttp =
              await http.post(url, body: body, headers: requestHeaders);
          if (responseHttp.statusCode == 200) {
            flipLongHashesResponse =
                flipLongHashesResponseFromJson(responseHttp.body);
          }
        }
      }

      List<ValidationSessionInfoFlips> listSessionValidationFlip = new List();
      List<ValidationSessionInfoFlips> listSessionValidationFlipExtra =
          new List();
      int nbFlips = 0;
      if (typeSession == EpochPeriod.ShortSession) {
        nbFlips = flipShortHashesResponse.result.length;
      }
      if (typeSession == EpochPeriod.LongSession) {
        nbFlips = flipLongHashesResponse.result.length;
      }

      for (int i = 0; i < nbFlips; i++) {
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
          validationSessionInfoFlips.answerType = AnswerType.NONE;
          validationSessionInfoFlips.relevanceType = RelevantType.NO_INFO;
        }
        if (typeSession == EpochPeriod.LongSession) {
          validationSessionInfoFlips.hash =
              flipLongHashesResponse.result[i].hash;
          validationSessionInfoFlips.ready =
              flipLongHashesResponse.result[i].ready;
          validationSessionInfoFlips.extra =
              flipLongHashesResponse.result[i].extra;
          validationSessionInfoFlips.available =
              flipLongHashesResponse.result[i].available;
          validationSessionInfoFlips.answerType = AnswerType.NONE;
          validationSessionInfoFlips.relevanceType = RelevantType.NO_INFO;
        }

        if (validationSessionInfoFlips.extra) {
          listSessionValidationFlipExtra.add(validationSessionInfoFlips);
        } else {
          if (validationSessionInfoFlips.ready) {
            listSessionValidationFlip.add(validationSessionInfoFlips);
          }
        }
      }

      validationSessionInfo.listSessionValidationFlips =
          listSessionValidationFlip;
      validationSessionInfo.listSessionValidationFlipsExtra =
          listSessionValidationFlipExtra;
    } catch (e) {
      logger.e(e.toString());
    }
    _completer.complete(validationSessionInfo);

    return _completer.future;
  }

  Future<ValidationSessionInfoFlips> getValidationSessionFlipDetail(
      ValidationSessionInfoFlips validationSessionInfoFlips,
      bool simulationMode) async {
    Completer<ValidationSessionInfoFlips> _completer =
        new Completer<ValidationSessionInfoFlips>();

    try {
      // get Flip
      FlipGetResponse flipGetResponse;
      if (simulationMode) {
        String data =
            await loadAssets(validationSessionInfoFlips.hash + "_images");
        flipGetResponse = flipGetResponseFromJson(data);
      } else {
        Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
        String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

        mapParams = {
          'method': FlipGetRequest.METHOD_NAME,
          'params': [validationSessionInfoFlips.hash],
          'id': 101,
          'key': keyApp
        };

        FlipGetRequest flipGetRequest = FlipGetRequest.fromJson(mapParams);
        body = json.encode(flipGetRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          flipGetResponse = flipGetResponseFromJson(responseHttp.body);
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
          images = decodeRlp(
              Uint8List.fromList(toBuffer(flipGetResponse.result.publicHex)),
              true);
        } else {
          if (flipGetResponse.result.hex != null) {
            images = decodeRlp(
                Uint8List.fromList(toBuffer(flipGetResponse.result.hex)), true);
          }
        }

        // let privateImages
        // ;[privateImages, orders] = decode(privateHex)
        privateImages = decodeRlp(
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
        var images3 = decodeRlp(
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
      validationSessionInfoFlips.listImagesRight = new List<Uint8List>(4);
      validationSessionInfoFlips.listImagesRight[0] =
          listImages[int.tryParse(order1) ?? 0];
      validationSessionInfoFlips.listImagesRight[1] =
          listImages[int.tryParse(order2) ?? 0];
      validationSessionInfoFlips.listImagesRight[2] =
          listImages[int.tryParse(order3) ?? 0];
      validationSessionInfoFlips.listImagesRight[3] =
          listImages[int.tryParse(order4) ?? 0];
    } catch (e) {
      logger.e(e.toString());
    }

    print("flip loaded : " + validationSessionInfoFlips.hash);

    _completer.complete(validationSessionInfoFlips);
    return _completer.future;
  }

  Future<List<Word>> getWordsFromHash(
      String hash, bool simulationMode, List<Word> wordsMap) async {
    FlipWordsResponse flipWordsResponse;
    Completer<List<Word>> _completer = new Completer<List<Word>>();

    int nbWords = 0;
    if (simulationMode) {
      try {
        String data = await loadAssets(hash + "_words");
        flipWordsResponse = flipWordsResponseFromJson(data);
      } catch (e) {
        Map<String, dynamic> mapWords = {
          "jsonrpc": "2.0",
          "id": 51,
          "result": {
            "words": [0, 0]
          }
        };
        flipWordsResponse = FlipWordsResponse.fromJson(mapWords);
      }
      nbWords = flipWordsResponse.result.words.length;
    } else {
      try {
        Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
        String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

        mapParams = {
          'method': FlipWordsRequest.METHOD_NAME,
          'params': [hash],
          'id': 101,
          'key': keyApp
        };

        FlipWordsRequest flipWordsRequest =
            FlipWordsRequest.fromJson(mapParams);
        body = json.encode(flipWordsRequest.toJson());
        responseHttp =
            await http.post(url, body: body, headers: requestHeaders);
        if (responseHttp.statusCode == 200) {
          flipWordsResponse = flipWordsResponseFromJson(responseHttp.body);
          nbWords = flipWordsResponse.result.words.length;
        }
      } catch (e) {}
    }
    List<Word> listWords = new List(nbWords);
    for (int j = 0; j < nbWords; j++) {
      Word word;
      if (flipWordsResponse.result.words[j] == 0) {
        word = new Word(name: "", desc: "");
      } else {
        word = new Word(
            name: wordsMap[flipWordsResponse.result.words[j]].name,
            desc: wordsMap[flipWordsResponse.result.words[j]].desc);
      }
      listWords[j] = word;
    }

    _completer.complete(listWords);
    return _completer.future;
  }

  Future<String> loadAssets(String fileName) async {
    try {
      return await rootBundle.loadString('test/examples/' + fileName + '.json', cache: false);
    } catch (e) {
      return null;
    }
  }

  Future<FlipSubmitShortAnswersResponse> submitShortAnswers(
      ValidationSessionInfo validationSessionInfo) async {
    Completer<FlipSubmitShortAnswersResponse> _completer =
        new Completer<FlipSubmitShortAnswersResponse>();

    if (validationSessionInfo == null) {
      _completer.complete(null);
      return _completer.future;
    }

    FlipSubmitShortAnswersRequest flipSubmitShortAnswersRequest =
        new FlipSubmitShortAnswersRequest();
    FlipSubmitShortAnswersResponse flipSubmitShortAnswersResponse;

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      ParamShortAnswer answers = new ParamShortAnswer();
      List<ShortAnswer> listAnswers = new List();
      for (int i = 0;
          i < validationSessionInfo.listSessionValidationFlips.length;
          i++) {
        ShortAnswer answer = new ShortAnswer(
            answer:
                validationSessionInfo.listSessionValidationFlips[i].answerType,
            hash: validationSessionInfo.listSessionValidationFlips[i].hash);
        listAnswers.add(answer);
      }

      answers.epoch = 0;
      answers.nonce = 0;
      answers.answers = listAnswers;

      List<ParamShortAnswer> params = new List();
      params.add(answers);
      flipSubmitShortAnswersRequest.method =
          FlipSubmitShortAnswersRequest.METHOD_NAME;
      flipSubmitShortAnswersRequest.params = params;
      flipSubmitShortAnswersRequest.id = 101;
      flipSubmitShortAnswersRequest.key = keyApp;

      body = json.encode(flipSubmitShortAnswersRequest.toJson());

      logger.i(new JsonEncoder.withIndent('  ')
          .convert(flipSubmitShortAnswersRequest));
      responseHttp = await http.post(url, body: body, headers: requestHeaders);
      if (responseHttp.statusCode == 200) {
        flipSubmitShortAnswersResponse =
            flipSubmitShortAnswersResponseFromJson(responseHttp.body);
      }
    } catch (e) {
      logger.e(e.toString());
    }
    _completer.complete(flipSubmitShortAnswersResponse);
    return _completer.future;
  }

  Future<FlipSubmitLongAnswersResponse> submitLongAnswers(
      ValidationSessionInfo validationSessionInfo) async {
    Completer<FlipSubmitLongAnswersResponse> _completer =
        new Completer<FlipSubmitLongAnswersResponse>();

    if (validationSessionInfo == null) {
      _completer.complete(null);
      return _completer.future;
    }
    FlipSubmitLongAnswersRequest flipSubmitLongAnswersRequest =
        new FlipSubmitLongAnswersRequest();
    FlipSubmitLongAnswersResponse flipSubmitLongAnswersResponse;
    bool wrongWordsBool;

    try {
      Uri url = await sl.get<SharedPrefsUtil>().getApiUrl();
      String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

      ParamLongAnswer answers = new ParamLongAnswer();
      List<LongAnswer> listAnswers = new List();
      for (int i = 0;
          i < validationSessionInfo.listSessionValidationFlips.length;
          i++) {
        wrongWordsBool = false;
        if (validationSessionInfo.listSessionValidationFlips[i] != null &&
            validationSessionInfo.listSessionValidationFlips[i].relevanceType ==
                RelevantType.IRRELEVANT) {
          wrongWordsBool = true;
        }
        LongAnswer answer = new LongAnswer(
            answer:
                validationSessionInfo.listSessionValidationFlips[i].answerType,
            wrongWords: wrongWordsBool,
            hash: validationSessionInfo.listSessionValidationFlips[i].hash);
        listAnswers.add(answer);
      }

      answers.epoch = 0;
      answers.nonce = 0;
      answers.answers = listAnswers;

      List<ParamLongAnswer> params = new List();
      params.add(answers);
      flipSubmitLongAnswersRequest.method =
          FlipSubmitLongAnswersRequest.METHOD_NAME;
      flipSubmitLongAnswersRequest.params = params;
      flipSubmitLongAnswersRequest.id = 101;
      flipSubmitLongAnswersRequest.key = keyApp;

      body = json.encode(flipSubmitLongAnswersRequest.toJson());

      logger.i(new JsonEncoder.withIndent('  ')
          .convert(flipSubmitLongAnswersRequest));
      responseHttp = await http.post(url, body: body, headers: requestHeaders);
      if (responseHttp.statusCode == 200) {
        flipSubmitLongAnswersResponse =
            flipSubmitLongAnswersResponseFromJson(responseHttp.body);
      }
    } catch (e) {
      logger.e(e.toString());
    }
    _completer.complete(flipSubmitLongAnswersResponse);
    return _completer.future;
  }
}
