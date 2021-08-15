part of cloud_firestore_rest;

/// An order on a field.
@JsonSerializable()
class Order {
  /// The field to order by.
  final FieldReference field;

  /// The direction to order by. Defaults to [Direction.ascending].
  final Direction direction;

  Order(this.field, {this.direction = Direction.ascending})
      : assert(direction != Direction.directionUnspecified);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
