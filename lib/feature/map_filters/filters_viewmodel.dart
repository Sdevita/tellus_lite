import 'package:flutter/cupertino.dart';
import 'package:telluslite/common/base_viewmodel.dart';

class FiltersViewModel extends BaseViewModel {
  double _distance = 100;

  onCancelTapped(BuildContext context) {
    Navigator.of(context).pop();
  }

  onDistanceChanged(double distance) {
    _distance = distance;
    notifyListeners();
  }

  double get distance => _distance;
}
