part of cloud_firestore_rest;

@JsonSerializable()
class RunQueryResponse {
  final String transaction;
  final Document document;
  final DateTime readTime;
  final int skippedResults;

  RunQueryResponse(this.transaction, this.document, this.readTime, this.skippedResults);

  factory RunQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$RunQueryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RunQueryResponseToJson(this);
}