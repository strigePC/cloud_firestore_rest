part of cloud_firestore_rest;

class Value {
  bool nullValue;
  bool booleanValue;
  String integerValue;
  double doubleValue;
  String timestampValue;
  String stringValue;
  String bytesValue;
  String referenceValue;
  dynamic geoPointValue;
  ArrayValue arrayValue;
  MapValue mapValue;
}

class ArrayValue {
  List<Value> values;
}

class MapValue {
  Map<String, Value> fields;
}