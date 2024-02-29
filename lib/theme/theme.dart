import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color bluishClr = const Color(0XFF4E5A8E);
Color yellowClr = const Color(0XFFFFB746);
Color pinkClr = const Color(0XFFFF4667);
Color whiteClr = Colors.white;
Color? primaryClr = Colors.teal[200];
Color? darkHeaderClr = Colors.blueGrey[800];

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: darkHeaderClr,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyte {
  return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey);
}

TextStyle get headingStyte {
  return TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black);
}

TextStyle miniTextStyte({double fontSize = 16}) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black);
}

TextStyle get dateTimeTextStyte {
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.grey[600],
  );
}
