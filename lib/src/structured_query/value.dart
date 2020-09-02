part of cloud_firestore_rest;

@JsonSerializable()
class Value {
  final bool nullValue;
  final bool booleanValue;
  final String integerValue;
  final double doubleValue;
  final String timestampValue;
  final String stringValue;
  final String bytesValue;
  final String referenceValue;
  final GeoPoint geoPointValue;
  final ArrayValue arrayValue;
  final MapValue mapValue;

  Value({
    this.mapValue,
    this.arrayValue,
    this.bytesValue,
    this.timestampValue,
    this.integerValue,
    this.doubleValue,
    this.nullValue,
    this.booleanValue,
    this.stringValue,
    this.referenceValue,
    this.geoPointValue,
  });

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
