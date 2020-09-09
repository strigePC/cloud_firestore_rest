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
  }) : assert(
          (mapValue != null) ^
              (arrayValue != null) ^
              (bytesValue != null) ^
              (timestampValue != null) ^
              (integerValue != null) ^
              (doubleValue != null) ^
              (nullValue != null) ^
              (booleanValue != null) ^
              (stringValue != null) ^
              (referenceValue != null) ^
              (geoPointValue != null),
          'Only one of the values can be set for Value',
        );

  factory Value.fromValue(dynamic value) {
    if (value == null) return Value(nullValue: true);
    if (value is String) return Value(stringValue: value);
    if (value is int) return Value(integerValue: value.toString());
    if (value is bool) return Value(booleanValue: value);
    if (value is double) return Value(doubleValue: value);
    if (value is DateTime)
      return Value(timestampValue: value.toUtc().toIso8601String());
    if (value is GeoPoint) return Value(geoPointValue: value);
    if (value is List) return Value(arrayValue: ArrayValue.fromList(value));
    if (value is Map<String, dynamic>)
      return Value(mapValue: MapValue.fromMap(value));
    if (value is Uint64List) return Value(bytesValue: base64Encode(value));
    if (value is DocumentReference) {
      return Value(
        referenceValue: 'projects/${value._firestore.app.options.projectId}'
            '/databases/(default)'
            '/documents/${value.path}',
      );
    }
    if (value is CollectionReference) {
      return Value(
        referenceValue: 'projects/${value._firestore.app.options.projectId}'
            '/databases/(default)'
            '/documents/${value.path}',
      );
    }

    throw FormatException('The type is unsupported. '
        'Value should be one of these: String, int, bool, double, DateTime, '
        'GeoPoint, List, Map<String, dynamic>, Uint64List, DocumentReference, '
        'CollectionReference');
  }

  dynamic get decode {
    if (nullValue != null) return null;
    if (stringValue != null) return stringValue;
    if (integerValue != null) return int.parse(integerValue);
    if (booleanValue != null) return booleanValue;
    if (doubleValue != null) return doubleValue;
    if (timestampValue != null) return DateTime.parse(timestampValue);
    if (geoPointValue != null) return geoPointValue;
    if (arrayValue != null) return arrayValue.decode;
    if (mapValue != null) return mapValue.decode;
    if (bytesValue != null) return base64Decode(bytesValue);
  }

  factory Value.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('nullValue')) json['nullValue'] = true;
    return _$ValueFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ValueToJson(this);

  @override
  String toString() {
    return decode.toString();
  }
}

@JsonSerializable()
class ArrayValue {
  final List<Value> values;

  ArrayValue(this.values);

  factory ArrayValue.fromList(List<dynamic> list) {
    final values = <Value>[];
    for (final element in list) {
      values.add(Value.fromValue(element));
    }

    return ArrayValue(values);
  }

  List<dynamic> get decode =>
      (values ?? []).map((value) => value.decode).toList();

  factory ArrayValue.fromJson(Map<String, dynamic> json) =>
      _$ArrayValueFromJson(json);

  Map<String, dynamic> toJson() => _$ArrayValueToJson(this);

  @override
  String toString() {
    return decode.toString();
  }
}

@JsonSerializable()
class MapValue {
  final Map<String, Value> fields;

  MapValue(this.fields);

  factory MapValue.fromMap(Map<String, dynamic> map) {
    final fields = <String, Value>{};
    map.entries.forEach((element) {
      fields[element.key] = Value.fromValue(element.value);
    });

    return MapValue(fields);
  }

  Map<String, dynamic> get decode =>
      (fields ?? {}).map((key, value) => MapEntry(key, value.decode));

  factory MapValue.fromJson(Map<String, dynamic> json) =>
      _$MapValueFromJson(json);

  Map<String, dynamic> toJson() => _$MapValueToJson(this);

  @override
  String toString() {
    return decode.toString();
  }
}
