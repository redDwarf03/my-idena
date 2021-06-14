// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:idena_lib_dart/model/response/bcn_transactions_response.dart';

class HistoryHomeEvent implements Event {
  final List<Transaction>? items;

  HistoryHomeEvent({this.items});
}
