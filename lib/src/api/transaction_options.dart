part of cloud_firestore_rest;

/// Options for creating a new transaction.
@JsonSerializable()
class TransactionOptions {
  /// The transaction can only be used for read operations.
  final ReadOnly readOnly;

  /// The transaction can be used for both read and write operations.
  final ReadWrite readWrite;

  TransactionOptions(this.readOnly, this.readWrite)
      : assert(readOnly != null || readWrite != null,
            'At least one of the fields (readOnly, readWrite) should be set'),
        assert(readOnly == null || readWrite == null,
            'You should use either readOnly or readWrite, not both');

  factory TransactionOptions.fromJson(Map<String, dynamic> json) =>
      _$TransactionOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionOptionsToJson(this);
}

@JsonSerializable()
class ReadOnly {
  /// Reads documents at the given time. This may not be older than 60 seconds.
  ///
  /// A timestamp in RFC3339 UTC "Zulu" format, with nanosecond resolution and
  /// up to nine fractional digits. Examples: "2014-10-02T15:01:23Z" and
  /// "2014-10-02T15:01:23.045123456Z".
  @JsonKey(toJson: _Util.dateTimeToJson, fromJson: _Util.dateTimeFromJson)
  final DateTime readTime;

  ReadOnly(this.readTime)
      : assert(readTime == null || readTime.isUtc,
            'readTime should be in UTC format');

  factory ReadOnly.fromJson(Map<String, dynamic> json) =>
      _$ReadOnlyFromJson(json);

  Map<String, dynamic> toJson() => _$ReadOnlyToJson(this);
}

@JsonSerializable()
class ReadWrite {
  /// An optional transaction to retry.
  ///
  /// A base64-encoded string.
  final String retryTransaction;

  ReadWrite({this.retryTransaction});

  factory ReadWrite.fromJson(Map<String, dynamic> json) =>
      _$ReadWriteFromJson(json);

  Map<String, dynamic> toJson() => _$ReadWriteToJson(this);
}
