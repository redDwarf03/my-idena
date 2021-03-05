import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:my_idena/network/model/response/coins_price_response.dart';
import 'package:my_idena/network/model/response/coins_response.dart';


class ApiCoinsService {
  var logger = Logger();

  Future<CoinsResponse> getCoinsResponse() async {
    CoinsResponse coinsResponse;
    HttpClient httpClient = new HttpClient();
    try {
      HttpClientRequest request = await httpClient
          .getUrl(Uri.parse("https://api.coingecko.com/api/v3/coins/idena"));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        coinsResponse = coinsResponseFromJson(reply);
      }
    } catch (e, s) {
      //print("pb coin exception : " + e.toString());
      //print("pb coin stack : " + s.toString());
    } finally {
      httpClient.close();
    }
    return coinsResponse;
  }

  Future<CoinsPriceResponse> getCoinsChart(String currency, int nbDays) async {
    CoinsPriceResponse coinsPriceResponse;
    HttpClient httpClient = new HttpClient();
    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://api.coingecko.com/api/v3/coins/idena/market_chart?vs_currency=" +
              currency +
              "&days=" +
              nbDays.toString()));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        coinsPriceResponse = coinsPriceResponseFromJson(reply);
      }
    } catch (e, s) {
      print(e.toString());
      print(s.toString());
    } finally {
      httpClient.close();
    }
    return coinsPriceResponse;
  }
}
