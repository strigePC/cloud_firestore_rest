part of cloud_firestore_rest;

@JsonSerializable()
class GeoPoint {
  final double lat;
  final double lng;

  GeoPoint(this.lat, this.lng);

  factory GeoPoint.fromJson(Map<String, dynamic> json) =>
      _$GeoPointFromJson(json);

  Map<String, dynamic> toJson() => _$GeoPointToJson(this);
}