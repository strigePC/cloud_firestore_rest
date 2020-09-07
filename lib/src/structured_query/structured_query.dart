part of cloud_firestore_rest;

/// A Firestore query.
@JsonSerializable()
class StructuredQuery {
  /// The projection to return.
  Projection select;

  /// The collections to query.
  List<CollectionSelector> from;

  /// The filter to apply.
  Filter where;

  /// The order to apply to the query results.
  ///
  /// Firestore guarantees a stable ordering through the following rules:
  ///
  /// - Any field required to appear in orderBy, that is not already specified in
  /// orderBy, is appended to the order in field name order by default.
  /// - If an order on __name__ is not specified, it is appended by default.
  /// Fields are appended with the same sort direction as the last order
  /// specified, or 'ASCENDING' if no order was specified. For example:
  ///
  /// - SELECT * FROM Foo ORDER BY A becomes SELECT * FROM Foo ORDER BY A, __name__
  /// - SELECT * FROM Foo ORDER BY A DESC becomes SELECT * FROM Foo ORDER BY A DESC, __name__ DESC
  /// - SELECT * FROM Foo WHERE A > 1 becomes SELECT * FROM Foo WHERE A > 1 ORDER BY A, __name__
  List<Order> orderBy;

  /// A starting point for the query results.
  Cursor startAt;

  /// A end point for the query results.
  Cursor endAt;

  /// The number of results to skip.
  ///
  /// Applies before limit, but after all other constraints. Must be >= 0 if
  /// specified.
  int offset;

  /// The maximum number of results to return.
  ///
  /// Applies after all other constraints. Must be >= 0 if specified.
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
