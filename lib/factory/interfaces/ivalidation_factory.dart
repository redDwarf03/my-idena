

import 'package:my_idena/network/model/dictWords.dart';
import 'package:my_idena/network/model/response/flip_submitLongAnswers_response.dart';
import 'package:my_idena/network/model/response/flip_submitShortAnswers_response.dart';
import 'package:my_idena/network/model/validation_session_infos.dart';

abstract class IValidationFactory {

  Future<ValidationSessionInfo> getValidationSessionFlipsList(
      String typeSession,
      ValidationSessionInfo validationSessionInfoInput,
      bool simulationMode,
      String address);

  Future<ValidationSessionInfoFlips> getValidationSessionFlipDetail(
      ValidationSessionInfoFlips validationSessionInfoFlips,
      String address,
      bool simulationMode,
      String privateKey);

  Future<List<Word>> getWordsFromHash(
      String hash, bool simulationMode, List<Word> wordsMap);

  Future<String> loadAssets(String fileName);

  Future<FlipSubmitShortAnswersResponse> submitShortAnswers(
      ValidationSessionInfo validationSessionInfo);

  Future<FlipSubmitLongAnswersResponse> submitLongAnswers(
      ValidationSessionInfo validationSessionInfo);

}
