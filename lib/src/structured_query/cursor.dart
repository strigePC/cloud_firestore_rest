part of cloud_firestore_rest;

/// A position in a query result set.
@JsonSerializable()
class Cursor {
  /// The values that represent a position, in the order they appear in the
  /// order by clause of a query.
  ///
  /// Can contain fewer values than specified in the order by clause.
  final List<Value> values;

  /// If the position is just before or just after the given values, relative to
  /// the sort order defined by the query.
  final bool before;

  Cursor(this.values, this.before);

  factory Cursor.fromJson(Map<String, dynamic> json) => _$CursorFromJson(json);

  Map<String, dynamic> toJson() => _$CursorToJson(this);
}
