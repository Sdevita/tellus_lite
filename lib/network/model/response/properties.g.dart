// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Properties _$PropertiesFromJson(Map<String, dynamic> json) {
  return Properties(
    type: json['type'] as String,
    author: json['author'] as String,
    eventId: json['eventId'] as int,
    geojsonCreationTime: json['geojsonCreationTime'] as String,
    mag: (json['mag'] as num)?.toDouble(),
    magAuthor: json['magAuthor'] as String,
    magType: json['magType'] as String,
    originId: json['originId'] as int,
    place: json['place'] as String,
    time: json['time'] as String,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$PropertiesToJson(Properties instance) =>
    <String, dynamic>{
      'author': instance.author,
      'eventId': instance.eventId,
      'geojsonCreationTime': instance.geojsonCreationTime,
      'mag': instance.mag,
      'magAuthor': instance.magAuthor,
      'magType': instance.magType,
      'originId': instance.originId,
      'place': instance.place,
      'time': instance.time,
      'type': instance.type,
      'version': instance.version,
    };
