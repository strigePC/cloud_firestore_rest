part of cloud_firestore_rest;

class Query {
  /// The [FirebaseFirestore] instance of this query.
  final FirebaseFirestore firestore;
  final StructuredQuery structuredQuery = StructuredQuery();

  Query._(this.firestore);

  /// Returns whether the current query has a "start" cursor query.
  bool _hasStartCursor() {
    // return parameters['startAt'] != null || parameters['startAfter'] != null;

    //  TODO: implement _hasStartCursor()
    throw UnimplementedError();
  }

  /// Returns whether the current query has a "end" cursor query.
  bool _hasEndCursor() {
    // return parameters['endAt'] != null || parameters['endBefore'] != null;
    //  TODO: implement _hasStartCursor()
    throw UnimplementedError();
  }

  /// Asserts that a [DocumentSnapshot] can be used within the current
  /// query.
  ///
  /// Since a native DocumentSnapshot cannot be created without additional
  /// database calls, any ordered values are extracted from the document and
  /// passed to the query.
  Map<String, dynamic> _assertQueryCursorSnapshot(
      DocumentSnapshot documentSnapshot) {
    assert(documentSnapshot != null);
    assert(documentSnapshot.exists,
        "a document snapshot must exist to be used within a query");

    // List<List<dynamic>> orders = List.from(parameters['orderBy']);
    // List<dynamic> values = [];
    //
    // for (List<dynamic> order in orders) {
    //   dynamic field = order[0];
    //
    //   // All order by fields must exist within the snapshot
    //   if (field != FieldPath.documentId) {
    //     try {
    //       values.add(documentSnapshot.get(field));
    //     } on StateError {
    //       throw ("You are trying to start or end a query using a document for which the field '$field' (used as the orderBy) does not exist.");
    //     }
    //   }
    // }
    //
    // // Any time you construct a query and don't include 'name' in the orderBys,
    // // Firestore will implicitly assume an additional .orderBy('__name__', DIRECTION)
    // // where DIRECTION will match the last orderBy direction of your query (or 'asc' if you have no orderBys).
    // if (orders.isNotEmpty) {
    //   List<dynamic> lastOrder = orders.last;
    //
    //   if (lastOrder[0] != FieldPath.documentId) {
    //     orders.add([FieldPath.documentId, lastOrder[1]]);
    //   }
    // } else {
    //   orders.add([FieldPath.documentId, false]);
    // }
    //
    // if (_delegate.isCollectionGroupQuery) {
    //   values.add(documentSnapshot.reference.path);
    // } else {
    //   values.add(documentSnapshot.id);
    // }
    //
    // return <String, dynamic>{
    //   'orders': orders,
    //   'values': values,
    // };

    //  TODO: implement _assertQueryCursorSnapshot()
    throw UnimplementedError();
  }

  /// Common handler for all non-document based cursor queries.
  void _assertQueryCursorValues(List<dynamic> fields) {
    assert(
      structuredQuery.orderBy != null,
      'orderBy() method should be called before setting cursors',
    );
    assert(fields != null);

    assert(
      fields.length <= structuredQuery.orderBy.length,
      "Too many arguments provided. "
      "The number of arguments must be less than or equal to the number of "
      "orderBy() clauses.",
    );
  }

  /// Asserts that the query [field] is either a String or a [FieldPath].
  void _assertValidFieldType(String field) {
    // assert(
    // field is String || field is FieldPath || field == FieldPath.documentId,
    // 'Supported [field] types are [String] and [FieldPath].');

    //  TODO: implement _assertValidFieldType()
    throw UnimplementedError();
  }

