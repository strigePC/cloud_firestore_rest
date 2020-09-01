part of cloud_firestore_rest;

@JsonSerializable()
class Cursor {
  final List<Value> values = [];
  bool before;

  Cursor();

  factory Cursor.fromJson(Map<String, dynamic> json) =>
      _$CursorFromJson(json);

  Map<String, dynamic> toJson() => _$CursorToJson(this);
}