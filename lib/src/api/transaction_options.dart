part of cloud_firestore_rest;

@JsonSerializable()
class TransactionOptions {
  final ReadOnly readOnly;
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
  final DateTime readTime;

  ReadOnly(this.readTime)
      : assert(readTime == null || readTime.isUtc,
            'readTime should be in UTC format');

  factory ReadOnly.fromJson(Map<String, dynamic> json) {
    final result = _$ReadOnlyFromJson(json);
    assert(result.readTime == null || result.readTime.isUtc,
        'readTime should be in UTC format');
    return result;
  }

  Map<String, dynamic> toJson() => _$ReadOnlyToJson(this);
}

@JsonSerializable()
class ReadWrite {
  final String retryTransaction;

  ReadWrite(this.retryTransaction);

  factory ReadWrite.fromJson(Map<String, dynamic> json) =>
      _$ReadWriteFromJson(json);

  Map<String, dynamic> toJson() => _$ReadWriteToJson(this);
}
