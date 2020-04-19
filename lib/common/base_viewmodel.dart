import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class BaseViewModel extends ChangeNotifier {
  bool _loader = false;

  showLoader() {
    _loader = true;
    notifyListeners();
  }

  hideLoader() {
    _loader = false;
    notifyListeners();
  }

  bool get loader => _loader;

}
