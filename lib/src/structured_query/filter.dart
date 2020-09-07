part of cloud_firestore_rest;

/// A wrapper class for [UnaryFilter] and [FieldFilter]
abstract class SingularFieldFilter {
  FieldReference field;
}

/// A filter.
@JsonSerializable()
class Filter {
  /// A composite filter.
  final CompositeFilter compositeFilter;

  /// A filter on a document field.
  final FieldFilter fieldFilter;

  /// A filter that takes exactly one argument.
  final UnaryFilter unaryFilter;

  Filter({this.compositeFilter, this.fieldFilter, this.unaryFilter})
      : assert(
          (compositeFilter != null) ^
              (fieldFilter != null) ^
              (unaryFilter != null),
          'You must specify exactly one filter',
        );

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}

/// A filter that merges multiple other filters using the given operator.
@JsonSerializable()
class CompositeFilter {
  /// The operator for combining multiple filters.
  final CompositeOperator op;

  /// The list of filters to combine. Must contain at least one filter.
  final List<Filter> filters;

  CompositeFilter(this.op, this.filters)
      : assert(op != null),
        assert(op != CompositeOperator.operatorUnspecified),
        assert(filters != null),
        assert(filters.isNotEmpty);

  CompositeFilter.and(this.filters)
      : op = CompositeOperator.and,
        assert(filters != null),
        assert(filters.isNotEmpty);

  factory CompositeFilter.fromJson(Map<String, dynamic> json) =>
      _$CompositeFilterFromJson(json);

  Map<String, dynamic> toJson() => _$CompositeFilterToJson(this);
}

/// A filter on a specific field.
@JsonSerializable()
class FieldFilter extends SingularFieldFilter {
  /// The field to filter by.
  final FieldReference field;

  /// The operator to filter by.
  final FieldOperator op;

  /// The value to compare to.
  final Value value;

  FieldFilter(this.field, this.op, this.value)
      : assert(field != null),
        assert(op != null),
        assert(op != FieldOperator.operatorUnspecified),
        assert(value != null);

  factory FieldFilter.fromJson(Map<String, dynamic> json) =>
      _$FieldFilterFromJson(json);

  Map<String, dynamic> toJson() => _$FieldFilterToJson(this);

  @override
  bool operator ==(Object other) {
    return other is FieldFilter && (other.field == field && other.op == op);
  }

  @override
  int get hashCode => op.hashCode * field.hashCode * value.hashCode;

  @override
  String toString() {
    final result = StringBuffer(field);

    switch (op) {
      case FieldOperator.lessThan:
        result.write(' < ');
        break;
      case FieldOperator.lessThanOrEqual:
        result.write(' <= ');
        break;
      case FieldOperator.greaterThan:
        result.write(' > ');
        break;
      case FieldOperator.greaterThanOrEqual:
        result.write(' >= ');
        break;
      case FieldOperator.equal:
        result.write(' == ');
        break;
      case FieldOperator.arrayContains:
        result.write(' contains ');
        break;
      case FieldOperator.inArray:
        result.write(' in ');
        break;
      case FieldOperator.arrayContainsAny:
        result.write(' contains any of ');
        break;
      case FieldOperator.operatorUnspecified:
        break;
    }

    result.write(value);

    return result.toString();
  }
}

/// A filter with a single operand.
@JsonSerializable()
class UnaryFilter extends SingularFieldFilter {
  /// The unary operator to apply.
  final UnaryOperator op;

  /// The field to which to apply the operator.
  final FieldReference field;

  UnaryFilter(this.field, this.op);

  factory UnaryFilter.fromJson(Map<String, dynamic> json) =>
      _$UnaryFilterFromJson(json);

  Map<String, dynamic> toJson() => _$UnaryFilterToJson(this);

  @override
  bool operator ==(Object other) {
    return other is UnaryFilter && (other.field == field && other.op == op);
  }

  @override
  int get hashCode => op.hashCode * field.hashCode;
}
