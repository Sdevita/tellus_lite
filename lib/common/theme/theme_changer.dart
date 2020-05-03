import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';

import 'Themes.dart';

class ThemeChanger with ChangeNotifier{
    ThemeData _themeData;
    bool _isDarkModeTheme;

    ThemeChanger();

    ThemeData get themeData => _themeData;

    setThemeData(ThemeData themeData, isDarkModeTheme) {
      _themeData = themeData;
      _isDarkModeTheme = isDarkModeTheme;
      notifyListeners();
    }

    setDarkMode(BuildContext context)async{
      _themeData = Themes.darkTheme(context);
      _isDarkModeTheme = true;
      notifyListeners();
      if(Platform.isIOS) {
        await FlutterStatusbarTextColor.setTextColor(
            FlutterStatusbarTextColor.light);
      }
    }



    setLightMode(BuildContext context)async{
      _themeData = Themes.basicTheme(context);
      _isDarkModeTheme = false;
      notifyListeners();
      if(Platform.isIOS) {
        await FlutterStatusbarTextColor.setTextColor(
            FlutterStatusbarTextColor.dark);
      }
    }

    bool get isDarkModeTheme => _isDarkModeTheme;

}