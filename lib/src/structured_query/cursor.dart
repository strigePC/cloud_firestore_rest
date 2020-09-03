part of cloud_firestore_rest;

@JsonSerializable()
class Cursor {
  final List<Value> values;
  final bool before;

  Cursor(this.values, this.before)
      : assert(values != null),
        assert(before != null);

  factory Cursor.fromJson(Map<String, dynamic> json) => _$CursorFromJson(json);

  Map<String, dynamic> toJson() => _$CursorToJson(this);
}
