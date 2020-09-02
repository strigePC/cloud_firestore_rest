part of cloud_firestore_rest;

class Precondition {
  final bool exists;
  final DateTime updateTime;

  Precondition({this.exists, this.updateTime})
      : assert(exists != null || updateTime != null,
            'At least one of the fields (exists, updateTime) should be set'),
        assert(exists == null || updateTime == null,
            'You should use either exists or updateTime, not both');
}
