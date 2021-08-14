import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headlines_app/app/modules/home/controllers/home_controller.dart';
import 'package:headlines_app/app/modules/search/controllers/search_controller.dart';
import 'package:headlines_app/utils/colors.dart';
import 'package:headlines_app/utils/constants.dart';
import 'package:headlines_app/utils/screen_utils.dart';
import 'package:headlines_app/widgets/custom_footer.dart';
import 'package:headlines_app/widgets/news_card.dart';
import 'package:headlines_app/widgets/placeholder_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  Widget _searchField() {
    return Container(
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        shape: BoxShape.rectangle,
      ),
      child: TextField(
        maxLines: 1,
        cursorColor: Colors.grey.shade600,
        controller: controller.searchController.value,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              CupertinoIcons.search,
              color: Colors.grey.shade700,
            ),
          ),
          border: InputBorder.none,
          prefixIconConstraints: BoxConstraints(),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SearchController());
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: scaffoldColor,
        titleSpacing: 15,
        title: Text(
          'Search News',
          style: whiteW500.copyWith(fontSize: 22),
        ),
        centerTitle: false,
        bottom: PreferredSize(preferredSize: Size.fromHeight(50), child: _searchField()),
      ),
      body: Obx(() {
        if (controller.areArticlesLoading.value) {
          return PlaceHolderList();
        } else {
          return Obx(
            () => controller.searchController.value.text.isNotEmpty
                ? SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    controller: controller.loadMoreController,
                    footer: customFooter(),
                    onLoading: () => controller.loadMoreArticles(controller.searchController.value.text),
                    child: ListView.builder(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: controller.articlesList.length,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            index: index,
                            article: controller.articlesList[index],
                          );
                        }),
                  )
                : Container(),
          );
        }
      }),
    );
  }
}
