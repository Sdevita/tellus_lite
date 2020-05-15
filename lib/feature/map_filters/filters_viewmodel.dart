import 'package:flutter/cupertino.dart';
import 'package:telluslite/common/base_viewmodel.dart';

class FiltersViewModel extends BaseViewModel {
  onCancelTapped(BuildContext context) {
    Navigator.of(context).pop();
  }
}
