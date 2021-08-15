part of cloud_firestore_rest;

/// An options class that configures the behavior of set() calls in [DocumentReference],
/// [WriteBatch] and [Transaction].
class SetOptions {
  /// Changes the behavior of a set() call to only replace the values specified
  /// in its data argument.
  ///
  /// Fields omitted from the set() call remain untouched.
  final bool? merge;

  /// Changes the behavior of set() calls to only replace the specified field paths.
  ///
  /// Any field path that is not specified is ignored and remains untouched.
  List<String>? mergeFields;

  /// Creates a [SetOptions] instance.
  SetOptions({
    this.merge,
    List<String>? mergeFields,
  })  : assert(
          !(merge == null && mergeFields == null),
          "options must provide 'merge' or 'mergeFields'",
        ),
        assert(
          (merge != null) ^ (mergeFields != null),
          "options cannot have both 'merge' & 'mergeFields'",
        );
}
