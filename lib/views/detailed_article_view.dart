import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headlines_app/models/headlines.dart';
import 'package:headlines_app/utils/colors.dart';
import 'package:headlines_app/utils/constants.dart';
import 'package:headlines_app/utils/screen_utils.dart';
import 'package:share/share.dart';

class DetailedArticleView extends GetView {
  final Article article;

  const DetailedArticleView({Key? key, required this.article}) : super(key: key);

  Widget shareButton() {
    return IconButton(
        splashRadius: 20,
        constraints: BoxConstraints(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        onPressed: () {
         Share.share(article.url.toString());
        },
        icon: Icon(
          CupertinoIcons.share,
          color: Colors.white,
        ));
  }


  Widget _imageCard() {
    var image = article.urlToImage;
    return image == null
        ? Container(
            child: Icon(
              Icons.article,
              color: Colors.grey.shade700,
              size: ScreenUtils.responsiveHeight(25),
            ),
            height: ScreenUtils.responsiveHeight(30),
            width: ScreenUtils.responsiveWidth(100),
          )
        : Image(
            image: CachedNetworkImageProvider(article.urlToImage.toString()),
            fit: BoxFit.cover,
            height: ScreenUtils.responsiveHeight(35),
            width: ScreenUtils.responsiveWidth(100),
          );
  }

  Widget _titleCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtils.responsiveWidth(5)),
      padding: EdgeInsets.only(top: 15, bottom: 25),
      child: Text(
        article.title!,
        style: Theme.of(context).textTheme.overline!.merge(whiteW500.copyWith(fontSize: 25)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 5,
      width: ScreenUtils.responsiveWidth(15),
      color: shadowColor,
    );
  }

  Widget _authorCard() {
    var author = article.author;
    if (author != null && author != "") {
      return Column(
        children: [
          _divider(),
          Container(
              margin: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
              child: Text(
                "By " + author,
                style: whiteBold.copyWith(
                  fontSize: 18,
                ),
              )),
          _divider(),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _contentCard() {
    var content = article.content;
    if (content != null) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Text(
            content,
            style: whiteNormal.copyWith(fontSize: 16),
          ));
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: scaffoldColor,
        titleSpacing: 15,
        title: Text(
          article.source!.name.toString(),
          style: whiteW500.copyWith(fontSize: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: false,
        actions: [shareButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imageCard(),
            _titleCard(context),
            _authorCard(),
            _contentCard(),
          ],
        ),
      ),
    );
  }
}
