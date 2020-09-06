part of cloud_firestore_rest;

/// The result of applying a write.
@JsonSerializable()
class WriteResult {
  /// The last update time of the document after applying the write. Not set
  /// after a delete.
  ///
  /// If the write did not actually change the document, this will be the
  /// previous updateTime.
  ///
  /// A timestamp in RFC3339 UTC "Zulu" format, with nanosecond resolution and
  /// up to nine fractional digits. Examples: "2014-10-02T15:01:23Z" and
  /// "2014-10-02T15:01:23.045123456Z".
  final DateTime updateTime;

  /// The results of applying each [FieldTransform],
  /// in the same order.
  final List<Value> transformResults;

  WriteResult(this.updateTime, this.transformResults);

  factory WriteResult.fromJson(Map<String, dynamic> json) =>
      _$WriteResultFromJson(json);

  Map<String, dynamic> toJson() => _$WriteResultToJson(this);
}
