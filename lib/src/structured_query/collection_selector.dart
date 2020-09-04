part of cloud_firestore_rest;

@JsonSerializable()
class CollectionSelector {
  final String collectionId;
  final bool allDescendants;

  CollectionSelector(this.collectionId, {this.allDescendants});

  factory CollectionSelector.fromJson(Map<String, dynamic> json) =>
      _$CollectionSelectorFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionSelectorToJson(this);
}
