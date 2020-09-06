part of cloud_firestore_rest;

/// The response from [RestApi.batchWrite].
@JsonSerializable()
class BatchWriteResponse {
  /// The result of applying the writes.
  ///
  /// This i-th write result corresponds to the i-th write in the request.
  final List<WriteResult> writeResults;

  /// The status of applying the writes.
  ///
  /// This i-th write status corresponds to the i-th write in the request.
  final List<Status> status;

  BatchWriteResponse(this.writeResults, this.status);

  factory BatchWriteResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchWriteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchWriteResponseToJson(this);
}
