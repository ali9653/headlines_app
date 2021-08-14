import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headlines_app/app/modules/home/controllers/home_controller.dart';
import 'package:headlines_app/models/headlines.dart';
import 'package:headlines_app/utils/colors.dart';
import 'package:headlines_app/utils/constants.dart';
import 'package:headlines_app/utils/screen_utils.dart';
import 'package:headlines_app/views/detailed_article_view.dart';

class NewsCard extends GetView<HomeController> {
  final int index;
  final Article article;

  const NewsCard({
    Key? key,
    required this.index,
    required this.article,
  }) : super(key: key);

  Widget _imageCard() {
    var image = article.urlToImage;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: image == null
          ? Container(
        child: Icon(Icons.article,color: Colors.grey.shade700,size: ScreenUtils.responsiveHeight(20),),
              height: ScreenUtils.responsiveHeight(25),
              width: ScreenUtils.responsiveWidth(100),
            )
          : Image(
              image: CachedNetworkImageProvider(article.urlToImage.toString()),
              fit: BoxFit.cover,
              height: ScreenUtils.responsiveHeight(25),
              width: ScreenUtils.responsiveWidth(100),
            ),
    );
  }

  Widget _sourceCard() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: new BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), shape: BoxShape.rectangle, color: shadowColor),
        child: Text(
          article.source!.name!,
          style: whiteBold.copyWith(fontSize: 14),
        ));
  }

  Widget _titleCard(BuildContext context) {
    return Container(
      child: Text(
        article.title!,
        style: Theme.of(context).textTheme.overline!.merge(whiteW500.copyWith(fontSize: 15)),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(() => DetailedArticleView(article: article,));
        },
        child: Card(
          color: cardColor,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _imageCard(),
                _sourceCard(),
                SizedBox(
                  height: 5,
                ),
                _titleCard(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
