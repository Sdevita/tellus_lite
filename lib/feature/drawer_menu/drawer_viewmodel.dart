import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/navigation/Routes.dart';

class DrawerViewModel extends BaseViewModel {
  bool isDrawerClosed = true;
  bool isNotificationVisible = true;
  bool _withNavigation = false;

  bool get withNavigation => _withNavigation;

  DrawerViewModel();

  init(BuildContext context) async {}

  showDrawer() {
    isDrawerClosed = false;
    notifyListeners();
  }

  dismissDrawer({bool withNavigation = false}) {
    _withNavigation = withNavigation;
    isDrawerClosed = true;
    notifyListeners();
  }

  navigateToSection(BuildContext context, String routeName) {
    dismissDrawer(withNavigation: routeName != Routes.map);
    if (!Routes.isCurrent(routeName)) {
      Future.delayed(Duration(milliseconds: 300), () {
        Routes.sailor.navigate(
          routeName,
          transitions: [SailorTransition.fade_in],
          transitionCurve: Curves.bounceInOut,
          transitionDuration: Duration(milliseconds: 400),
          navigationType: NavigationType.pushAndRemoveUntil,
          removeUntilPredicate: (_) => false,
        );
      });
    }
  }

  goToMap(BuildContext context) {
    if (!Routes.isCurrent(Routes.map)) {
      Routes.sailor.navigate(Routes.map, params: {"notification": null});
      dismissDrawer(withNavigation: true);
    }else{
      dismissDrawer(withNavigation: false);
    }
  }

  logOut(BuildContext context) async {}
}
