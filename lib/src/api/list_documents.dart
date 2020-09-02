part of cloud_firestore_rest;

@JsonSerializable()
class ListDocuments {
  final List<Document> documents;
  final String nextPageToken;

  ListDocuments(this.documents, this.nextPageToken);

  factory ListDocuments.fromJson(Map<String, dynamic> json) =>
      _$ListDocumentsFromJson(json);

  Map<String, dynamic> toJson() => _$ListDocumentsToJson(this);
}