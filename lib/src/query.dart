part of cloud_firestore_rest;

class Query {
  /// The [FirebaseFirestore] instance of this query.
  final FirebaseFirestore _firestore;
  final StructuredQuery structuredQuery = StructuredQuery();
  final List<String> _components;

  List<String>? _geoSearchArea;
  String? _geoFieldName;
  late GeoPoint _geoCenter;

  Query._(this._firestore, this._components);

  /// Returns whether the current query has a "start" cursor query.
  bool _hasStartCursor() => structuredQuery.startAt != null;

  /// Returns whether the current query has a "end" cursor query.
  bool _hasEndCursor() => structuredQuery.endAt != null;

  /// Asserts that a [DocumentSnapshot] can be used within the current
  /// query.
  ///
  /// Since a native DocumentSnapshot cannot be created without additional
  /// database calls, any ordered values are extracted from the document and
  /// passed to the query.
  Map<String, dynamic> _assertQueryCursorSnapshot(
      DocumentSnapshot documentSnapshot) {
    assert(documentSnapshot.exists,
        "a document snapshot must exist to be used within a query");

    // List<List<dynamic>> orders = List.from(parameters['orderBy']);
    final orders = List<Order>.from(structuredQuery.orderBy ?? []);
    List<dynamic> values = [];

    for (final Order order in orders) {
      if (order.field.fieldPath != '__name__') {
        try {
          values.add(documentSnapshot.get(order.field.fieldPath));
        } on StateError {
          throw ("You are trying to start or end a query using a document for which the field '${order.field}' (used as the orderBy) does not exist.");
        }
      }
    }

    // Any time you construct a query and don't include 'name' in the orderBys,
    // Firestore will implicitly assume an additional .orderBy('__name__', DIRECTION)
    // where DIRECTION will match the last orderBy direction of your query (or 'asc' if you have no orderBys).
    if (orders.isNotEmpty) {
      final lastOrder = orders.last;

      if (lastOrder.field.fieldPath != '__name__') {
        orders.add(Order(
          FieldReference('__name__'),
          direction: lastOrder.direction,
        ));
      }
    } else {
      orders.add(Order(
        FieldReference('__name__'),
        direction: Direction.ascending,
      ));
    }
    values.add(documentSnapshot.reference);
    //
    // if (_delegate.isCollectionGroupQuery) {
    //   values.add(documentSnapshot.reference.path);
    // } else {
    //   values.add(documentSnapshot.id);
    // }
    //
    return <String, dynamic>{
      'orders': orders,
      'values': values,
    };
  }

  /// Common handler for all non-document based cursor queries.
  void _assertQueryCursorValues(List<dynamic> fields) {
    assert(_geoSearchArea == null,
        'cursors (startAt, endAt, etc.) cannot be used on geo queries');
    assert(
      structuredQuery.orderBy != null,
      'orderBy() method should be called before setting cursors',
    );
    assert(
      fields.length <= structuredQuery.orderBy!.length,
      "Too many arguments provided. "
      "The number of arguments must be less than or equal to the number of "
      "orderBy() clauses.",
    );
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

    structuredQuery.endAt = Cursor(
      (results['values'] as List<dynamic>)
          .map((value) => Value.fromValue(value))
          .toList(),
      false,
    );
    structuredQuery.orderBy = results['orders'];
    return this;
  }

  /// Takes a list of [values], creates and returns a new [Query] that ends at the
  /// provided fields relative to the order of the query.
  ///
  /// The [values] must be in order of [orderBy] filters.
  ///
  /// Calling this method will replace any existing cursor "end" query modifiers.
  Query endAt(List<dynamic> values) {
    _assertQueryCursorValues(values);
    structuredQuery.endAt = Cursor(
      values.map((value) => Value.fromValue(value)).toList(),
      false,
    );

    return this;
  }

