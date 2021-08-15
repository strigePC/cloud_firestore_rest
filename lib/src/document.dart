part of cloud_firestore_rest;

/// A Firestore document.
///
/// Must not exceed 1 MiB - 4 bytes.
@JsonSerializable()
class Document {
  /// The resource name of the document, for example
  /// projects/{project_id}/databases/{database_id}/documents/{document_path}.
  String? name;

  /// The document's fields.
  ///
  /// The map keys represent field names.
  ///
  /// A simple field name contains only characters a to z, A to Z, 0 to 9, or _,
  /// and must not start with 0 to 9. For example, foo_bar_17.
  ///
  /// Field names matching the regular expression __.*__ are reserved. Reserved
  /// field names are forbidden except in certain documented contexts. The map
  /// keys, represented as UTF-8, must not exceed 1,500 bytes and cannot be
  /// empty.
  ///
  /// Field paths may be used in other contexts to refer to structured fields
  /// defined here. For mapValue, the field path is represented by the simple or
  /// quoted field names of the containing fields, delimited by .. For example,
  /// the structured field
  /// "foo" : { mapValue: { "x&y" : { stringValue: "hello" }}}
  /// would be represented by the field path foo.x&y.
  ///
  /// Within a field path, a quoted field name starts and ends with ` and may
  /// contain any character. Some characters, including `, must be escaped
  /// using a \. For example, `x&y` represents x&y and `bak\`tik` represents
  /// bak`tik.
  ///
  /// An object containing a list of "key": value pairs. Example:
  /// { "name": "wrench", "mass": "1.3kg", "count": "3" }.
  Map<String, Value>? fields;

  /// Output only. The time at which the document was created.
  ///
  /// This value increases monotonically when a document is deleted then
  /// recreated. It can also be compared to values from other documents and the
  /// readTime of a query.
  ///
  /// A timestamp in RFC3339 UTC "Zulu" format, with nanosecond resolution and
  /// up to nine fractional digits. Examples: "2014-10-02T15:01:23Z" and
  /// "2014-10-02T15:01:23.045123456Z".
  @JsonKey(toJson: _Util.dateTimeToJson, fromJson: _Util.dateTimeFromJson)
  final DateTime? createTime;

  /// Output only. The time at which the document was last changed.
  ///
  /// This value is initially set to the createTime then increases monotonically
  /// with each change to the document. It can also be compared to values from
  /// other documents and the readTime of a query.
  ///
  /// A timestamp in RFC3339 UTC "Zulu" format, with nanosecond resolution and
  /// up to nine fractional digits. Examples: "2014-10-02T15:01:23Z" and
  /// "2014-10-02T15:01:23.045123456Z".
  @JsonKey(toJson: _Util.dateTimeToJson, fromJson: _Util.dateTimeFromJson)
  final DateTime? updateTime;

  Document({this.name, this.fields, this.createTime, this.updateTime});

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
