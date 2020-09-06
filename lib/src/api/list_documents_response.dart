part of cloud_firestore_rest;

/// The response for [RestApi.list].
@JsonSerializable()
class ListDocumentsResponse {
  /// The Documents found.
  final List<Document> documents;

  /// The next page token.
  final String nextPageToken;

  ListDocumentsResponse(this.documents, this.nextPageToken);

  factory ListDocumentsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListDocumentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListDocumentsResponseToJson(this);
}