part of cloud_firestore_rest;

enum CompositeOperator {
  operatorUnspecified,
  and,
}

enum FieldOperator {
  operatorUnspecified,
  lessThan,
  lessThanOrEqual,
  greaterThan,
  greaterThanOrEqual,
  equal,
  arrayContains,
  inArray,
  arrayContainsAny,
}

enum UnaryOperator {
  operatorUnspecified,
  isNan,
  isNull,
}