  /// Creates and returns a new [Query] that ends before the provided document
  /// snapshot (exclusive). The end position is relative to the order of the query.
  /// The document must contain all of the fields provided in the orderBy of
  /// this query.
  ///
  /// Calling this method will replace any existing cursor "end" query modifiers.
  Query endBeforeDocument(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> results = _assertQueryCursorSnapshot(documentSnapshot);

    structuredQuery.endAt = Cursor(
      (results['values'] as List<dynamic>)
          .map((value) => Value.fromValue(value))
          .toList(),
      true,
    );
    structuredQuery.orderBy = results['orders'];
    return this;
  }

  /// Takes a list of [values], creates and returns a new [Query] that ends before
  /// the provided fields relative to the order of the query.
  ///
  /// The [values] must be in order of [orderBy] filters.
  ///
  /// Calling this method will replace any existing cursor "end" query modifiers.
  Query endBefore(List<dynamic> values) {
    _assertQueryCursorValues(values);
    structuredQuery.endAt = Cursor(
      values.map((value) => Value.fromValue(value)).toList(),
      true,
    );

    return this;
  }

  /// Select the fields to be returned by this query
  Query fields(List<String> fields) {
    structuredQuery.select = Projection(
      fields.map((field) => FieldReference(field)).toList(),
    );
    return this;
  }

  /// Fetch the documents for this query.
  ///
  /// To modify how the query is fetched, the [options] parameter can be provided
  /// with a [GetOptions] instance.
  Future<QuerySnapshot> get({Map<String, String>? headers}) async {
    structuredQuery.from = [CollectionSelector(_components.last)];

    if (_geoSearchArea == null) {
      final results = await RestApi.runQuery(
        _components.take(_components.length - 1).join('/'),
        projectId: _firestore.app!.options.projectId,
        structuredQuery: structuredQuery,
        headers: headers,
      );

      return QuerySnapshot._(results
          .map(
            (result) => QueryDocumentSnapshot._(
              result.document!.name!.split('/').last,
              DocumentReference._(
                _firestore,
                result.document!.name!.split('/').skip(5).toList(),
              ),
              result.document!.fields!
                  .map((key, value) => MapEntry(key, value.decode)),
            ),
          )
          .toList());
    } else {
      final res = await Future.wait(_geoSearchArea!.map((hash) {
        final query = Query._(_firestore, _components);
        query.structuredQuery.select = structuredQuery.select;
        query.structuredQuery.limit = structuredQuery.limit;
        query.structuredQuery.from = structuredQuery.from;
        query.structuredQuery.where = structuredQuery.where;
        query.structuredQuery.orderBy = structuredQuery.orderBy;
        query.structuredQuery.startAt = Cursor([Value.fromValue(hash)], false);
        query.structuredQuery.endAt =
            Cursor([Value.fromValue('$hash~')], false);

        return query.get(headers: headers);
      }));

      return QuerySnapshot._(res
          .expand((snapshot) => snapshot.docs)
          .map((snapshot) => DistanceDocumentSnapshot._(
                id: snapshot.id,
                data: snapshot._data,
                reference: snapshot.reference,
                distance: _Util.calcDistance(
                  snapshot.get('$_geoFieldName.geopoint'),
                  _geoCenter,
                ),
              ))
          .toList());
    }
  }

  /// Creates and returns a new Query that's additionally limited to only return up
  /// to the specified number of documents.
  Query limit(int limit) {
    assert(limit > 0, "limit must be a positive number greater than 0");
    structuredQuery.limit = limit;

    return this;
  }

