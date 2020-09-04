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
