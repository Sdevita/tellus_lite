import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/common/constants/app_key.dart';
import 'package:telluslite/navigation/Routes.dart';
import 'package:telluslite/network/repositories/firebase_auth_repository.dart';
import 'package:telluslite/push_notification/push_notification_manager.dart';

class SettingsViewModel extends BaseViewModel {
  bool switchValue = false;

  logout(BuildContext context) {
    var firebaseRepo = FireBaseAuthRepository();
    firebaseRepo.logout().then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.login, (Route<dynamic> route) => false);
    });
  }

  onSwitchChange(bool isDarkMode) async {
    this.switchValue = isDarkMode;
    notifyListeners();
    var preference = await SharedPreferences.getInstance();
    preference.setBool(AppKeys.DARK_MODE_KEY, isDarkMode);
  }

  enableNotification() async {
    var status = await Permission.notification.status;

    if (status.isUndetermined) {
      status = await Permission.notification.request();
    }
    if (status.isGranted) {
      showLoader();
      await PushNotificationsManager().enable();
      hideLoader();
    }
  }
}
