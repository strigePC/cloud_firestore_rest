part of cloud_firestore_rest;

@JsonSerializable()
class DocumentTransform {
  /// The name of the document to transform.
  final String document;

  /// The list of transformations to apply to the fields of the document, in
  /// order. This must not be empty.
  final List<FieldTransform> fieldTransforms;

  DocumentTransform(this.document, this.fieldTransforms)
      : assert(
            fieldTransforms.isNotEmpty, 'Field transforms must not be empty');

  factory DocumentTransform.fromJson(Map<String, dynamic> json) =>
      _$DocumentTransformFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentTransformToJson(this);
}
