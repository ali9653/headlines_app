import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headlines_app/utils/colors.dart';
import 'package:headlines_app/utils/screen_utils.dart';
import 'package:skeleton_text/skeleton_text.dart';

class PlaceHolderList extends GetView {
  const PlaceHolderList({Key? key}) : super(key: key);


  Widget _imageCard () {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        shape: BoxShape.rectangle,
        color: cardColor,

      ),
      margin: EdgeInsets.symmetric(vertical: 5),

      height: ScreenUtils.responsiveHeight(26),
      width: ScreenUtils.responsiveWidth(100),
    );
  }


  Widget _animatedCard(double h, double w, double radius) {
    return SkeletonAnimation(
      shimmerColor: Colors.grey.shade900,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            shape: BoxShape.rectangle,
            color: cardColor,
          ),
          height: h,
          width: w,
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
          itemBuilder: (context,index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _imageCard(),
              _animatedCard(10,ScreenUtils.responsiveWidth(20),5),
              _animatedCard(10,ScreenUtils.responsiveWidth(90),5),
              _animatedCard(10,ScreenUtils.responsiveWidth(90),5),
            ],
          ),
        );
      }),
    );
  }
}
