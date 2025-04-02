import 'package:flutter/material.dart';

class AppTheme {
  static Color kPrimaryColor = const Color(0xff303645);
  static Color kSecondaryColor = const Color(0xff00ffa3);
  static Color kThirdColor = const Color(0xff1a2031);
  static String kFontStyle1 = "Doto";
}

class ScreenSize {
  static late double width;
  static late double height;
  static void intial(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
}
