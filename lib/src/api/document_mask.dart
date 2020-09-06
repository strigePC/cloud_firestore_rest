part of cloud_firestore_rest;

/// A set of field paths on a document. Used to restrict a get or update
/// operation on a document to a subset of its fields. This is different from
/// standard field masks, as this is always scoped to a [Document], and takes in
/// account the dynamic nature of [Value].
@JsonSerializable()
class DocumentMask {
  /// The list of field paths in the mask. See [Document.fields] for a field
  /// path syntax reference.
  final List<String> fieldPaths;

  DocumentMask(this.fieldPaths) : assert(fieldPaths != null);

  factory DocumentMask.fromJson(Map<String, dynamic> json) =>
      _$DocumentMaskFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentMaskToJson(this);

  @override
  String toString() {
    return fieldPaths.toString();
  }
}
