part of cloud_firestore_rest;

@JsonSerializable()
class Order {
  FieldReference field;
  Direction direction;

  Order(this.field, this.direction);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
