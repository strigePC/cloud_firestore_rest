part of cloud_firestore_rest;

abstract class SingularFieldFilter {
  FieldReference field;
}

@JsonSerializable()
class Filter {
  final CompositeFilter compositeFilter;
  final FieldFilter fieldFilter;
  final UnaryFilter unaryFilter;

  Filter({this.compositeFilter, this.fieldFilter, this.unaryFilter});

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}

@JsonSerializable()
class CompositeFilter {
  final CompositeOperator op;
  final List<Filter> filters;

  CompositeFilter(this.op, this.filters);

  factory CompositeFilter.fromJson(Map<String, dynamic> json) =>
      _$CompositeFilterFromJson(json);

  Map<String, dynamic> toJson() => _$CompositeFilterToJson(this);
}

@JsonSerializable()
class FieldFilter extends SingularFieldFilter {
  final FieldReference field;
  final FieldOperator op;
  final Value value;

  FieldFilter(this.field, this.op, this.value);

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

@JsonSerializable()
class UnaryFilter extends SingularFieldFilter {
  final UnaryOperator op;
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
