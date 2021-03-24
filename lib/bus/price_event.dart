import 'package:event_taxi/event_taxi.dart';
import 'package:my_idena/network/model/response/simplePrice/simple_price_response.dart';

class PriceEvent implements Event {
  final SimplePriceResponse? response;

  PriceEvent({this.response});
}