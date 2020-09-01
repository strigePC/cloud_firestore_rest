part of cloud_firestore_rest;

@JsonSerializable()
class GeoPoint {
  double lat;
  double lng;

  GeoPoint();

  factory GeoPoint.fromJson(Map<String, dynamic> json) =>
      _$GeoPointFromJson(json);

  Map<String, dynamic> toJson() => _$GeoPointToJson(this);
}