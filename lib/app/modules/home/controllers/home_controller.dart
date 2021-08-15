import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:headlines_app/models/headlines.dart';
import 'package:headlines_app/services/headlins_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  var areArticlesLoading = true.obs;
  var articleList = <Article>[].obs;
  RefreshController loadMoreController = RefreshController(initialRefresh: false);
  List<String> categories = ["Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"];
  var selectedCategory = "".obs;
  var page = 1.obs;

  @override
  void onInit() {
    fetchTopHeadlines();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    loadMoreController.dispose();
  }

  void fetchTopHeadlines() async {
    try {
      areArticlesLoading(true);
      var articles = await HeadlinesApi.getTopHeadlines(selectedCategory.value.toUpperCase(), page.value);
      articleList.assignAll(articles);
    } finally {
      areArticlesLoading(false);
    }
  }

  void refreshArticles() async {
    page.value = 1;
    selectedCategory.value = "";
    try {
      areArticlesLoading(true);
      var articles = await HeadlinesApi.getTopHeadlines(selectedCategory.value.toLowerCase(), page.value);
      if (articleList.isNotEmpty) {
        articleList.assignAll(articles);
        loadMoreController.refreshCompleted();
      } else {
        loadMoreController.refreshCompleted();
      }
    } finally {
      areArticlesLoading(false);
    }
  }

  void loadMoreArticles() async {
    page.value++;
    var articles = await HeadlinesApi.getTopHeadlines(selectedCategory.value.toLowerCase(), page.value);
    if (articleList.isNotEmpty) {
      articleList.addAll(articles);
      loadMoreController.loadComplete();
    } else {
      loadMoreController.loadComplete();
    }
  }

  void switchCategory(int index) {
    selectedCategory.value = categories[index];
    this.fetchTopHeadlines();
  }

  bool compareSelectedCategory(int index) {
    if (selectedCategory.value == categories[index]) {
      return true;
    } else {
      return false;
    }
  }
}