  /// Creates and returns a new [Query] that ends at the provided document
  /// (inclusive). The end position is relative to the order of the query.
  /// The document must contain all of the fields provided in the orderBy of
  /// this query.
  ///
  /// Cannot be used in combination with [endBefore], [endBeforeDocument], or
  /// [endAt], but can be used in combination with [startAt],
  /// [startAfter], [startAtDocument] and [startAfterDocument].
  ///
  /// See also:
  ///
  ///  * [startAfterDocument] for a query that starts after a document.
  ///  * [startAtDocument] for a query that starts at a document.
  ///  * [endBeforeDocument] for a query that ends before a document.
  Query endAtDocument(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> results = _assertQueryCursorSnapshot(documentSnapshot);
    // return Query._(firestore,
    //     _delegate.endAtDocument(results['orders'], results['values']));

    //  TODO: implement endAtDocument()
    throw UnimplementedError();
  }

  /// Takes a list of [values], creates and returns a new [Query] that ends at the
  /// provided fields relative to the order of the query.
  ///
  /// The [values] must be in order of [orderBy] filters.
  ///
  /// Calling this method will replace any existing cursor "end" query modifiers.
  void endAt(List<dynamic> values) {
    _assertQueryCursorValues(values);
    structuredQuery.endAt = Cursor(
      values.map((value) => Value.fromValue(value)).toList(),
      false,
    );
  }

  /// Creates and returns a new [Query] that ends before the provided document
  /// snapshot (exclusive). The end position is relative to the order of the query.
  /// The document must contain all of the fields provided in the orderBy of
  /// this query.
  ///
  /// Calling this method will replace any existing cursor "end" query modifiers.
  Query endBeforeDocument(DocumentSnapshot documentSnapshot) {
    // Map<String, dynamic> results = _assertQueryCursorSnapshot(documentSnapshot);
    // return Query._(firestore,
    //     _delegate.endBeforeDocument(results['orders'], results['values']));

    //  TODO: implement endBeforeDocument()
    throw UnimplementedError();
  }

  /// Takes a list of [values], creates and returns a new [Query] that ends before
  /// the provided fields relative to the order of the query.
  ///
  /// The [values] must be in order of [orderBy] filters.
  ///
  /// Calling this method will replace any existing cursor "end" query modifiers.
  void endBefore(List<dynamic> values) {
    _assertQueryCursorValues(values);
    structuredQuery.endAt = Cursor(
      values.map((value) => Value.fromValue(value)).toList(),
      true,
    );
  }

  /// Fetch the documents for this query.
  ///
  /// To modify how the query is fetched, the [options] parameter can be provided
  /// with a [GetOptions] instance.
  Future<QuerySnapshot> get(/*[GetOptions options]*/) async {
    // QuerySnapshotPlatform snapshotDelegate =
    // await _delegate.get(options ?? const GetOptions());
    // return QuerySnapshot._(firestore, snapshotDelegate);

    //  TODO: implement get()
    throw UnimplementedError();
  }

  /// Creates and returns a new Query that's additionally limited to only return up
  /// to the specified number of documents.
  void limit(int limit) {
    assert(limit > 0, "limit must be a positive number greater than 0");
    structuredQuery.limit = limit;
  }

  /// Creates and returns a new Query that only returns the last matching documents.
  ///
  /// You must specify at least one orderBy clause for limitToLast queries,
  /// otherwise an exception will be thrown during execution.
  void limitToLast(int limit) {
    assert(limit > 0, "limit must be a positive number greater than 0");
    assert(
      structuredQuery.orderBy != null && structuredQuery.orderBy.isNotEmpty,
      "limitToLast() queries require specifying at least one orderBy() clause",
    );

    structuredQuery.orderBy = structuredQuery.orderBy
        .map((order) => Order(
              order.field,
              order.direction == Direction.ascending
                  ? Direction.descending
                  : Direction.ascending,
            ))
        .toList();
    structuredQuery.limit = limit;
  }

  /// Notifies of query results at this location.
  // Stream<QuerySnapshot> snapshots({bool includeMetadataChanges = false}) =>
  //     _delegate
  //         .snapshots(includeMetadataChanges: includeMetadataChanges)
  //         .map((item) {
  //       return QuerySnapshot._(firestore, item);
  //     });

