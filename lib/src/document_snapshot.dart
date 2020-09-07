part of cloud_firestore_rest;

class DocumentSnapshot {
  /// This document's given ID for this snapshot.
  final String id;
  final bool exists;

  /// [DocumentReference] of this snapshot.
  final DocumentReference reference;
  final Map<String, dynamic> _data;

  DocumentSnapshot._(
    this.id,
    this.exists,
    this.reference,
    this._data,
  );

  /// Metadata about this [DocumentSnapshot] concerning its source and if it has local
  /// modifications.
  // SnapshotMetadata get metadata => SnapshotMetadata._(_delegate.metadata);

  /// Contains all the data of this [DocumentSnapshot].
  Map<String, dynamic> data() => _data;

  /// Gets a nested field by [String] or [FieldPath] from this [DocumentSnapshot].
  ///
  /// Data can be accessed by providing a dot-notated path or [FieldPath]
  /// which recursively finds the specified data. If no data could be found
  /// at the specified path, a [StateError] will be thrown.
  dynamic get(String field) {
    if (field == '__name__') {
      return 'projects/${reference.firestore.app.options.projectId}'
          '/databases/(default)'
          '/documents/${reference.path}';
    }

    try {
      if (field.indexOf('.') == -1) return _data[field];

      dynamic subsetData = _data;
      var subsetPath = field.split('.');

      while (subsetPath.isNotEmpty) {
        subsetData = subsetData[subsetPath.removeAt(0)];
      }

      return subsetData;
    } on NoSuchMethodError {
      throw StateError('No data could be found at the specified path ($field)');
    }
  }
}

class QueryDocumentSnapshot extends DocumentSnapshot {
  QueryDocumentSnapshot._(
    String id,
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super._(id, true, reference, data);
}

class DistanceDocumentSnapshot extends DocumentSnapshot {
  final double distance;

  DistanceDocumentSnapshot._({
    String id,
    DocumentReference reference,
    Map<String, dynamic> data,
    this.distance,
  }) : super._(id, true, reference, data);
}
