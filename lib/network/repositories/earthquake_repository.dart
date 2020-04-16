import 'package:telluslite/network/model/response/ingv_response.dart';

import '../api_ingv_provider.dart';

class EarthquakeRepository{
  IngvApiProvider _apiProvider = IngvApiProvider();

  Future<IngvResponse> getEarthQuakes(){
    return _apiProvider.getEarthquakes();
  }
}