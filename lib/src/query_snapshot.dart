part of cloud_firestore_rest;

class QuerySnapshot {
  final List<QueryDocumentSnapshot> docs;

  QuerySnapshot._(this.docs);

  int get size => docs.length;
}