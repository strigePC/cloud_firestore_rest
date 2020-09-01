part of cloud_firestore_rest;

enum Direction {
  @JsonValue('DIRECTION_UNSPECIFIED')
  directionUnspecified,
  @JsonValue('ASCENDING')
  ascending,
  @JsonValue('DESCENDING')
  descending,
}
