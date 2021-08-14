import 'dart:convert';
import 'dart:io';
import 'package:headlines_app/models/headlines.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HeadlinesApi {

  static final String _baseUrl = "https://newsapi.org/v2/";
  static final String _apiKey = "a3a41bcceb5646d3a96f578986275a46";

  static List<Article> getArticles ( String responseBody ) {
    Map<String, dynamic> json = jsonDecode(responseBody);
    List<dynamic> body = json['articles'];
    List<Article> articles = body.map((e) => Article.fromJson(e)).toList();
    return articles;
  }


  static Future<List<Article>> getTopHeadlines(String category, int page) async {
    try {
      var response = await http.get(Uri.parse("${_baseUrl}top-headlines?country=us&page=$page&category=$category&pageSize=15&apiKey=${_apiKey}"));
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("headlines", response.body);
        return getArticles(response.body);
      } else {
        print("no articles");
        return <Article>[];
      }
    } on SocketException {
      print("no internet");
      return <Article>[];
    }
  }

  static Future<List<Article>> getArticlesFromSearch(String keyword, int page) async {
    try {
      var response = await http.get(Uri.parse("${_baseUrl}everything?q=$keyword&apiKey=${_apiKey}&page=$page&pageSize=25"));
      if (response.statusCode == 200) {
        return getArticles(response.body);
      } else {
        print("no articles");
        return <Article>[];
      }
    } on SocketException {
      print("no internet");
      return <Article>[];
    }
  }
}
