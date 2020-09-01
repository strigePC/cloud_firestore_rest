part of cloud_firestore_rest;

@JsonSerializable()
class FieldReference {
  final String fieldPath;

  FieldReference(this.fieldPath);

  factory FieldReference.fromJson(Map<String, dynamic> json) =>
      _$FieldReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$FieldReferenceToJson(this);
}
