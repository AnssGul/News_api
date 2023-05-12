import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApi {
  final String _baseUrl = 'https://api.trtworld.com/v1/news';
  final String _apiKey;

  NewsApi(this._apiKey);

  Future<List<dynamic>> fetchNewsArticles() async {
    final String url = '$_baseUrl/articles?apikey=$_apiKey';
    final response = await http.get(Uri.parse(url));
    final responseBody = json.decode(response.body);
    return responseBody['data'];
  }

  Future<Map<String, dynamic>> fetchArticleById(String id) async {
    final String url = '$_baseUrl/articles/$id?apikey=$_apiKey';
    final response = await http.get(Uri.parse(url));
    final responseBody = json.decode(response.body);
    return responseBody['data'];
  }
}
