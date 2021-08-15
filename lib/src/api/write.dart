part of cloud_firestore_rest;

/// A write on a document.
@JsonSerializable()
class Write {
  /// The fields to update in this write.
  ///
  /// This field can be set only when the operation is [update]. If the mask is
  /// not set for an [update] and the document exists, any existing data will be
  /// overwritten. If the mask is set and the document on the server has fields
  /// not covered by the mask, they are left unchanged. Fields referenced in the
  /// mask, but not present in the input document, are deleted from the document
  /// on the server. The field paths in this mask must not contain a reserved
  /// field name.
  final DocumentMask? updateMask;

  /// The transforms to perform after update.
  ///
  /// This field can be set only when the operation is [update]. If present,
  /// this write is equivalent to performing update and transform to the same
  /// document atomically and in order.
  final List<FieldTransform>? updateTransforms;

  /// An optional precondition on the document.
  ///
  /// The write will fail if this is set and not met by the target document.
  final Precondition? currentDocument;

  /// A document to write.
  final Document? update;

  /// A document name to delete. In the format:
  /// projects/{project_id}/databases/{database_id}/documents/{document_path}.
  final String? delete;

  /// Applies a transformation to a document.
  final DocumentTransform? transform;

  Write({
    this.updateMask,
    this.updateTransforms,
    this.currentDocument,
    this.update,
    this.delete,
    this.transform,
  }) : assert(
          (update != null) ^ (delete != null) ^ (transform != null),
          'You can set only one of the parameters (update, delete, or transform)',
        );

  factory Write.fromJson(Map<String, dynamic> json) => _$WriteFromJson(json);

  Map<String, dynamic> toJson() => _$WriteToJson(this);
}
