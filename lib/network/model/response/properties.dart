import 'package:json_annotation/json_annotation.dart';

part 'properties.g.dart';

@JsonSerializable(explicitToJson: true)
class Properties {
  String author;
  int eventId;
  String geojsonCreationTime;
  double mag;
  String magAuthor;
  String magType;
  int originId;
  String place;
  String time;
  String type;
  int version;

  Properties(
      {this.type,
      this.author,
      this.eventId,
      this.geojsonCreationTime,
      this.mag,
      this.magAuthor,
      this.magType,
      this.originId,
      this.place,
      this.time,
      this.version});

  factory Properties.fromJson(Map<String, dynamic> json) => _$PropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}