  /// Creates and returns a new [Query] that's additionally sorted by the specified
  /// [field].
  /// The field may be a [String] representing a single field name or a [FieldPath].
  ///
  /// After a [FieldPath.documentId] order by call, you cannot add any more [orderBy]
  /// calls.
  ///
  /// Furthermore, you may not use [orderBy] on the [FieldPath.documentId] [field] when
  /// using [startAfterDocument], [startAtDocument], [endAfterDocument],
  /// or [endAtDocument] because the order by clause on the document id
  /// is added by these methods implicitly.
  void orderBy(String field, {bool descending = false}) {
    assert(field != null && descending != null);
    _assertValidFieldType(field);
    assert(!_hasStartCursor(),
        "Invalid query. You must not call startAt(), startAtDocument(), startAfter() or startAfterDocument() before calling orderBy()");
    assert(!_hasEndCursor(),
        "Invalid query. You must not call endAt(), endAtDocument(), endBefore() or endBeforeDocument() before calling orderBy()");

    final orders = structuredQuery.orderBy ?? [];

    assert(
      orders.where((order) => field == order.field.fieldPath).isEmpty,
      "OrderBy field '$field' already exists in this query",
    );
    orders.add(Order(
      FieldReference(field),
      descending ? Direction.descending : Direction.ascending,
    ));

    // if (field == FieldPath.documentId) {
    //   orders.add([field, descending]);
    // } else {
    //   FieldPath fieldPath =
    //       field is String ? FieldPath.fromString(field) : field;
    //   orders.add([fieldPath, descending]);
    // }

    if (structuredQuery.where != null) {
      final filters = <SingularFieldFilter>[];

      if (structuredQuery.where.compositeFilter != null) {
        for (final filter in structuredQuery.where.compositeFilter.filters) {
          filters.add(filter.unaryFilter ?? filter.fieldFilter);
        }
      } else {
        filters.add(structuredQuery.where.unaryFilter ??
            structuredQuery.where.fieldFilter);
      }

      for (final filter in filters) {
        if (filter is FieldFilter) {
          // Initial orderBy() parameter has to match every where() fieldPath parameter when
          // inequality operator is invoked
          if (filter.op.isInequality()) {
            assert(
              filter.field == orders[0].field,
              "The initial orderBy() field "
              "'${orders[0].field}' "
              "has to be the same as the where() field parameter "
              "'${filter.field}' when an inequality operator is invoked.",
            );
          }
        }

        // if (field == FieldPath.documentId) {
        //   assert(orderField == FieldPath.documentId,
        //   "'[FieldPath.documentId]' cannot be used in conjunction with a different orderBy() parameter.");
        // }
      }
    }

    structuredQuery.orderBy = orders;
  }

  /// Creates and returns a new [Query] that starts after the provided document
  /// (exclusive). The starting position is relative to the order of the query.
  /// The [documentSnapshot] must contain all of the fields provided in the orderBy of
  /// this query.
  ///
  /// Calling this method will replace any existing cursor "start" query modifiers.
  Query startAfterDocument(DocumentSnapshot documentSnapshot) {
    // Map<String, dynamic> results = _assertQueryCursorSnapshot(documentSnapshot);
    // return Query._(firestore,
    //     _delegate.startAfterDocument(results['orders'], results['values']));

    //  TODO: implement startAfterDocument()
    throw UnimplementedError();
  }

  /// Takes a list of [values], creates and returns a new [Query] that starts
  /// after the provided fields relative to the order of the query.
  ///
  /// The [values] must be in order of [orderBy] filters.
  ///
  /// Calling this method will replace any existing cursor "start" query modifiers.
  void startAfter(List<dynamic> values) {
    _assertQueryCursorValues(values);
    structuredQuery.startAt = Cursor(
      values.map((value) => Value.fromValue(value)).toList(),
      false,
    );
  }

