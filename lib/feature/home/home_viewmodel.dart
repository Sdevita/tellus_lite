import 'package:flutter/cupertino.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/common/widgets/Dialog.dart';
import 'package:telluslite/navigation/Routes.dart';
import 'package:telluslite/network/model/response/feature.dart';
import 'package:telluslite/network/model/response/ingv_response.dart';
import 'package:telluslite/network/repositories/earthquake_repository.dart';

class HomeViewModel extends BaseViewModel{
  List<Feature> _earthquakeList;

  getEarthquakes(BuildContext context) async {
    EarthquakeRepository repository = EarthquakeRepository();
    showLoader();
    IngvResponse response = await repository.getEarthQuakes();
    hideLoader();
    if(response != null){
      _handleResponse(response, context);
    }
  }

  _handleResponse(IngvResponse response, BuildContext context){
    if(response.error != null && response.error.isNotEmpty){
      Dialog.showDefaultAlert(context);
    }else{
      _earthquakeList = response.features;
      Routes.sailor.navigate(Routes.settingsRoute);
    }
  }

  List<Feature> get earthquakeList {
    if(_earthquakeList != null){
      return _earthquakeList;
    }else{
      return List();
    }
  }

}