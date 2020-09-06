// GENERATED CODE - DO NOT MODIFY BY HAND

part of cloud_firestore_rest;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchWriteResponse _$BatchWriteResponseFromJson(Map<String, dynamic> json) {
  return BatchWriteResponse(
    (json['writeResults'] as List)
        ?.map((e) =>
            e == null ? null : WriteResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['status'] as List)
        ?.map((e) =>
            e == null ? null : Status.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BatchWriteResponseToJson(BatchWriteResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'writeResults', instance.writeResults?.map((e) => e?.toJson())?.toList());
  writeNotNull('status', instance.status?.map((e) => e?.toJson())?.toList());
  return val;
}

DocumentMask _$DocumentMaskFromJson(Map<String, dynamic> json) {
  return DocumentMask(
    (json['fieldPaths'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$DocumentMaskToJson(DocumentMask instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fieldPaths', instance.fieldPaths);
  return val;
}

DocumentTransform _$DocumentTransformFromJson(Map<String, dynamic> json) {
  return DocumentTransform(
    json['document'] as String,
    (json['fieldTransforms'] as List)
        ?.map((e) => e == null
            ? null
            : FieldTransform.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DocumentTransformToJson(DocumentTransform instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('document', instance.document);
  writeNotNull('fieldTransforms',
      instance.fieldTransforms?.map((e) => e?.toJson())?.toList());
  return val;
}

FieldTransform _$FieldTransformFromJson(Map<String, dynamic> json) {
  return FieldTransform(
    json['fieldPath'] as String,
    _$enumDecodeNullable(_$ServerValueEnumMap, json['setToServerValue']),
    json['increment'] == null
        ? null
        : Value.fromJson(json['increment'] as Map<String, dynamic>),
    json['maximum'] == null
        ? null
        : Value.fromJson(json['maximum'] as Map<String, dynamic>),
    json['minimum'] == null
        ? null
        : Value.fromJson(json['minimum'] as Map<String, dynamic>),
    json['appendMissingElements'] == null
        ? null
        : ArrayValue.fromJson(
            json['appendMissingElements'] as Map<String, dynamic>),
    json['removeAllFromArray'] == null
        ? null
        : ArrayValue.fromJson(
            json['removeAllFromArray'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FieldTransformToJson(FieldTransform instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fieldPath', instance.fieldPath);
  writeNotNull(
      'setToServerValue', _$ServerValueEnumMap[instance.setToServerValue]);
  writeNotNull('increment', instance.increment?.toJson());
  writeNotNull('maximum', instance.maximum?.toJson());
  writeNotNull('minimum', instance.minimum?.toJson());
  writeNotNull(
      'appendMissingElements', instance.appendMissingElements?.toJson());
  writeNotNull('removeAllFromArray', instance.removeAllFromArray?.toJson());
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ServerValueEnumMap = {
  ServerValue.serverValueUnspecified: 'serverValueUnspecified',
  ServerValue.requestTime: 'requestTime',
};

ListDocumentsResponse _$ListDocumentsResponseFromJson(
    Map<String, dynamic> json) {
  return ListDocumentsResponse(
    (json['documents'] as List)
        ?.map((e) =>
            e == null ? null : Document.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['nextPageToken'] as String,
  );
}

Map<String, dynamic> _$ListDocumentsResponseToJson(
    ListDocumentsResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'documents', instance.documents?.map((e) => e?.toJson())?.toList());
  writeNotNull('nextPageToken', instance.nextPageToken);
  return val;
}

Precondition _$PreconditionFromJson(Map<String, dynamic> json) {
  return Precondition(
    exists: json['exists'] as bool,
    updateTime: json['updateTime'] == null
        ? null
        : DateTime.parse(json['updateTime'] as String),
  );
}

Map<String, dynamic> _$PreconditionToJson(Precondition instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('exists', instance.exists);
  writeNotNull('updateTime', instance.updateTime?.toIso8601String());
  return val;
}

RunQueryResponse _$RunQueryResponseFromJson(Map<String, dynamic> json) {
  return RunQueryResponse(
    json['transaction'] as String,
    json['document'] == null
        ? null
        : Document.fromJson(json['document'] as Map<String, dynamic>),
    json['readTime'] == null
        ? null
        : DateTime.parse(json['readTime'] as String),
    json['skippedResults'] as int,
  );
}

Map<String, dynamic> _$RunQueryResponseToJson(RunQueryResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('transaction', instance.transaction);
  writeNotNull('document', instance.document?.toJson());
  writeNotNull('readTime', instance.readTime?.toIso8601String());
  writeNotNull('skippedResults', instance.skippedResults);
  return val;
}

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    json['code'] as int,
    json['message'] as String,
    (json['details'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
  );
}

Map<String, dynamic> _$StatusToJson(Status instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('message', instance.message);
  writeNotNull('details', instance.details);
  return val;
}

TransactionOptions _$TransactionOptionsFromJson(Map<String, dynamic> json) {
  return TransactionOptions(
    json['readOnly'] == null
        ? null
        : ReadOnly.fromJson(json['readOnly'] as Map<String, dynamic>),
    json['readWrite'] == null
        ? null
        : ReadWrite.fromJson(json['readWrite'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransactionOptionsToJson(TransactionOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('readOnly', instance.readOnly?.toJson());
  writeNotNull('readWrite', instance.readWrite?.toJson());
  return val;
}

ReadOnly _$ReadOnlyFromJson(Map<String, dynamic> json) {
  return ReadOnly(
    json['readTime'] as String,
  );
}

Map<String, dynamic> _$ReadOnlyToJson(ReadOnly instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('readTime', instance.readTime);
  return val;
}

ReadWrite _$ReadWriteFromJson(Map<String, dynamic> json) {
  return ReadWrite(
    json['retryTransaction'] as String,
  );
}

Map<String, dynamic> _$ReadWriteToJson(ReadWrite instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('retryTransaction', instance.retryTransaction);
  return val;
}

Write _$WriteFromJson(Map<String, dynamic> json) {
  return Write(
    updateMask: json['updateMask'] == null
        ? null
        : DocumentMask.fromJson(json['updateMask'] as Map<String, dynamic>),
    updateTransforms: (json['updateTransforms'] as List)
        ?.map((e) => e == null
            ? null
            : FieldTransform.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentDocument: json['currentDocument'] == null
        ? null
        : Precondition.fromJson(
            json['currentDocument'] as Map<String, dynamic>),
    update: json['update'] == null
        ? null
        : Document.fromJson(json['update'] as Map<String, dynamic>),
    delete: json['delete'] as String,
    transform: json['transform'] == null
        ? null
        : DocumentTransform.fromJson(json['transform'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WriteToJson(Write instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updateMask', instance.updateMask?.toJson());
  writeNotNull('updateTransforms',
      instance.updateTransforms?.map((e) => e?.toJson())?.toList());
  writeNotNull('currentDocument', instance.currentDocument?.toJson());
  writeNotNull('update', instance.update?.toJson());
  writeNotNull('delete', instance.delete);
  writeNotNull('transform', instance.transform?.toJson());
  return val;
}

WriteResult _$WriteResultFromJson(Map<String, dynamic> json) {
  return WriteResult(
    json['updateTime'] == null
        ? null
        : DateTime.parse(json['updateTime'] as String),
    (json['transformResults'] as List)
        ?.map(
            (e) => e == null ? null : Value.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WriteResultToJson(WriteResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updateTime', instance.updateTime?.toIso8601String());
  writeNotNull('transformResults',
      instance.transformResults?.map((e) => e?.toJson())?.toList());
  return val;
}

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document(
    name: json['name'] as String,
    fields: (json['fields'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Value.fromJson(e as Map<String, dynamic>)),
    ),
  )
    ..createTime = json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String)
    ..updateTime = json['updateTime'] == null
        ? null
        : DateTime.parse(json['updateTime'] as String);
}

Map<String, dynamic> _$DocumentToJson(Document instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull(
      'fields', instance.fields?.map((k, e) => MapEntry(k, e?.toJson())));
  writeNotNull('createTime', instance.createTime?.toIso8601String());
  writeNotNull('updateTime', instance.updateTime?.toIso8601String());
  return val;
}

CollectionSelector _$CollectionSelectorFromJson(Map<String, dynamic> json) {
  return CollectionSelector(
    json['collectionId'] as String,
    allDescendants: json['allDescendants'] as bool,
  );
}

Map<String, dynamic> _$CollectionSelectorToJson(CollectionSelector instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('collectionId', instance.collectionId);
  writeNotNull('allDescendants', instance.allDescendants);
  return val;
}

Cursor _$CursorFromJson(Map<String, dynamic> json) {
  return Cursor(
    (json['values'] as List)
        ?.map(
            (e) => e == null ? null : Value.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['before'] as bool,
  );
}

Map<String, dynamic> _$CursorToJson(Cursor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('values', instance.values?.map((e) => e?.toJson())?.toList());
  writeNotNull('before', instance.before);
  return val;
}

FieldReference _$FieldReferenceFromJson(Map<String, dynamic> json) {
  return FieldReference(
    json['fieldPath'] as String,
  );
}

Map<String, dynamic> _$FieldReferenceToJson(FieldReference instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fieldPath', instance.fieldPath);
  return val;
}

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return Filter(
    compositeFilter: json['compositeFilter'] == null
        ? null
        : CompositeFilter.fromJson(
            json['compositeFilter'] as Map<String, dynamic>),
    fieldFilter: json['fieldFilter'] == null
        ? null
        : FieldFilter.fromJson(json['fieldFilter'] as Map<String, dynamic>),
    unaryFilter: json['unaryFilter'] == null
        ? null
        : UnaryFilter.fromJson(json['unaryFilter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FilterToJson(Filter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('compositeFilter', instance.compositeFilter?.toJson());
  writeNotNull('fieldFilter', instance.fieldFilter?.toJson());
  writeNotNull('unaryFilter', instance.unaryFilter?.toJson());
  return val;
}

CompositeFilter _$CompositeFilterFromJson(Map<String, dynamic> json) {
  return CompositeFilter(
    _$enumDecodeNullable(_$CompositeOperatorEnumMap, json['op']),
    (json['filters'] as List)
        ?.map((e) =>
            e == null ? null : Filter.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CompositeFilterToJson(CompositeFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('op', _$CompositeOperatorEnumMap[instance.op]);
  writeNotNull('filters', instance.filters?.map((e) => e?.toJson())?.toList());
  return val;
}

const _$CompositeOperatorEnumMap = {
  CompositeOperator.operatorUnspecified: 'OPERATOR_UNSPECIFIED',
  CompositeOperator.and: 'AND',
};

FieldFilter _$FieldFilterFromJson(Map<String, dynamic> json) {
  return FieldFilter(
    json['field'] == null
        ? null
        : FieldReference.fromJson(json['field'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$FieldOperatorEnumMap, json['op']),
    json['value'] == null
        ? null
        : Value.fromJson(json['value'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FieldFilterToJson(FieldFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('field', instance.field?.toJson());
  writeNotNull('op', _$FieldOperatorEnumMap[instance.op]);
  writeNotNull('value', instance.value?.toJson());
  return val;
}

const _$FieldOperatorEnumMap = {
  FieldOperator.operatorUnspecified: 'OPERATOR_UNSPECIFIED',
  FieldOperator.lessThan: 'LESS_THAN',
  FieldOperator.lessThanOrEqual: 'LESS_THAN_OR_EQUAL',
  FieldOperator.greaterThan: 'GREATER_THAN',
  FieldOperator.greaterThanOrEqual: 'GREATER_THAN_OR_EQUAL',
  FieldOperator.equal: 'EQUAL',
  FieldOperator.arrayContains: 'ARRAY_CONTAINS',
  FieldOperator.inArray: 'IN',
  FieldOperator.arrayContainsAny: 'ARRAY_CONTAINS_ANY',
};

UnaryFilter _$UnaryFilterFromJson(Map<String, dynamic> json) {
  return UnaryFilter(
    json['field'] == null
        ? null
        : FieldReference.fromJson(json['field'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$UnaryOperatorEnumMap, json['op']),
  );
}

Map<String, dynamic> _$UnaryFilterToJson(UnaryFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('op', _$UnaryOperatorEnumMap[instance.op]);
  writeNotNull('field', instance.field?.toJson());
  return val;
}

const _$UnaryOperatorEnumMap = {
  UnaryOperator.operatorUnspecified: 'OPERATOR_UNSPECIFIED',
  UnaryOperator.isNan: 'IS_NAN',
  UnaryOperator.isNull: 'IS_NULL',
};

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['field'] == null
        ? null
        : FieldReference.fromJson(json['field'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$DirectionEnumMap, json['direction']),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('field', instance.field?.toJson());
  writeNotNull('direction', _$DirectionEnumMap[instance.direction]);
  return val;
}

const _$DirectionEnumMap = {
  Direction.directionUnspecified: 'DIRECTION_UNSPECIFIED',
  Direction.ascending: 'ASCENDING',
  Direction.descending: 'DESCENDING',
};

Projection _$ProjectionFromJson(Map<String, dynamic> json) {
  return Projection();
}

Map<String, dynamic> _$ProjectionToJson(Projection instance) =>
    <String, dynamic>{};

StructuredQuery _$StructuredQueryFromJson(Map<String, dynamic> json) {
  return StructuredQuery()
    ..select = json['select'] == null
        ? null
        : Projection.fromJson(json['select'] as Map<String, dynamic>)
    ..from = (json['from'] as List)
        ?.map((e) => e == null
            ? null
            : CollectionSelector.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..where = json['where'] == null
        ? null
        : Filter.fromJson(json['where'] as Map<String, dynamic>)
    ..orderBy = (json['orderBy'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..startAt = json['startAt'] == null
        ? null
        : Cursor.fromJson(json['startAt'] as Map<String, dynamic>)
    ..endAt = json['endAt'] == null
        ? null
        : Cursor.fromJson(json['endAt'] as Map<String, dynamic>)
    ..offset = json['offset'] as int
    ..limit = json['limit'] as int;
}

Map<String, dynamic> _$StructuredQueryToJson(StructuredQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('select', instance.select?.toJson());
  writeNotNull('from', instance.from?.map((e) => e?.toJson())?.toList());
  writeNotNull('where', instance.where?.toJson());
  writeNotNull('orderBy', instance.orderBy?.map((e) => e?.toJson())?.toList());
  writeNotNull('startAt', instance.startAt?.toJson());
  writeNotNull('endAt', instance.endAt?.toJson());
  writeNotNull('offset', instance.offset);
  writeNotNull('limit', instance.limit);
  return val;
}

Value _$ValueFromJson(Map<String, dynamic> json) {
  return Value(
    mapValue: json['mapValue'] == null
        ? null
        : MapValue.fromJson(json['mapValue'] as Map<String, dynamic>),
    arrayValue: json['arrayValue'] == null
        ? null
        : ArrayValue.fromJson(json['arrayValue'] as Map<String, dynamic>),
    bytesValue: json['bytesValue'] as String,
    timestampValue: json['timestampValue'] as String,
    integerValue: json['integerValue'] as String,
    doubleValue: (json['doubleValue'] as num)?.toDouble(),
    nullValue: json['nullValue'] as bool,
    booleanValue: json['booleanValue'] as bool,
    stringValue: json['stringValue'] as String,
    referenceValue: json['referenceValue'] as String,
    geoPointValue: json['geoPointValue'] == null
        ? null
        : GeoPoint.fromJson(json['geoPointValue'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ValueToJson(Value instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nullValue', instance.nullValue);
  writeNotNull('booleanValue', instance.booleanValue);
  writeNotNull('integerValue', instance.integerValue);
  writeNotNull('doubleValue', instance.doubleValue);
  writeNotNull('timestampValue', instance.timestampValue);
  writeNotNull('stringValue', instance.stringValue);
  writeNotNull('bytesValue', instance.bytesValue);
  writeNotNull('referenceValue', instance.referenceValue);
  writeNotNull('geoPointValue', instance.geoPointValue?.toJson());
  writeNotNull('arrayValue', instance.arrayValue?.toJson());
  writeNotNull('mapValue', instance.mapValue?.toJson());
  return val;
}

ArrayValue _$ArrayValueFromJson(Map<String, dynamic> json) {
  return ArrayValue(
    (json['values'] as List)
        ?.map(
            (e) => e == null ? null : Value.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ArrayValueToJson(ArrayValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('values', instance.values?.map((e) => e?.toJson())?.toList());
  return val;
}

MapValue _$MapValueFromJson(Map<String, dynamic> json) {
  return MapValue(
    (json['fields'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Value.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$MapValueToJson(MapValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'fields', instance.fields?.map((k, e) => MapEntry(k, e?.toJson())));
  return val;
}

GeoPoint _$GeoPointFromJson(Map<String, dynamic> json) {
  return GeoPoint(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$GeoPointToJson(GeoPoint instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  return val;
}
