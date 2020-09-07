part of cloud_firestore_rest;

/// A composite filter operator.
enum CompositeOperator {
  /// Unspecified. This value must not be used.
  @JsonValue('OPERATOR_UNSPECIFIED')
  operatorUnspecified,

  /// The results are required to satisfy each of the combined filters.
  @JsonValue('AND')
  and,
}

/// A field filter operator.
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

extension Checkers on FieldOperator {
  /// Returns whether the current operator is an inequality operator.
  bool isInequality() {
    final value = FieldOperator.values[index];
    return value == FieldOperator.lessThan ||
        value == FieldOperator.lessThanOrEqual ||
        value == FieldOperator.greaterThan ||
        value == FieldOperator.greaterThanOrEqual;
  }
}

/// A filter with a single operand.
enum UnaryOperator {
  @JsonValue('OPERATOR_UNSPECIFIED')
  operatorUnspecified,
  @JsonValue('IS_NAN')
  isNan,
  @JsonValue('IS_NULL')
  isNull,
}
