part of cloud_firestore_rest;

@JsonSerializable()
class RunQueryResponse {
  final String transaction;
  final Document document;
  final DateTime readTime;
  final int skippedResults;

  RunQueryResponse(
      this.transaction, this.document, this.readTime, this.skippedResults)
      : assert(readTime == null || readTime.isUtc,
            'readTime should be in UTC format');

  factory RunQueryResponse.fromJson(Map<String, dynamic> json) {
    final result = _$RunQueryResponseFromJson(json);
    assert(result.readTime == null || result.readTime.isUtc,
        'readTime should be in UTC format');
    return result;
  }

  Map<String, dynamic> toJson() => _$RunQueryResponseToJson(this);
}
