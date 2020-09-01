part of cloud_firestore_rest;

@JsonSerializable()
class Filter {
  CompositeFilter compositeFilter;
  FieldFilter fieldFilter;
  UnaryFilter unaryFilter;

  Filter();

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}

@JsonSerializable()
class CompositeFilter {
  CompositeOperator op;
  final List<Filter> filters = [];

  CompositeFilter();

  factory CompositeFilter.fromJson(Map<String, dynamic> json) =>
      _$CompositeFilterFromJson(json);

  Map<String, dynamic> toJson() => _$CompositeFilterToJson(this);
}

@JsonSerializable()
class FieldFilter {
  FieldReference field;
  FieldOperator op;
  Value value;

  FieldFilter();

  factory FieldFilter.fromJson(Map<String, dynamic> json) =>
      _$FieldFilterFromJson(json);

  Map<String, dynamic> toJson() => _$FieldFilterToJson(this);
}

@JsonSerializable()
class UnaryFilter {
  UnaryOperator op;
  FieldReference field;

  UnaryFilter();

  factory UnaryFilter.fromJson(Map<String, dynamic> json) =>
      _$UnaryFilterFromJson(json);

  Map<String, dynamic> toJson() => _$UnaryFilterToJson(this);
}
