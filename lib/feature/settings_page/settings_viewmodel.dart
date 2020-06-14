import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sailor/sailor.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/navigation/Routes.dart';
import 'package:telluslite/network/repositories/firebase_auth_repository.dart';
import 'package:telluslite/persistent/repositories/secure_store_repository.dart';
import 'package:telluslite/push_notification/push_notification_manager.dart';

class SettingsViewModel extends BaseViewModel {
  bool switchValue = false;

  init() async {
    SecureStoreRepository secureStoreRepository = SecureStoreRepository();
    switchValue = await secureStoreRepository.hasDarkModeSaved();
    notifyListeners();
  }

  logout(BuildContext context) {
    var firebaseRepo = FireBaseAuthRepository();
    firebaseRepo.logout().then((value) {
      Routes.sailor.navigate(Routes.login,
          navigationType: NavigationType.pushReplace,
          removeUntilPredicate: (Route<dynamic> route) => false);
    });
  }

  onSwitchChange(bool isDarkMode) async {
    this.switchValue = isDarkMode;
    notifyListeners();
    _savePreference();
  }

  _savePreference() {
    SecureStoreRepository secureStoreRepository = SecureStoreRepository();
    secureStoreRepository.saveDarkModeSettings(switchValue);
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

  onBack(BuildContext context) {
    Navigator.pop(context, switchValue);
  }
}
