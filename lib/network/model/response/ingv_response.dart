import 'package:json_annotation/json_annotation.dart';
import 'package:telluslite/network/model/response/feature.dart';

part 'ingv_response.g.dart';

@JsonSerializable(explicitToJson: true)
class IngvResponse{
   List<Feature> features;
   String type;
   String error;
   int errorCode;
   bool hasError = false;

   IngvResponse({this.type,this.features});

   factory IngvResponse.fromJson(Map<String, dynamic> json) => _$IngvResponseFromJson(json);
   Map<String, dynamic> toJson() => _$IngvResponseToJson(this);

   IngvResponse.withError(String errorValue, {int errorCode})
       : features = List(),
          error = errorValue, this.errorCode = errorCode, this.hasError = true;

}