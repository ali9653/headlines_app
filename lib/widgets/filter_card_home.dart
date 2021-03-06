import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headlines_app/app/modules/home/controllers/home_controller.dart';
import 'package:headlines_app/utils/colors.dart';
import 'package:headlines_app/utils/constants.dart';
import 'package:headlines_app/utils/screen_utils.dart';

class FilterCard extends GetView<HomeController> {
  final String? title;

  const FilterCard({Key? key, this.title}) : super(key: key);

  Widget _title() {
    return Container(width: 80, color: Colors.transparent, child: Text(title!, style: whiteW500.copyWith(fontSize: 16)));
  }

  Widget _categoryCard(int index) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.switchCategory(index);
        },
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: new BoxDecoration(
              border: controller.compareSelectedCategory(index)
                  ? new Border.all(
                      color: Colors.white,
                      width: 1,
                    )
                  : null,
              color: controller.compareSelectedCategory(index) ? shadowColor : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(35)),
              shape: BoxShape.rectangle,
            ),
            child: Text(
              controller.categories[index],
              style: TextStyle(fontWeight: FontWeight.bold, color: controller.compareSelectedCategory(index) ? Colors.white : Colors.black),
            )),
      ),
    );
  }

  Widget _categoriesListBuilder() {
    return Container(
      width: ScreenUtils.responsiveWidth(100) - (95),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            return _categoryCard(index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Container(
      height: 35,
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(bottom: 10, top: 5),
      child: Row(
        children: [_title(), _categoriesListBuilder()],
      ),
    );
  }
}
