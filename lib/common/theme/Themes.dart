import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telluslite/common/constants/app_colors.dart';

class Themes {
  static ThemeData basicTheme(BuildContext context) {
    return ThemeData(
        brightness: Brightness.light,
        unselectedWidgetColor: Colors.grey[300],
        accentColor: Colors.blueAccent,
        primaryColor: Colors.blue,
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(brightness: Brightness.light),
        buttonColor: Colors.blue[700],
        canvasColor: Colors.white,
        fontFamily: 'Euclid');
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
        brightness: Brightness.dark,
        unselectedWidgetColor: AppColors.darkPrimary,
        accentColor: Colors.blueAccent,
        backgroundColor: AppColors.darkGray,
        buttonColor: AppColors.darkPrimary,
        primaryColor: Colors.blue,
        canvasColor: AppColors.darkGray,
        appBarTheme: AppBarTheme(brightness: Brightness.dark),
        fontFamily: 'Euclid');
  }
}
