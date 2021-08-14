import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:headlines_app/app/modules/search/views/search_view.dart';
import 'package:headlines_app/utils/colors.dart';
import 'package:headlines_app/utils/constants.dart';
import 'package:headlines_app/utils/screen_utils.dart';
import 'package:headlines_app/widgets/custom_footer.dart';
import 'package:headlines_app/widgets/news_card.dart';
import 'package:headlines_app/widgets/placeholder_list.dart';
import 'package:headlines_app/widgets/filter_card_home.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  Widget _searchButton() {
    return IconButton(
        splashRadius: 20,
        constraints: BoxConstraints(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        onPressed: () {
          Get.to(() => SearchView());
        },
        icon: Icon(
          CupertinoIcons.search,
          color: Colors.white,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: scaffoldColor,
          titleSpacing: 15,
          title: Text(
            'Top News',
            style: whiteW500.copyWith(fontSize: 22),
          ),
          centerTitle: false,
          actions: [_searchButton()],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: FilterCard(title: "Filter by:",),
          ),
        ),
        body: Obx(() {
          if (controller.areArticlesLoading.value) {
            return PlaceHolderList();
          } else {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: controller.loadMoreController,
              footer: customFooter(),
              header: CustomHeader(
                builder: (context, mode) {
                  return Container(
                    child: Center(child: CircularProgressIndicator(strokeWidth: 4, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
                  );
                },
              ),
              onRefresh: () {
                Timer(Duration(seconds: 1), () {
                  controller.refreshArticles();
                });
              },
              onLoading: () => controller.loadMoreArticles(),
              child: ListView.builder(
                  itemCount: controller.articleList.length,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      index: index,
                      article: controller.articleList[index],
                    );
                  }),
            );
          }
        }));
  }
}
