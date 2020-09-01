part of cloud_firestore_rest;

class Filter {
  CompositeFilter compositeFilter;
  FieldFilter fieldFilter;
  UnaryFilter unaryFilter;
}

class CompositeFilter {
  CompositeOperator op;
  final List<Filter> filters = [];
}

class FieldFilter {
  FieldReference field;
  FieldOperator op;
  Value value;
}

class UnaryFilter {
  UnaryOperator op;
  FieldReference field;
}