  /// Creates and returns a new Query that only returns the last matching documents.
  ///
  /// You must specify at least one orderBy clause for limitToLast queries,
  /// otherwise an exception will be thrown during execution.
  Query limitToLast(int limit) {
    assert(limit > 0, "limit must be a positive number greater than 0");
    assert(
      structuredQuery.orderBy != null && structuredQuery.orderBy!.isNotEmpty,
      "limitToLast() queries require specifying at least one orderBy() clause",
    );

    structuredQuery.orderBy = structuredQuery.orderBy!
        .map((order) => Order(
              order.field,
              direction: order.direction == Direction.ascending
                  ? Direction.descending
                  : Direction.ascending,
            ))
        .toList();
    structuredQuery.limit = limit;

    return this;
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
  Query orderBy(String field, {bool descending = false}) {
    assert(!_hasStartCursor(),
        "Invalid query. You must not call startAt(), startAtDocument(), startAfter() or startAfterDocument() before calling orderBy()");
    assert(!_hasEndCursor(),
        "Invalid query. You must not call endAt(), endAtDocument(), endBefore() or endBeforeDocument() before calling orderBy()");
    assert(_geoSearchArea == null, 'orderBy() cannot be used on geo queries');

    final orders = structuredQuery.orderBy ?? [];

    assert(
      orders.where((order) => field == order.field.fieldPath).isEmpty,
      "OrderBy field '$field' already exists in this query",
    );
    orders.add(Order(
      FieldReference(field),
      direction: descending ? Direction.descending : Direction.ascending,
    ));

    if (structuredQuery.where != null) {
      final filters = <SingularFieldFilter?>[];

      if (structuredQuery.where!.compositeFilter != null) {
        for (final filter in structuredQuery.where!.compositeFilter!.filters) {
          filters.add(filter.unaryFilter ?? filter.fieldFilter);
        }
      } else {
        filters.add(structuredQuery.where!.unaryFilter ??
            structuredQuery.where!.fieldFilter);
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

          for (final order in orders) {
            // Any where() fieldPath parameter cannot match any orderBy() parameter when
            // '==' operand is invoked
            if (filter.op == FieldOperator.equal) {
              assert(
                filter.field != order.field,
                "The '${order.field}' cannot be the same as your where() field "
                "parameter '$field'.",
              );
            }
          }
        }

        for (final order in orders) {
          if (filter!.field!.fieldPath == '__name__') {
            assert(
              order.field.fieldPath == '__name__',
              "'__name__' cannot be used in conjunction with a different "
              "orderBy() parameter.",
            );
          }
        }
      }
    }

    structuredQuery.orderBy = orders;

    return this;
  }

  /// Creates and returns a new [Query] that starts after the provided document
  /// (exclusive). The starting position is relative to the order of the query.
  /// The [documentSnapshot] must contain all of the fields provided in the orderBy of
  /// this query.
  ///
  /// Calling this method will replace any existing cursor "start" query modifiers.
  Query startAfterDocument(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> results = _assertQueryCursorSnapshot(documentSnapshot);

    structuredQuery.startAt = Cursor(
      (results['values'] as List<dynamic>)
          .map((value) => Value.fromValue(value))
          .toList(),
      false,
    );
    structuredQuery.orderBy = results['orders'];
    return this;
  }

  /// Takes a list of [values], creates and returns a new [Query] that starts
  /// after the provided fields relative to the order of the query.
  ///
  /// The [values] must be in order of [orderBy] filters.
  ///
  /// Calling this method will replace any existing cursor "start" query modifiers.
  Query startAfter(List<dynamic> values) {
    _assertQueryCursorValues(values);
    structuredQuery.startAt = Cursor(
      values.map((value) => Value.fromValue(value)).toList(),
      false,
    );

    return this;
  }

  /// Creates and returns a new [Query] that starts at the provided document
  /// (inclusive). The starting position is relative to the order of the query.
  /// The document must contain all of the fields provided in the orderBy of
  /// this query.
  ///
  /// Calling this method will replace any existing cursor "start" query modifiers.
  Query startAtDocument(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> results = _assertQueryCursorSnapshot(documentSnapshot);

    structuredQuery.startAt = Cursor(
      (results['values'] as List<dynamic>)
          .map((value) => Value.fromValue(value))
          .toList(),
      true,
    );
    structuredQuery.orderBy = results['orders'];
    return this;
  }

