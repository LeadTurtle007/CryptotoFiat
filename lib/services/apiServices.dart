import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  APIService._insantiate();

  static final APIService instance = APIService._insantiate();
  final String _baseUrl = 'rest-sandbox.coinapi.io';

  Future<Map> fetchData({String crypto, String fiat}) async {
    http.Response response = await http.get(
        'https://rest-sandbox.coinapi.io/v1/exchangerate/' +
            crypto +
            '/' +
            fiat +
            '?apikey=F553A309-94D3-499F-8606-83A4453D3C99');

    Map data = json.decode(response.body);
    if (data != null) {
      return data;
    }
  }

  Future<int> checkData({String crypto, String fiat}) async {
    http.Response response = await http.get(
        'https://rest-sandbox.coinapi.io/v1/exchangerate/' +
            crypto +
            '/' +
            fiat +
            '?apikey=F553A309-94D3-499F-8606-83A4453D3C99');

    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<List> check() async {
    http.Response response = await http.get(
        'https://rest-sandbox.coinapi.io/v1/assets?apikey=F553A309-94D3-499F-8606-83A4453D3C99');

    List data = json.decode(response.body);
    if (data != null) {
      return data;
    }
  }
}
