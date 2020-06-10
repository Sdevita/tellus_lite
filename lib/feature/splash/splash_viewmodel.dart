import 'package:flutter/cupertino.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/navigation/Routes.dart';
import 'package:telluslite/network/repositories/firebase_auth_repository.dart';
import 'package:telluslite/push_notification/push_notification_manager.dart';

class SplashViewModel extends BaseViewModel {
  bool _isUserLogged;

  init(BuildContext context) async {
    await PushNotificationsManager().enable();
    PushNotificationsManager().init();
    var authRepo = FireBaseAuthRepository();
    _isUserLogged = await authRepo.isUserLogged();
    notifyListeners();
    navigate(context);
  }

  navigate(BuildContext context) {
    if (_isUserLogged) {
      _goToHome(context);
    } else {
      _goToLogin(context);
    }
  }

  _goToHome(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false);
  }

  pushNavigation(BuildContext context, Map<String, dynamic> notificationModel) {
    print(notificationModel);
    if (_isUserLogged) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (route) => false,
          arguments: notificationModel);
    } else {
      _goToLogin(context);
    }
  }

  _goToLogin(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
  }
}
