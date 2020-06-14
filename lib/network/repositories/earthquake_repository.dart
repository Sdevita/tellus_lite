import 'package:telluslite/network/model/response/ingv_response.dart';

import '../api_ingv_provider.dart';

class EarthquakeRepository {
  IngvApiProvider _apiProvider = IngvApiProvider();

  Future<IngvResponse> getEarthQuakes(double longitude, double latitude,
      {double minDepth = 0,
      double minMag = 2,
      int numberOfDay = 7,
      int maxRadiusKm = 100}) {
    return _apiProvider.getEarthquakes(longitude, latitude,
        minDepth: minDepth,
        minMag: minMag,
        numberOfDay: numberOfDay,
        maxRadiusKm: maxRadiusKm);
  }
}
