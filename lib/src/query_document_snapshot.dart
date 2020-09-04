part of cloud_firestore_rest;

class QueryDocumentSnapshot extends DocumentSnapshot {
  QueryDocumentSnapshot._(
    String id,
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super._(id, true, reference, data);
}
