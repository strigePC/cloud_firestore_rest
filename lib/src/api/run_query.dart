part of cloud_firestore_rest;

@JsonSerializable()
class RunQuery {
  final String transaction;
  final Document document;
  final DateTime readTime;
  final int skippedResults;

  RunQuery(this.transaction, this.document, this.readTime, this.skippedResults);

  factory RunQuery.fromJson(Map<String, dynamic> json) =>
      _$RunQueryFromJson(json);

  Map<String, dynamic> toJson() => _$RunQueryToJson(this);
}