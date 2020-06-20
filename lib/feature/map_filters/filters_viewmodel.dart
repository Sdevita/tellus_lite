import 'package:flutter/cupertino.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/feature/map_filters/models/time_filter_type.dart';
import 'package:telluslite/navigation/Routes.dart';
import 'package:telluslite/network/repositories/firestore_repository.dart';
import 'package:telluslite/persistent/models/user_configuration.dart';

class FiltersViewModel extends BaseViewModel {
  UserConfiguration _userConfiguration;
  TimeFilterType _timeFilterType;
  ScrollController _scrollController = ScrollController();

  init() async{
    showLoader();
    await _getUserConfiguration();
    _setTimeFilterType();
    _setScrollPosition();
    hideLoader();
  }

  _getUserConfiguration() async {
    FireStoreRepository fireStoreRepository = FireStoreRepository();
    _userConfiguration = await fireStoreRepository.loadUserConfiguration();
  }

  _setTimeFilterType(){
    if(_userConfiguration != null){
      switch(_userConfiguration.maxEta){
        case 7: _timeFilterType = TimeFilterType.oneWeek; break;
        case 30: _timeFilterType = TimeFilterType.oneMonth; break;
        case 90: _timeFilterType = TimeFilterType.threeMonth; break;
        case 180: _timeFilterType = TimeFilterType.sixMonth; break;
        case 365: _timeFilterType = TimeFilterType.oneYear; break;
        default :  _timeFilterType = TimeFilterType.oneWeek;
      }
      notifyListeners();
    }
  }
  _setScrollPosition(){
    if(selectedTimeFilterType != null) {
      var index = TimeFilterType.values.indexOf(selectedTimeFilterType);
      _scrollController.animateTo(index.roundToDouble() * 151 , duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
    }
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

  onTimeItemTap(TimeFilterType type){
    _timeFilterType = type;
    _userConfiguration.maxEta = type.getDay();
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
  TimeFilterType get selectedTimeFilterType => _timeFilterType ?? TimeFilterType.oneWeek;
  ScrollController get scrollController => _scrollController;
}
