part of cloud_firestore_rest;

/// A precondition on a document, used for conditional operations.
@JsonSerializable()
class Precondition {
  /// When set to true, the target document must exist. When set to false, the
  /// target document must not exist.
  final bool exists;

  /// When set, the target document must exist and have been last updated at
  /// that time.
  ///
  /// A timestamp in RFC3339 UTC "Zulu" format, with nanosecond resolution and
  /// up to nine fractional digits. Examples: "2014-10-02T15:01:23Z" and
  /// "2014-10-02T15:01:23.045123456Z".
  final DateTime updateTime;

  Precondition({this.exists, this.updateTime})
      : assert(exists != null || updateTime != null,
            'At least one of the fields (exists, updateTime) should be set'),
        assert(exists == null || updateTime == null,
            'You should use either exists or updateTime, not both');

  factory Precondition.fromJson(Map<String, dynamic> json) =>
      _$PreconditionFromJson(json);

  Map<String, dynamic> toJson() => _$PreconditionToJson(this);
}
