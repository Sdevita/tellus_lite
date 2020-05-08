import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:telluslite/network/model/response/ingv_response.dart';

class IngvApiProvider {
  //DateTime currentPhoneDate = DateTime.now(); //DateTime
  //String date = new DateFormat("yyyy-mm-ddThh-mm-ss", "UTC").toString();
  final String _endpoint = "http://webservices.ingv.it/fdsnws/event/1/query";
  final Dio _dio = Dio();

  Future<IngvResponse> getEarthquakes(double longitude, double latitude,
      {double minDepth = 0, double minMag = 2, int numberOfDay = 2}) async {
    try {
      _addInterceptors();
      var yesterday = DateTime.now().subtract(Duration(days: numberOfDay));
      var starTime = yesterday.toIso8601String();
      Response response = await _dio.get(_endpoint, queryParameters: {
        "starttime": starTime,
        "mindepth": minDepth,
        "minmag": minMag,
        "lat": latitude,
        "lon": longitude,
        "maxradiuskm": 20000,
        "format": "geojson"
      });
      return IngvResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return IngvResponse.withError("$error");
    }
  }

  _addInterceptors() {
    _dio.interceptors
      ..add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: false,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90));
  }
}
