part of cloud_firestore_rest;

class CollectionSelector {
  final String collectionId;
  final bool allDescendants;

  CollectionSelector(this.collectionId, this.allDescendants);
}