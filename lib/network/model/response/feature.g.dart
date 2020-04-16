// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feature _$FeatureFromJson(Map<String, dynamic> json) {
  return Feature(
    geometry: json['geometry'] == null
        ? null
        : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    properties: json['properties'] == null
        ? null
        : Properties.fromJson(json['properties'] as Map<String, dynamic>),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$FeatureToJson(Feature instance) => <String, dynamic>{
      'geometry': instance.geometry?.toJson(),
      'properties': instance.properties?.toJson(),
      'type': instance.type,
    };
