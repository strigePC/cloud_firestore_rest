part of cloud_firestore_rest;

/// The projection of document's fields to return.
@JsonSerializable()
class Projection {
  /// The fields to return.
  ///
  /// If empty, all fields are returned. To only return the name of the
  /// document, use ['__name__'].
  final List<FieldReference> fields;

  Projection(this.fields);

  factory Projection.fromJson(Map<String, dynamic> json) =>
      _$ProjectionFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectionToJson(this);
}
