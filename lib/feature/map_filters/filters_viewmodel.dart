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
    Routes.sailor.pop(false);
  }

  onDistanceChanged(int distance) {
    _userConfiguration.maxRadiusKm = distance;
    notifyListeners();
  }

  onMagnitudeChanged(int magnitude){
    _userConfiguration.minMagnitude = magnitude;
    notifyListeners();
  }

  onApplyTapped() async {
    if (_userConfiguration != null) {
      showLoader();
      FireStoreRepository fireStoreRepository = FireStoreRepository();
      await fireStoreRepository.saveUserConfiguration(_userConfiguration);
      hideLoader();
      Routes.sailor.pop(true);
    }
  }

  int get distance => _userConfiguration?.maxRadiusKm ?? 100;
  int get minMagnitude => _userConfiguration?.minMagnitude ?? 2;

}
