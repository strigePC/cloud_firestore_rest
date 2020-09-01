part of cloud_firestore_rest;

enum CompositeOperator {
  @JsonValue('OPERATOR_UNSPECIFIED')
  operatorUnspecified,
  @JsonValue('AND')
  and,
}

enum FieldOperator {
  @JsonValue('OPERATOR_UNSPECIFIED')
  operatorUnspecified,
  @JsonValue('LESS_THAN')
  lessThan,
  @JsonValue('LESS_THAN_OR_EQUAL')
  lessThanOrEqual,
  @JsonValue('GREATER_THAN')
  greaterThan,
  @JsonValue('GREATER_THAN_OR_EQUAL')
  greaterThanOrEqual,
  @JsonValue('EQUAL')
  equal,
  @JsonValue('ARRAY_CONTAINS')
  arrayContains,
  @JsonValue('IN')
  inArray,
  @JsonValue('ARRAY_CONTAINS_ANY')
  arrayContainsAny,
}

enum UnaryOperator {
  @JsonValue('OPERATOR_UNSPECIFIED')
  operatorUnspecified,
  @JsonValue('IS_NAN')
  isNan,
  @JsonValue('IS_NULL')
  isNull,
}
