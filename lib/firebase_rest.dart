library firebase_rest;

import 'package:firebase_core/firebase_core.dart';

class FirebaseRest {
  static final instance = FirebaseRest._();

  FirebaseRest._() {
    print(Firebase.app().options.asMap);
  }
}
