part of cloud_firestore_rest;

/// A transformation of a field of the document.
@JsonSerializable()
class FieldTransform {
  /// The path of the field. See Document.fields for the field path syntax
  /// reference.
  final String fieldPath;

  /// Sets the field to the given server value.
  final ServerValue? setToServerValue;

  /// Adds the given value to the field's current value.
  ///
  /// This must be an integer or a double value. If the field is not an integer
  /// or double, or if the field does not yet exist, the transformation will set
  /// the field to the given value. If either of the given value or the current
  /// field value are doubles, both values will be interpreted as doubles.
  /// Double arithmetic and representation of double values follow IEEE 754
  /// semantics. If there is positive/negative integer overflow, the field is
  /// resolved to the largest magnitude positive/negative integer.
  final Value? increment;

  /// Sets the field to the maximum of its current value and the given value.
  ///
  /// This must be an integer or a double value. If the field is not an integer
  /// or double, or if the field does not yet exist, the transformation will set
  /// the field to the given value. If a maximum operation is applied where the
  /// field and the input value are of mixed types (that is - one is an integer
  /// and one is a double) the field takes on the type of the larger operand. If
  /// the operands are equivalent (e.g. 3 and 3.0), the field does not change.
  /// 0, 0.0, and -0.0 are all zero. The maximum of a zero stored value and zero
  /// input value is always the stored value. The maximum of any numeric value x
  /// and NaN is NaN.
  final Value? maximum;

  /// Sets the field to the minimum of its current value and the given value.
  ///
  /// This must be an integer or a double value. If the field is not an integer
  /// or double, or if the field does not yet exist, the transformation will set
  /// the field to the input value. If a minimum operation is applied where the
  /// field and the input value are of mixed types (that is - one is an integer
  /// and one is a double) the field takes on the type of the smaller operand.
  /// If the operands are equivalent (e.g. 3 and 3.0), the field does not
  /// change. 0, 0.0, and -0.0 are all zero. The minimum of a zero stored value
  /// and zero input value is always the stored value. The minimum of any
  /// numeric value x and NaN is NaN.
  final Value? minimum;

  /// Append the given elements in order if they are not already present in the
  /// current field value. If the field is not an array, or if the field does
  /// not yet exist, it is first set to the empty array.
  ///
  /// Equivalent numbers of different types (e.g. 3L and 3.0) are considered
  /// equal when checking if a value is missing. NaN is equal to NaN, and Null
  /// is equal to Null. If the input contains multiple equivalent values, only
  /// the first will be considered.
  ///
  /// The corresponding transform_result will be the null value.
  final ArrayValue? appendMissingElements;

  /// Remove all of the given elements from the array in the field. If the field
  /// is not an array, or if the field does not yet exist, it is set to the
  /// empty array.
  ///
  /// Equivalent numbers of the different types (e.g. 3L and 3.0) are considered
  /// equal when deciding whether an element should be removed. NaN is equal to
  /// NaN, and Null is equal to Null. This will remove all equivalent values if
  /// there are duplicates.
  ///
  /// The corresponding transform_result will be the null value.
  final ArrayValue? removeAllFromArray;

  FieldTransform(
    this.fieldPath,
    this.setToServerValue,
    this.increment,
    this.maximum,
    this.minimum,
    this.appendMissingElements,
    this.removeAllFromArray,
  )   : assert(
          (setToServerValue != null) ^
              (increment != null) ^
              (maximum != null) ^
              (minimum != null) ^
              (appendMissingElements != null) ^
              (removeAllFromArray != null),
          'Union field transform_type. The transformation to apply on the field.'
          'You can set only one of the parameters',
        );

  factory FieldTransform.fromJson(Map<String, dynamic> json) =>
      _$FieldTransformFromJson(json);

  Map<String, dynamic> toJson() => _$FieldTransformToJson(this);
}

/// A value that is calculated by the server.
enum ServerValue {
  /// Unspecified. This value must not be used.
  @JsonKey(name: 'SERVER_VALUE_UNSPECIFIED')
  serverValueUnspecified,

  /// The time at which the server processed the request, with millisecond
/// precision.
  @JsonKey(name: 'REQUEST_TIME')
  requestTime,
}
