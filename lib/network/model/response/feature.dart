import 'package:json_annotation/json_annotation.dart';
import 'package:telluslite/network/model/response/geometry.dart';
import 'package:telluslite/network/model/response/properties.dart';


part 'feature.g.dart';

@JsonSerializable(explicitToJson: true)
class Feature {
  Geometry geometry;
  Properties properties;
  String type;

  Feature({this.geometry, this.properties, this.type});

  factory Feature.fromJson(Map<String, dynamic> json) => _$FeatureFromJson(json);
  Map<String, dynamic> toJson() => _$FeatureToJson(this);
}