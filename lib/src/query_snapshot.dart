part of cloud_firestore_rest;

class QuerySnapshot {
  final List<DocumentSnapshot> docs;

  QuerySnapshot._(this.docs);

  int get size => docs.length;
}