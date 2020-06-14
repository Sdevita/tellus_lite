import 'package:flutter/cupertino.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/navigation/Routes.dart';
import 'package:telluslite/network/repositories/firestore_repository.dart';
import 'package:telluslite/persistent/models/user_configuration.dart';

class FiltersViewModel extends BaseViewModel {
  UserConfiguration _userConfiguration;

  init() {
    _getUserConfiguration();
  }

  _getUserConfiguration() async {
    showLoader();
    FireStoreRepository fireStoreRepository = FireStoreRepository();
    _userConfiguration = await fireStoreRepository.loadUserConfiguration();
    hideLoader();
  }

  onCancelTapped(BuildContext context) {
    Routes.sailor.pop();
  }

  onDistanceChanged(int distance) {
    _userConfiguration.maxRadiusKm = distance;
    notifyListeners();
  }

  onApplyTapped() async {
    if (_userConfiguration != null) {
      showLoader();
      FireStoreRepository fireStoreRepository = FireStoreRepository();
      await fireStoreRepository.saveUserConfiguration(_userConfiguration);
      hideLoader();
      Routes.sailor.pop();
    }
  }

  int get distance => _userConfiguration?.maxRadiusKm ?? 100;
}
