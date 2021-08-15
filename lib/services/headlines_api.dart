import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:headlines_app/models/headlines.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HeadlinesApi {
  static Random random = new Random();
  // Since the free version of NewsApi has the limit of 100 requests per day, 4 api keys have been added to avoid any stoppage during the testing of the app
  static final List<String> keys = [
    "372c1bec5e7b4f23b678bab4a9905f01",
    "81a01b30c5774bb68889bf62e3b038a7",
    "9b6c3160fad54f6aa8ab9ff6ffd7cbef",
    "e26618e15d774b558dbc0a0f7554234f"
  ];
  //static final List<String> keys = ["1d7366e623bc4ac99c02ce5332d06f48","55052fc1657941539754b50b5cfb3f10"];
  static final String _baseUrl = "https://newsapi.org/v2/";
  static final String _apiKey = "0050429b837248698a431adaf52e0b5c";

  static List<Article> getArticles(String responseBody) {
    Map<String, dynamic> json = jsonDecode(responseBody);
    List<dynamic> body = json['articles'];
    List<Article> articles = body.map((e) => Article.fromJson(e)).toList();
    return articles;
  }

  static Future<List<Article>> getTopHeadlines(String category, int page) async {
    try {
      var response = await http.get(Uri.parse(
          "${_baseUrl}top-headlines?country=us&page=$page&category=$category&pageSize=15&apiKey=${keys[random.nextInt(keys.length)].toString()}"));
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
      var response =
          await http.get(Uri.parse("${_baseUrl}everything?q=$keyword&apiKey=${keys[random.nextInt(keys.length)].toString()}&page=$page&pageSize=25"));
      if (response.statusCode == 200) {
        print("got response");
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
