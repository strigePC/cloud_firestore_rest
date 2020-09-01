part of cloud_firestore_rest;

@JsonSerializable()
class Value {
  bool nullValue;
  bool booleanValue;
  String integerValue;
  double doubleValue;
  String timestampValue;
  String stringValue;
  String bytesValue;
  String referenceValue;
  GeoPoint geoPointValue;
  ArrayValue arrayValue;
  MapValue mapValue;

  Value();

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);
}

@JsonSerializable()
class ArrayValue {
  List<Value> values;

  ArrayValue();

  factory ArrayValue.fromJson(Map<String, dynamic> json) =>
      _$ArrayValueFromJson(json);

  Map<String, dynamic> toJson() => _$ArrayValueToJson(this);
}

@JsonSerializable()
class MapValue {
  Map<String, Value> fields;

  MapValue();

  factory MapValue.fromJson(Map<String, dynamic> json) =>
      _$MapValueFromJson(json);

  Map<String, dynamic> toJson() => _$MapValueToJson(this);
}
