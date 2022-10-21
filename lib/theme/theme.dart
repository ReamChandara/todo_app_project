import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/service/theme_service.dart';

Color bluishClr = const Color(0XFF4E5A8E);
Color yellowClr = const Color(0XFFFFB746);
Color pinkClr = const Color(0XFFFF4667);
Color whiteClr = Colors.white;
Color? primaryClr = Colors.teal[200];
Color? darkHeaderClr = Colors.blueGrey[800];

class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.amber,
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: darkHeaderClr,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyte {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
}

TextStyle get headingStyte {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle miniTextStyte({double fontSize = 16}) {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get dateTimeTextStyte {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.grey[600],
  ));
}
