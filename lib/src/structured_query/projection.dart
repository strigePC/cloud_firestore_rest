part of cloud_firestore_rest;

@JsonSerializable()
class Projection {
  final List<FieldReference> fields;

  Projection(this.fields);

  factory Projection.fromJson(Map<String, dynamic> json) =>
      _$ProjectionFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectionToJson(this);
}