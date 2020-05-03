import 'package:flutter/cupertino.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/navigation/Routes.dart';
import 'package:telluslite/network/repositories/firebase_auth_repository.dart';

class SettingsViewModel extends BaseViewModel {
  logout(BuildContext context) {
    var firebaseRepo = FireBaseAuthRepository();
    firebaseRepo.logout().then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.login, (Route<dynamic> route) => false);
    });
  }
}
