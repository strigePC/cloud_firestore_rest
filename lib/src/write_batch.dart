part of cloud_firestore_rest;

class WriteBatch {
  final FirebaseFirestore _firestore;
  final List<Write> _writes = [];

  WriteBatch._(this._firestore);

  /// Commits all of the writes in this write batch as a single atomic unit.
  ///
  /// Calling this method prevents any future operations from being added.
  Future<void> commit() async {
  //  TODO implement commit
    throw UnimplementedError();
  }

  /// Deletes the document referred to by [document].
  void delete(DocumentReference document) {
    assert(document != null);
    assert(document.firestore == _firestore,
    "the document provided is from a different Firestore instance");
    // return _delegate.delete(document.path);
    //  TODO implement delete
    throw UnimplementedError();
  }

  /// Writes to the document referred to by [document].
  ///
  /// If the document does not yet exist, it will be created.
  ///
  /// If [SetOptions] are provided, the data will be merged into an existing
  /// document instead of overwriting.
  void set(DocumentReference document, Map<String, dynamic> data,
      [SetOptions options]) {
    assert(document != null);
    assert(data != null);
    assert(document.firestore == _firestore,
    "the document provided is from a different Firestore instance");
    // return _delegate.set(document.path,
    //     _CodecUtility.replaceValueWithDelegatesInMap(data), options);

    //  TODO implement set
    throw UnimplementedError();
  }

  /// Updates a given [document].
  ///
  /// If the document does not yet exist, an exception will be thrown.
  void update(DocumentReference document, Map<String, dynamic> data) {
    assert(document != null);
    assert(data != null);
    assert(document.firestore == _firestore,
    "the document provided is from a different Firestore instance");
    // return _delegate.update(
    //     document.path, _CodecUtility.replaceValueWithDelegatesInMap(data));
    //  TODO implement update
    throw UnimplementedError();
  }
}