import 'package:get/get.dart';

class ScreenUtils {
  static double _screenHeight = Get.height;
  static double _screenWidth = Get.width;

  static double responsiveHeight(double i) {
    return _screenHeight * i / 100;
  }

  static double responsiveWidth(double i) {
    return _screenWidth * i / 100;
  }

  static double responsiveFontSize(double i) {
    return _screenWidth / 100 * (i / 3);
  }
}
