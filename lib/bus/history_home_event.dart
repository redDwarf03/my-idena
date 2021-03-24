import 'package:event_taxi/event_taxi.dart';
import 'package:my_idena/network/model/response/bcn_transactions_response.dart';

class HistoryHomeEvent implements Event {
  final List<Transaction>? items;

  HistoryHomeEvent({this.items});
}