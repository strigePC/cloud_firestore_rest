part of cloud_firestore_rest;

class DocumentReference {
  /// The Firestore instance associated with this document reference.
  final FirebaseFirestore firestore;

  DocumentReference._(this.firestore);

  /// This document's given ID within the collection.
  String get id {
    //  TODO: implement id
    throw UnimplementedError();
  }

  /// The parent [CollectionReference] of this document.
  CollectionReference get parent {
    // return CollectionReference._(firestore, _delegate.parent);

    //  TODO: implement parent
    throw UnimplementedError();
  }

  /// A string representing the path of the referenced document (relative to the
  /// root of the database).
  String get path {
    // return _delegate.path;

    //  TODO: implement path
    throw UnimplementedError();
  }

  /// Gets a [CollectionReference] instance that refers to the collection at the
  /// specified path, relative from this [DocumentReference].
  CollectionReference collection(String collectionPath) {
    assert(collectionPath != null, "a collection path cannot be null");
    assert(collectionPath.isNotEmpty,
        "a collectionPath path must be a non-empty string");
    assert(!collectionPath.contains("//"),
        "a collection path must not contain '//'");
    // assert(isValidCollectionPath(collectionPath),
    // "a collection path must point to a valid collection.");

    // return CollectionReference._(firestore);
  }

  /// Deletes the current document from the collection.
  Future<void> delete() {
    // return _delegate.delete();

    //  TODO: implement delete()
    throw UnimplementedError();
  }

  /// Reads the document referenced by this [DocumentReference].
  ///
  /// By providing [options], this method can be configured to fetch results only
  /// from the server, only from the local cache or attempt to fetch results
  /// from the server and fall back to the cache (which is the default).
  Future<DocumentSnapshot> get() async {
    // return DocumentSnapshot._(
    //     firestore, await _delegate.get(options ?? const GetOptions()));

    //  TODO: implement get()
    throw UnimplementedError();
  }

  /// Notifies of document updates at this location.
  ///
  /// An initial event is immediately sent, and further events will be
  /// sent whenever the document is modified.
  // Stream<DocumentSnapshot> snapshots({bool includeMetadataChanges = false}) =>
  //     _delegate.snapshots(includeMetadataChanges: includeMetadataChanges).map(
  //         (delegateSnapshot) =>
  //             DocumentSnapshot._(firestore, delegateSnapshot));

  /// Sets data on the document, overwriting any existing data. If the document
  /// does not yet exist, it will be created.
  ///
  /// If [SetOptions] are provided, the data will be merged into an existing
  /// document instead of overwriting.
  Future<void> set(Map<String, dynamic> data, /*[SetOptions options]*/) {
    assert(data != null);
    // return _delegate.set(
    //     _CodecUtility.replaceValueWithDelegatesInMap(data), options);

    //  TODO: implement set()
    throw UnimplementedError();
  }

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update(Map<String, dynamic> data) {
    assert(data != null);
    // return _delegate.update(_CodecUtility.replaceValueWithDelegatesInMap(data));

    //  TODO: implement update()
    throw UnimplementedError();
  }

  @override
  bool operator ==(dynamic o) =>
      o is DocumentReference && o.firestore == firestore && o.path == path;

  @override
  int get hashCode => hash2(firestore, path);

  @override
  String toString() => '$DocumentReference($path)';
}
