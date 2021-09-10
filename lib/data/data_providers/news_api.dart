import 'dart:convert';

import 'package:http/http.dart' as http;

const _apiKey = 'ad5fd66639b84f6fab0a3abb846aa9fb';

class NewsApi {
  http.Client _httpClient = http.Client();

  static final instance = NewsApi._init();
  NewsApi._init();

  //get the articles from the api as list
  Future<List<dynamic>> fetchArticles({required int pageIndex}) async {
    final response =
        await _httpClient.get(Uri.parse('https://newsapi.org/v2/top'
            '-headlines?'
            'country=eg'
            '&page=$pageIndex'
            '&apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body)["articles"] as List;
      return body;
    }
    throw Exception('error fetching articles');
  }
}