  /// Creates and returns a new [Query] that starts at the provided document
  /// (inclusive). The starting position is relative to the order of the query.
  /// The document must contain all of the fields provided in the orderBy of
  /// this query.
  ///
  /// Calling this method will replace any existing cursor "start" query modifiers.
  Query startAtDocument(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> results = _assertQueryCursorSnapshot(documentSnapshot);
    // return Query._(firestore,
    //     _delegate.startAtDocument(results['orders'], results['values']));

    //  TODO: implement startAtDocument()
    throw UnimplementedError();
  }

  /// Takes a list of [values], creates and returns a new [Query] that starts at
  /// the provided fields relative to the order of the query.
  ///
  /// The [values] must be in order of [orderBy] filters.
  ///
  /// Calling this method will replace any existing cursor "start" query modifiers.
  void startAt(List<dynamic> values) {
    _assertQueryCursorValues(values);
    structuredQuery.startAt = Cursor(
      values.map((value) => Value.fromValue(value)).toList(),
      true,
    );
  }

  /// Creates and returns a new [Query] with additional filter on specified
  /// [field]. [field] refers to a field in a document.
  ///
  /// The [field] may be a [String] consisting of a single field name
  /// (referring to a top level field in the document),
  /// or a series of field names separated by dots '.'
  /// (referring to a nested field in the document).
  /// Alternatively, the [field] can also be a [FieldPath].
  ///
  /// Only documents satisfying provided condition are included in the result
  /// set.
  void where(
    String field, {
    dynamic isEqualTo,
    dynamic isLessThan,
    dynamic isLessThanOrEqualTo,
    dynamic isGreaterThan,
    dynamic isGreaterThanOrEqualTo,
    dynamic arrayContains,
    List<dynamic> arrayContainsAny,
    List<dynamic> whereIn,
    bool isNull,
  }) {
    _assertValidFieldType(field);

    final filters = <SingularFieldFilter>[];
    if (structuredQuery.where.compositeFilter != null) {
      for (final filter in structuredQuery.where.compositeFilter.filters) {
        filters.add(filter.unaryFilter ?? filter.fieldFilter);
      }
    } else {
      filters.add(structuredQuery.where.unaryFilter ??
          structuredQuery.where.fieldFilter);
    }

    void addUnaryFilter(String field, UnaryOperator operator) {
      final filter = UnaryFilter(FieldReference(field), operator);

      assert(filters.where((f) => f != filter).isEmpty,
          'Condition $filter already exists in this query.');
      filters.add(filter);
    }

    void addFieldFilter(String field, FieldOperator operator, dynamic value) {
      final filter = FieldFilter(
        FieldReference(field),
        operator,
        Value.fromValue(value),
      );

      assert(filters.where((f) => f != filter).isEmpty,
          'Condition $filter already exists in this query.');
      filters.add(filter);
    }

    if (isEqualTo != null) {
      addFieldFilter(field, FieldOperator.equal, isEqualTo);
    }
    if (isLessThan != null) {
      addFieldFilter(field, FieldOperator.lessThan, isLessThan);
    }
    if (isLessThanOrEqualTo != null) {
      addFieldFilter(field, FieldOperator.lessThanOrEqual, isLessThanOrEqualTo);
    }
    if (isGreaterThan != null) {
      addFieldFilter(field, FieldOperator.greaterThan, isGreaterThan);
    }
    if (isGreaterThanOrEqualTo != null) {
      addFieldFilter(
        field,
        FieldOperator.greaterThanOrEqual,
        isGreaterThanOrEqualTo,
      );
    }
    if (arrayContains != null) {
      addFieldFilter(field, FieldOperator.arrayContains, arrayContains);
    }
    if (arrayContainsAny != null) {
      addFieldFilter(field, FieldOperator.arrayContainsAny, arrayContainsAny);
    }
    if (whereIn != null) addFieldFilter(field, FieldOperator.inArray, whereIn);
    if (isNull != null) {
      assert(
          isNull,
          'isNull can only be set to true. '
          'Use isEqualTo to filter on non-null values.');
      addUnaryFilter(field, UnaryOperator.isNull);
    }

    dynamic hasInequality;
    bool hasIn = false;
    bool hasArrayContains = false;
    bool hasArrayContainsAny = false;

    // Once all conditions have been set, we must now check them to ensure the
    // query is valid.
    for (final filter in filters) {
      if (filter is FieldFilter) {
        // Initial orderBy() parameter has to match every where() fieldPath parameter when
        // inequality operator is invoked
        if (filter.op.isInequality() &&
            structuredQuery.orderBy != null &&
            structuredQuery.orderBy.isNotEmpty) {
          assert(
              filter.field == structuredQuery.orderBy[0].field,
              "The initial orderBy() field "
              "'${structuredQuery.orderBy[0].field}' has to be the same as the "
              "where() field parameter '${filter.field}' "
              "when an inequality operator is invoked.");
        }
        assert(
          !filter.value.nullValue,
          'Use isNull for checking if field is null',
        );

        if (filter.op == FieldOperator.inArray ||
            filter.op == FieldOperator.arrayContainsAny) {
          assert(
            filter.value.arrayValue != null &&
                filter.value.arrayValue.values.isNotEmpty,
            "A non-empty [List] is required for '${filter.op}' filters.",
          );
          assert(
            filter.value.arrayValue.values.length <= 10,
            "'${filter.op}' filters support a maximum of 10 elements in the "
            "value [List].",
          );
          assert(
            filter.value.arrayValue.values
                .where((value) => value == null)
                .isEmpty,
            "'${filter.op}' filters cannot contain 'null' in the [List].",
          );
        }

        if (filter.op == FieldOperator.inArray) {
          assert(!hasIn, "You cannot use 'in' filters more than once.");
          hasIn = true;
        }

        if (filter.op == FieldOperator.arrayContains) {
          assert(
            !hasArrayContains,
            "You cannot use 'array-contains' filters more than once.",
          );
          hasArrayContains = true;
        }

        if (filter.op == FieldOperator.arrayContainsAny) {
          assert(
            !hasArrayContainsAny,
            "You cannot use 'array-contains-any' filters more than once.",
          );
          hasArrayContainsAny = true;
        }

        if (filter.op == FieldOperator.arrayContainsAny ||
            filter.op == FieldOperator.inArray) {
          assert(
            !(hasIn && hasArrayContainsAny),
            "You cannot use 'in' filters with 'array-contains-any' filters.",
          );
        }

        if (filter.op == FieldOperator.arrayContains ||
            filter.op == FieldOperator.arrayContainsAny) {
          assert(
            !(hasArrayContains && hasArrayContainsAny),
            "You cannot use both 'array-contains-any' or 'array-contains' filters together.",
          );
        }

        if (filter.op.isInequality()) {
          if (hasInequality == null) {
            hasInequality = filter.field.fieldPath;
          } else {
            assert(
                hasInequality == filter.field.fieldPath,
                "All where filters with an inequality (<, <=, >, or >=) "
                "must be on the same field. But you have inequality filters on "
                "'$hasInequality' and '${filter.field.fieldPath}'.");
          }
        }
      }
    }

    if (filters.length > 1) {
      structuredQuery.where = Filter(
        compositeFilter: CompositeFilter(
          CompositeOperator.and,
          filters
              .map((filter) => filter is UnaryFilter
                  ? Filter(unaryFilter: filter)
                  : Filter(fieldFilter: filter))
              .toList(),
        ),
      );
    } else if (filters.length > 0) {
      structuredQuery.where = filters.first is UnaryFilter
          ? Filter(unaryFilter: filters.first)
          : Filter(fieldFilter: filters.first);
    }
  }
}
