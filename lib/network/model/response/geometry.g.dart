// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(
    type: json['type'] as String,
    coordinates: (json['coordinates'] as List)
        ?.map((e) => (e as num)?.toDouble())
        ?.toList(),
  );
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'coordinates': instance.coordinates,
      'type': instance.type,
    };
