import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:headlines_app/utils/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

CustomFooter customFooter() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;

      if (mode == LoadStatus.idle) {
        body = Text(
          "No more articles",
          style: whiteW500.copyWith(fontSize: 16),
        );
      } else if (mode == LoadStatus.loading) {
        body = CircularProgressIndicator(strokeWidth: 4, valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
      } else if (mode == LoadStatus.failed) {
        body = body = Text("Loading failed");
      } else if (mode == LoadStatus.canLoading) {
        body = Text("Release to load more");
      } else {
        body = Text("No more Data");
      }
      return Container(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}
