import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{
    ThemeData _themeData;

    ThemeChanger(this._themeData);

    ThemeData get themeData => _themeData;

    set themeData(ThemeData themeData) {
      _themeData = themeData;
      notifyListeners();
    }

}