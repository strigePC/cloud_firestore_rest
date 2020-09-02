part of cloud_firestore_rest;

class DocumentMask {
  final List<String> fieldPaths;

  DocumentMask(this.fieldPaths) : assert(fieldPaths != null);

  @override
  String toString() {
    return fieldPaths.toString();
  }
}
