import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData basicTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      accentColor: Colors.red,
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(brightness: Brightness.light),
      buttonColor: Colors.red,
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
      backgroundColor: Colors.black26,
      buttonColor: Colors.black,
      canvasColor: Colors.black,
      appBarTheme: AppBarTheme(brightness: Brightness.dark),
      textTheme: GoogleFonts.ubuntuTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }
}
