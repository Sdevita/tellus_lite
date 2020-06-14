import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/feature/drawer_menu/drawer_viewmodel.dart';

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

  void onMenuClicked(BuildContext context) {
    try {
      DrawerViewModel drawerViewModel =
          Provider.of<DrawerViewModel>(context, listen: false);
      drawerViewModel.isDrawerClosed
          ? drawerViewModel.showDrawer()
          : drawerViewModel.dismissDrawer();
    } catch (e) {
      //todo check this error
      //DO NOTHING
    }
  }
}
