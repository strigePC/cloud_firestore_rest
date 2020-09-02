part of cloud_firestore_rest;

@JsonSerializable()
class Document {
  String name;
  Map<String, Value> fields;
  DateTime createTime;
  DateTime updateTime;

  Document({this.name, this.fields});

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
