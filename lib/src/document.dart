part of cloud_firestore_rest;

@JsonSerializable()
class Document {
  String name;
  Map<String, Value> fields;
  String createTime;
  String updateTime;
}