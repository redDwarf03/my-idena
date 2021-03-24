import 'package:event_taxi/event_taxi.dart';
import 'package:my_idena/network/model/response/dna_getBalance_response.dart';

class SubscribeEvent implements Event {
  final DnaGetBalanceResponse? response;

  SubscribeEvent({this.response});
}