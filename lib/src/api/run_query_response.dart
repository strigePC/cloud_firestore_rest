part of cloud_firestore_rest;

/// The response for [RestApi.runQuery].
@JsonSerializable()
class RunQueryResponse {
  /// The transaction that was started as part of this request. Can only be set
  /// in the first response, and only if [newTransaction] was set
  /// in the request. If set, no other fields will be set in this response.
  ///
  /// A base64-encoded string.
  final String transaction;

  /// A query result. Not set when reporting partial progress.
  final Document document;

  /// The time at which the document was read. This may be monotonically
  /// increasing; in this case, the previous documents in the result stream are
  /// guaranteed not to have changed between their readTime and this one.
  ///
  /// If the query returns no results, a response with readTime and no document
  /// will be sent, and this represents the time at which the query was run.
  ///
  /// A timestamp in RFC3339 UTC "Zulu" format, with nanosecond resolution and
  /// up to nine fractional digits. Examples: "2014-10-02T15:01:23Z" and
  /// "2014-10-02T15:01:23.045123456Z".
  @JsonKey(toJson: _Util.dateTimeToJson, fromJson: _Util.dateTimeFromJson)
  final DateTime readTime;

  /// The number of results that have been skipped due to an offset between the
  /// last response and the current response.
  final int skippedResults;

  RunQueryResponse(
      this.transaction, this.document, this.readTime, this.skippedResults);

  factory RunQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$RunQueryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RunQueryResponseToJson(this);
}
