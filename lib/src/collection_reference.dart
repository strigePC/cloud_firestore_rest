part of cloud_firestore_rest;

class CollectionReference {
  final FirebaseFirestore firestore;

  CollectionReference._(this.firestore);

  /// Returns the ID of the referenced collection.
  String get id {
    // return _delegate.id;

    //  TODO: implement id
    throw UnimplementedError();
  }

  /// Returns the parent [DocumentReference] of this collection or `null`.
  ///
  /// If this collection is a root collection, `null` is returned.
  DocumentReference get parent {
    // DocumentReferencePlatform _documentReferencePlatform = _delegate.parent;

    // Only subcollections have a parent
    // if (_documentReferencePlatform == null) {
    //   return null;
    // }

    // return DocumentReference._(firestore, _documentReferencePlatform);


    //  TODO: implement parent
    throw UnimplementedError();
  }

  /// A string containing the slash-separated path to this  CollectionReference
  /// (relative to the root of the database).
  String get path {
    // return _delegate.path;

    //  TODO: implement path
    throw UnimplementedError();
  }

  /// Returns a `DocumentReference` with an auto-generated ID, after
  /// populating it with provided [data].
  ///
  /// The unique key generated is prefixed with a client-generated timestamp
  /// so that the resulting list will be chronologically-sorted.
  Future<DocumentReference> add(Map<String, dynamic> data) async {
    assert(data != null);
    final DocumentReference newDocument = doc();
    await newDocument.set(data);
    return newDocument;
  }

  /// Returns a `DocumentReference` with the provided path.
  ///
  /// If no [path] is provided, an auto-generated ID is used.
  ///
  /// The unique key generated is prefixed with a client-generated timestamp
  /// so that the resulting list will be chronologically-sorted.
  DocumentReference doc([String path]) {
    if (path != null) {
      assert(path.isNotEmpty, "a document path must be a non-empty string");
      assert(!path.contains("//"), "a document path must not contain '//'");
      assert(path != '/', "a document path must point to a valid document");
    }
    // return DocumentReference._(firestore, _delegate.doc(path));

    //  TODO: implement doc()
    throw UnimplementedError();
  }

  @override
  bool operator ==(dynamic o) =>
      o is CollectionReference && o.firestore == firestore && o.path == path;

  @override
  int get hashCode => hash2(firestore, path);

  @override
  String toString() => '$CollectionReference($path)';
}