  /// Takes a list of [values], creates and returns a new [Query] that starts at
  /// the provided fields relative to the order of the query.
  ///
  /// The [values] must be in order of [orderBy] filters.
  ///
  /// Calling this method will replace any existing cursor "start" query modifiers.
  Query startAt(List<dynamic> values) {
    _assertQueryCursorValues(values);
    structuredQuery.startAt = Cursor(
      values.map((value) => Value.fromValue(value)).toList(),
      true,
    );

    return this;
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
  Query where(
    String field, {
    dynamic isEqualTo,
    dynamic isLessThan,
    dynamic isLessThanOrEqualTo,
    dynamic isGreaterThan,
    dynamic isGreaterThanOrEqualTo,
    dynamic arrayContains,
    List<dynamic>? arrayContainsAny,
    List<dynamic>? whereIn,
    bool? isNull,
    double? isWithin,
    GeoPoint? centeredAt,
  }) {
    assert(
      (isWithin == null && centeredAt == null) ||
          (isWithin != null && centeredAt != null),
      'centeredAt and isWithin parameters must be used together',
    );
    final filters = <SingularFieldFilter?>[];
    if (structuredQuery.where?.compositeFilter != null) {
      for (final filter in structuredQuery.where!.compositeFilter!.filters) {
        filters.add(filter.unaryFilter ?? filter.fieldFilter);
      }
    } else if (structuredQuery.where?.unaryFilter != null) {
      filters.add(structuredQuery.where?.unaryFilter);
    } else if (structuredQuery.where?.fieldFilter != null) {
      filters.add(structuredQuery.where?.fieldFilter);
    }

    void addUnaryFilter(String field, UnaryOperator operator) {
      final filter = UnaryFilter(FieldReference(field), operator);

      assert(filters.where((f) => f == filter).isEmpty,
          'Condition $filter already exists in this query.');
      filters.add(filter);
    }

    void addFieldFilter(String field, FieldOperator operator, dynamic value) {
      final filter = FieldFilter(
        FieldReference(field),
        operator,
        Value.fromValue(value),
      );

      assert(filters.where((f) => f == filter).isEmpty,
          'Condition ($filter) already exists in this query.');
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
    if (centeredAt != null && isWithin != null) {
      final center = GeoFirePoint.fromGeoPoint(centeredAt);
      _geoCenter = centeredAt;
      int precision = _Util.setPrecision(isWithin);
      String centerHash = center.geohash.substring(0, precision);
      _geoSearchArea = _Util.neighbors(centerHash)..add(centerHash);
      _geoFieldName = field;
      structuredQuery.orderBy = [Order(FieldReference('$field.geohash'))];
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
            structuredQuery.orderBy!.isNotEmpty) {
          assert(
              filter.field == structuredQuery.orderBy![0].field,
              "The initial orderBy() field "
              "'${structuredQuery.orderBy![0].field}' has to be the same as the "
              "where() field parameter '${filter.field}' "
              "when an inequality operator is invoked.");
        }
        assert(
          !filter.value.isNull(),
          'Use isNull for checking if field is null',
        );

        if (filter.op == FieldOperator.inArray ||
            filter.op == FieldOperator.arrayContainsAny) {
          assert(
            filter.value.arrayValue != null &&
                filter.value.arrayValue!.values!.isNotEmpty,
            "A non-empty [List] is required for '${filter.op}' filters.",
          );
          assert(
            filter.value.arrayValue!.values!.length <= 10,
            "'${filter.op}' filters support a maximum of 10 elements in the "
            "value [List].",
          );
          assert(
            filter.value.arrayValue!.values!
                .where((value) => false)
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
        compositeFilter: CompositeFilter.and(
          filters
              .map((filter) => filter is UnaryFilter
                  ? Filter(unaryFilter: filter)
                  : Filter(fieldFilter: filter as FieldFilter?))
              .toList(),
        ),
      );
    } else if (filters.length > 0) {
      structuredQuery.where = filters.first is UnaryFilter
          ? Filter(unaryFilter: filters.first as UnaryFilter?)
          : Filter(fieldFilter: filters.first as FieldFilter?);
    }

    return this;
  }
}
