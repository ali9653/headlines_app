import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:headlines_app/models/headlines.dart';
import 'package:headlines_app/services/headlines_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchController extends GetxController {
  var searchController = TextEditingController().obs;
  var areArticlesLoading = false.obs;
  var articlesList = <Article>[].obs;
  RefreshController loadMoreController = RefreshController(initialRefresh: false);
  var page = 1.obs;
  var message = "".obs;

  @override
  void onInit() {


    debounce(message, (_) {
      fetchArticles(searchController.value.text);
    },time: Duration(milliseconds: 800));

    searchController.value = TextEditingController()
      ..addListener(() {
        if (message.value != searchController.value.text) {
          message.value = searchController.value.text;

        } else if (searchController.value.text.isEmpty) {
          articlesList.clear();
        } else {
          return;
        }
      });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.value.dispose();
    loadMoreController.dispose();
  }

  void fetchArticles(String keyword) async {
    print("fetchhh");
    try {
      areArticlesLoading(true);
      var articles = await HeadlinesApi.getArticlesFromSearch(keyword, page.value);
      articlesList.assignAll(articles);
    } finally {
      areArticlesLoading(false);
    }
  }

  void loadMoreArticles(String keyword) async {
    page.value++;
    var articles = await HeadlinesApi.getArticlesFromSearch(keyword, page.value);
    if (articles.isNotEmpty) {
      articlesList.addAll(articles);
      loadMoreController.loadComplete();
    } else {
      loadMoreController.loadComplete();
    }
  }
}
