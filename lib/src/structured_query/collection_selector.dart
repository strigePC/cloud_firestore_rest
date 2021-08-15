part of cloud_firestore_rest;

/// A selection of a collection, such as messages as m1.
@JsonSerializable()
class CollectionSelector {
  /// The collection ID. When set, selects only collections with this ID.
  final String? collectionId;

  /// When false, selects only collections that are immediate children of the
  /// parent specified in the containing RunQueryRequest. When true, selects all
  /// descendant collections.
  final bool? allDescendants;

  CollectionSelector(this.collectionId, {this.allDescendants});

  factory CollectionSelector.fromJson(Map<String, dynamic> json) =>
      _$CollectionSelectorFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionSelectorToJson(this);
}
