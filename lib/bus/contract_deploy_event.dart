import 'package:event_taxi/event_taxi.dart';

class ContractDeployEvent implements Event {

  final String response;

  ContractDeployEvent({this.response});
}