import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apikey = '7E08E58B-B728-4EA0-8722-08A2A9B6B42E';
const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  late final String? url;
  CoinData({this.url});

  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestUrl =
          '$coinApiUrl/$crypto/$selectedCurrency?apikey=$apikey';
      Uri myUri = Uri.parse(requestUrl);
      http.Response response = await http.get(myUri);

      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);

        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        //Optional: throw an error if our request fails.
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
