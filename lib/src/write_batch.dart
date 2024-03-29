part of cloud_firestore_rest;

class WriteBatch {
  final FirebaseFirestore _firestore;
  final List<Write> _writes = [];

  WriteBatch._(this._firestore);

  /// Commits all of the writes in this write batch as a single atomic unit.
  ///
  /// Calling this method prevents any future operations from being added.
  Future<void> commit({Map<String, String>? headers}) async {
    await RestApi.commit(
      projectId: _firestore.app!.options.projectId,
      headers: headers,
      writes: _writes.toList(),
    );
  }

  /// Deletes the document referred to by [document].
  void delete(DocumentReference document) {
    assert(document._firestore == _firestore,
        "the document provided is from a different Firestore instance");

    _writes.add(Write(
      delete: 'projects/${_firestore.app!.options.projectId}'
          '/databases/(default)'
          '/documents/${document.path}',
    ));
  }

  /// Writes to the document referred to by [document].
  ///
  /// If the document does not yet exist, it will be created.
  ///
  /// If [SetOptions] are provided, the data will be merged into an existing
  /// document instead of overwriting.
  void set(
    DocumentReference document,
    Map<String, dynamic> data, {
    SetOptions? options,
    Map<String, String>? headers,
  }) {
    assert(document._firestore == _firestore,
        "the document provided is from a different Firestore instance");

    DocumentMask? mask;
    if (options != null) {
      if (options.merge != null && options.merge!) {
        mask = DocumentMask(data.keys as List<String>);
      } else if (options.mergeFields != null) {
        mask = DocumentMask(options.mergeFields!);
      }
    }

    _writes.add(Write(
      update: Document(
        name: 'projects/${_firestore.app!.options.projectId}'
            '/databases/(default)'
            '/documents/${document.path}',
        fields: data.map((key, value) => MapEntry(key, Value.fromValue(value))),
      ),
      updateMask: mask,
    ));
  }

  /// Updates a given [document].
  ///
  /// If the document does not yet exist, an exception will be thrown.
  void update(DocumentReference document, Map<String, dynamic> data) {
    assert(document._firestore == _firestore,
        "the document provided is from a different Firestore instance");

    _writes.add(Write(
      update: Document(
        name: 'projects/${_firestore.app!.options.projectId}'
            '/databases/(default)'
            '/documents/${document.path}',
        fields: data.map((key, value) => MapEntry(key, Value.fromValue(value))),
      ),
      updateMask: DocumentMask(data.keys as List<String>),
      currentDocument: Precondition(exists: true),
    ));
  }
}
