part of cloud_firestore_rest;

class FirebaseFirestore {
  /// The [FirebaseApp] for this current [FirebaseFirestore] instance.
  FirebaseApp app;

  FirebaseFirestore._({this.app});

  /// Returns an instance using the default [FirebaseApp].
  static FirebaseFirestore get instance {
    return FirebaseFirestore.instanceFor(
      app: Firebase.app(),
    );
  }

  /// Returns an instance using a specified [FirebaseApp].
  static FirebaseFirestore instanceFor({FirebaseApp app}) {
    assert(app != null);
    FirebaseFirestore newInstance = FirebaseFirestore._(app: app);
    return newInstance;
  }
}
