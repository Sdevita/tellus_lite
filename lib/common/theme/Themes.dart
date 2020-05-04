import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData basicTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      accentColor: Colors.white,
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(brightness: Brightness.light),
      buttonColor: Colors.green[700],
      canvasColor: Colors.white,
      textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.white,
      backgroundColor: Colors.blueGrey[700],
      buttonColor: Colors.blueGrey,
      primaryColor: Colors.white,
      canvasColor: Colors.black12,
      appBarTheme: AppBarTheme(brightness: Brightness.dark),
      textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }
}
