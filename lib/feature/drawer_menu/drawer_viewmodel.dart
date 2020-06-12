import 'package:flutter/material.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/navigation/Routes.dart';

class DrawerViewModel extends BaseViewModel {
  bool isDrawerClosed = true;
  bool isNotificationVisible = true;
  bool _withNavigation = false;

  bool get withNavigation => _withNavigation;

  DrawerViewModel();


  init(BuildContext context) async{

  }

  showDrawer() {
    isDrawerClosed = false;
    notifyListeners();
  }

  dismissDrawer({bool withNavigation = false}) {
    _withNavigation = withNavigation;
    isDrawerClosed = true;
    notifyListeners();
  }

  navigateToSection(BuildContext context, String routeName){
    dismissDrawer(withNavigation: routeName != "/home");
    if (!Routes.isCurrent(routeName, context)) {
      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.of(context).pushNamed(routeName);
      });
    }
  }

  goToMap(BuildContext context){
    Navigator.pushNamed(context, Routes.home);
    dismissDrawer(withNavigation: true);
  }


  logOut(BuildContext context) async {
  }
}
