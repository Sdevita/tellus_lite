import 'dart:convert';

import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/network/model/response/ingv_response.dart';
import 'package:telluslite/network/repositories/earthquake_repository.dart';

class HomeViewModel extends BaseViewModel{

  getEarthquakes() async {
    EarthquakeRepository repository = EarthquakeRepository();
    showLoader();
    IngvResponse response = await repository.getEarthQuakes();
    hideLoader();
    print(response.features.first.properties.place);
  }

}