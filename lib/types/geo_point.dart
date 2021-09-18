part of cloud_firestore_rest;

class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint(this.latitude, this.longitude);

  double distanceTo(GeoPoint point) => _Util.calcDistance(this, point);

  @override
  String toString() {
    return '[${latitude.toStringAsFixed(3)}° N, ${longitude.toStringAsFixed(3)}° E]';
  }
}

@JsonSerializable()
class GeoFirePoint {
  @JsonKey(
    fromJson: GeoFirePoint._geoPointFromJson,
    toJson: GeoFirePoint._geoPointToJson,
  )
  final GeoPoint geopoint;
  final String geohash;

  GeoFirePoint(this.geopoint, this.geohash);

  GeoFirePoint.fromGeoPoint(this.geopoint)
      : geohash = _Util.encode(
          geopoint.latitude,
          geopoint.longitude,
          numberOfChars: 9,
        );

  factory GeoFirePoint.fromJson(Map<String, dynamic> json) =>
      _$GeoFirePointFromJson(json);

  Map<String, dynamic> toJson() => _$GeoFirePointToJson(this);

  static GeoPoint _geoPointFromJson(GeoPoint geo) => geo;

  static GeoPoint _geoPointToJson(GeoPoint geo) => geo;

  static GeoPoint? _geoPointFromJsonNullable(GeoPoint? geo) => geo;

  static Map<String, dynamic>? _geoPointToJsonNullable(GeoPoint? geo) =>
      geo != null ? GeoFirePoint.fromGeoPoint(geo).toJson() : null;
}
