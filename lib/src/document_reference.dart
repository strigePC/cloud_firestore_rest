part of cloud_firestore_rest;

class DocumentReference {
  /// The Firestore instance associated with this document reference.
  final FirebaseFirestore firestore;

  /// This document's given ID within the collection.
  final String id;
  final List<String> components;

  DocumentReference._(this.firestore, this.components) : id = components.last;

  /// The parent [CollectionReference] of this document.
  CollectionReference get parent {
    return CollectionReference._(
      firestore,
      components.take(components.length - 1),
    );
  }

  /// A string representing the path of the referenced document (relative to the
  /// root of the database).
  String get path => components.join('/');

  /// Gets a [CollectionReference] instance that refers to the collection at the
  /// specified path, relative from this [DocumentReference].
  CollectionReference collection(String collectionPath) {
    assert(collectionPath != null, "a collection path cannot be null");
    assert(collectionPath.isNotEmpty,
        "a collectionPath path must be a non-empty string");
    assert(!collectionPath.contains("//"),
        "a collection path must not contain '//'");
    assert(collectionPath.split('/').length % 2 == 1,
        "a collection path must point to a valid collection.");

    return CollectionReference._(
      firestore,
      components.followedBy(collectionPath.split('/')),
    );
  }

  /// Deletes the current document from the collection.
  Future<void> delete({Map<String, String> headers}) async {
    await RestApi.delete(
      components.join('/'),
      projectId: firestore.app.options.projectId,
      headers: headers,
    );
  }

  /// Reads the document referenced by this [DocumentReference].
  ///
  /// By providing [options], this method can be configured to fetch results only
  /// from the server, only from the local cache or attempt to fetch results
  /// from the server and fall back to the cache (which is the default).
  Future<DocumentSnapshot> get({Map<String, String> headers}) async {
    final res = await RestApi.get(
      components.join('/'),
      headers: headers,
      projectId: firestore.app.options.projectId,
    );

    return DocumentSnapshot._(
      id,
      true,
      this,
      res.fields.map((key, value) => MapEntry(key, value.decode)),
    );
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
  Future<void> set(
    Map<String, dynamic> data,
    /*[SetOptions options]*/
  ) {
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
