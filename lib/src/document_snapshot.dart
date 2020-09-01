part of cloud_firestore_rest;

class DocumentSnapshot {
  final FirebaseFirestore _firestore;

  // final DocumentSnapshotPlatform _delegate;

  DocumentSnapshot._(this._firestore);

  /// This document's given ID for this snapshot.
  String get id {
    // return _delegate.id;

    //  TODO: implement id
    throw UnimplementedError();
  }

  /// Returns the [DocumentReference] of this snapshot.
  DocumentReference get reference {
    // return _firestore.doc(_delegate.reference.path);

    //  TODO: implement reference
    throw UnimplementedError();
  }

  /// Metadata about this [DocumentSnapshot] concerning its source and if it has local
  /// modifications.
  // SnapshotMetadata get metadata => SnapshotMetadata._(_delegate.metadata);

  /// Returns `true` if the [DocumentSnapshot] exists.
  bool get exists {
    // return _delegate.exists;

    //  TODO: implement exists
    throw UnimplementedError();
  }

  /// Contains all the data of this [DocumentSnapshot].
  Map<String, dynamic> data() {
    // return _CodecUtility.replaceDelegatesWithValueInMap(
    //     _delegate.data(), _firestore);


    //  TODO: implement data()
    throw UnimplementedError();
  }

  /// Gets a nested field by [String] or [FieldPath] from this [DocumentSnapshot].
  ///
  /// Data can be accessed by providing a dot-notated path or [FieldPath]
  /// which recursively finds the specified data. If no data could be found
  /// at the specified path, a [StateError] will be thrown.
  dynamic get(dynamic field) {
    // return _CodecUtility.valueDecode(_delegate.get(field), _firestore);

    //  TODO: implement get()
    throw UnimplementedError();
  }
}
