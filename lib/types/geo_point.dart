part of cloud_firestore_rest;

@JsonSerializable()
class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint(this.latitude, this.longitude);

  factory GeoPoint.fromJson(Map<String, dynamic> json) =>
      _$GeoPointFromJson(json);

  Map<String, dynamic> toJson() => _$GeoPointToJson(this);

  @override
  String toString() {
    return '[${latitude.toStringAsFixed(3)}° N, ${longitude.toStringAsFixed(3)}° E]';
  }
}

@JsonSerializable()
class GeoFirePoint {
  final GeoPoint geopoint;
  final String geohash;

  GeoFirePoint(this.geopoint, this.geohash);

  GeoFirePoint.fromGeoPoint(this.geopoint)
      : geohash = Util.encode(
          geopoint.latitude,
          geopoint.longitude,
          numberOfChars: 9,
        );

  factory GeoFirePoint.fromJson(Map<String, dynamic> json) =>
      _$GeoFirePointFromJson(json);

  Map<String, dynamic> toJson() => _$GeoFirePointToJson(this);
}
