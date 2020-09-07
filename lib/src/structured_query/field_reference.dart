part of cloud_firestore_rest;

/// A reference to a field, such as max(messages.time) as max_time.
@JsonSerializable()
class FieldReference {
  final String fieldPath;

  FieldReference(this.fieldPath) : assert(fieldPath != null);

  factory FieldReference.fromJson(Map<String, dynamic> json) =>
      _$FieldReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$FieldReferenceToJson(this);

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  @override
  int get hashCode => fieldPath.hashCode;

  @override
  String toString() => fieldPath;
}
