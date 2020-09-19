import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:my_idena/backoffice/bean/coins_response.dart';

class CoinsService {
  var logger = Logger();

  Future<CoinsResponse> getCoinsResponse() async {
    CoinsResponse coinsResponse;
    try {
      HttpClient httpClient = new HttpClient();

      HttpClientRequest request = await httpClient
          .getUrl(Uri.parse("https://api.coingecko.com/api/v3/coins/idena?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false"));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        coinsResponse = coinsResponseFromJson(reply);
      }
    } catch (e) {}
    return coinsResponse;
  }
}
