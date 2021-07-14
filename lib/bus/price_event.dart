// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:idena_lib_dart/model/response/simplePrice/simple_price_response.dart';

class PriceEvent implements Event {
  final SimplePriceResponse? response;

  PriceEvent({this.response});
}
