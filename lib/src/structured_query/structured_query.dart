part of cloud_firestore_rest;

@JsonSerializable()
class StructuredQuery {
  Projection select;
  final List<CollectionSelector> from = [];
  Filter where;
  Order orderBy;
  Cursor startAt;
  Cursor endAt;
  int offset;
  int limit;

  StructuredQuery();

  factory StructuredQuery.fromJson(Map<String, dynamic> json) =>
      _$StructuredQueryFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredQueryToJson(this);
}
