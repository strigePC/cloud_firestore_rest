part of cloud_firestore_rest;

/// The response for [RestApi.commit].
@JsonSerializable()
class CommitResponse {
  /// The result of applying the writes.
  ///
  /// This i-th write result corresponds to the i-th write in the request.
  final List<WriteResult>? writeResults;

  /// The time at which the commit occurred. Any read with an equal or greater
  /// readTime is guaranteed to see the effects of the commit.
  ///
  /// A timestamp in RFC3339 UTC "Zulu" format, with nanosecond resolution and
  /// up to nine fractional digits. Examples: "2014-10-02T15:01:23Z" and
  /// "2014-10-02T15:01:23.045123456Z".
  final String? commitTime;

  CommitResponse(this.writeResults, this.commitTime);

  factory CommitResponse.fromJson(Map<String, dynamic> json) =>
      _$CommitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommitResponseToJson(this);
}