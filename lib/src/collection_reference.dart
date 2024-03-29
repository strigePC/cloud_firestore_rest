part of cloud_firestore_rest;

class CollectionReference extends Query {
  /// ID of the referenced collection.
  final String id;

  CollectionReference._(FirebaseFirestore firestore, List<String> components)
      : id = components.last,
        super._(firestore, components);

  /// Returns the parent [DocumentReference] of this collection or `null`.
  ///
  /// If this collection is a root collection, `null` is returned.
  DocumentReference? get parent {
    if (_components.length <= 1) return null;

    return DocumentReference._(
      _firestore,
      _components.take(_components.length - 1) as List<String>,
    );
  }

  /// A string containing the slash-separated path to this  CollectionReference
  /// (relative to the root of the database).
  String get path => _components.join('/');

  /// Returns a `DocumentReference` with an auto-generated ID, after
  /// populating it with provided [data].
  ///
  /// The unique key generated is prefixed with a client-generated timestamp
  /// so that the resulting list will be chronologically-sorted.
  Future<DocumentReference> add(
    Map<String, dynamic> data, {
    Map<String, String>? headers,
  }) async {
    final res = await RestApi.createDocument(
      path,
      body: Document(
        fields: data.map((key, value) => MapEntry(key, Value.fromValue(value))),
      ),
      projectId: _firestore.app!.options.projectId,
      headers: headers,
    );

    return DocumentReference._(
      _firestore,
      _components.followedBy([res.name!.split('/').last]) as List<String>,
    );

    // final DocumentReference newDocument = doc();
    // await newDocument.set(data);
    // return newDocument;
  }

  /// Returns a `DocumentReference` with the provided path.
  ///
  /// If no [path] is provided, an auto-generated ID is used.
  ///
  /// The unique key generated is prefixed with a client-generated timestamp
  /// so that the resulting list will be chronologically-sorted.
  DocumentReference doc([String? path]) {
    // TODO: add id generator
    if (path != null) {
      assert(path.isNotEmpty, "a document path must be a non-empty string");
      assert(!path.contains("//"), "a document path must not contain '//'");
      assert(path != '/', "a document path must point to a valid document");
    }

    return DocumentReference._(
      _firestore,
      _components.followedBy(path!.split('/')).toList(),
    );
  }

  @override
  bool operator ==(dynamic o) =>
      o is CollectionReference &&
      o._firestore == _firestore &&
      o._components == _components;

  @override
  int get hashCode => hash2(_firestore, _components);

  @override
  String toString() => '$CollectionReference($_components)';
}
