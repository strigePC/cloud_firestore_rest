part of cloud_firestore_rest;

@JsonSerializable()
class StructuredQuery {
  Projection select;
  List<CollectionSelector> from;
  Filter where;
  List<Order> orderBy;
  Cursor startAt;
  Cursor endAt;
  int offset;
  int limit;

  StructuredQuery();

  factory StructuredQuery.fromJson(Map<String, dynamic> json) =>
      _$StructuredQueryFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
