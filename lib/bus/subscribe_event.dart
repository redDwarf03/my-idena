// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:idena_lib_dart/model/response/dna_getBalance_response.dart';

class SubscribeEvent implements Event {
  final DnaGetBalanceResponse? response;

  SubscribeEvent({this.response});
}
