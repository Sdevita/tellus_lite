import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:telluslite/network/model/response/ingv_response.dart';


class IngvApiProvider{
  final String _endpoint = "http://webservices.ingv.it/fdsnws/event/1/query?starttime=2020-04-22T00:00:00&format=geojson";
  final Dio _dio = Dio();

  Future<IngvResponse> getEarthquakes() async {
    try {
      _addInterceptors();
      Response response = await _dio.get(_endpoint);
      return IngvResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return IngvResponse.withError("$error");
    }
  }

  _addInterceptors (){
    _dio.interceptors..add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: false,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

}