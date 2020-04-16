import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier{
  bool _loader = false;

  showLoader(){
    _loader= true;
    notifyListeners();
  }

  hideLoader(){
    _loader = false;
    notifyListeners();
  }

  bool get loader => _loader;
}