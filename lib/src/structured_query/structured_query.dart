part of cloud_firestore_rest;

class StructuredQuery {
  Projection select;
  final List<CollectionSelector> from = [];
  Filter where;
  Order orderBy;
  Cursor startAt;
  Cursor endAt;
  int offset;
  int limit;
}