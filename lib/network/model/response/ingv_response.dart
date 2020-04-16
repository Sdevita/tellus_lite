import 'package:json_annotation/json_annotation.dart';
import 'package:telluslite/network/model/response/feature.dart';

part 'ingv_response.g.dart';

@JsonSerializable(explicitToJson: true)
class IngvResponse{
   List<Feature> features;
   String type;
   String error;

   IngvResponse({this.type,this.features});

   factory IngvResponse.fromJson(Map<String, dynamic> json) => _$IngvResponseFromJson(json);
   Map<String, dynamic> toJson() => _$IngvResponseToJson(this);

   IngvResponse.withError(String errorValue)
       : features = List(),
          error = errorValue;
}