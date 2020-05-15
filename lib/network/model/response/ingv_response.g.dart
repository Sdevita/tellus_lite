// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingv_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngvResponse _$IngvResponseFromJson(Map<String, dynamic> json) {
  return IngvResponse(
    type: json['type'] as String,
    features: (json['features'] as List)
        ?.map((e) =>
            e == null ? null : Feature.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..error = json['error'] as String;
}

Map<String, dynamic> _$IngvResponseToJson(IngvResponse instance) =>
    <String, dynamic>{
      'features': instance.features?.map((e) => e?.toJson())?.toList(),
      'type': instance.type,
      'error': instance.error,
    };
