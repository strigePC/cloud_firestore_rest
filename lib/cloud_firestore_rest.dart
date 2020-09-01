library cloud_firestore_rest;

import 'package:firebase_core/firebase_core.dart';

part 'src/firestore.dart';
part 'src/query.dart';
part 'src/structured_query/structured_query.dart';
part 'src/structured_query/projection.dart';
part 'src/structured_query/field_reference.dart';
part 'src/structured_query/collection_selector.dart';
part 'src/structured_query/operator.dart';
part 'src/structured_query/filter.dart';
part 'src/structured_query/value.dart';
part 'src/structured_query/direction.dart';
part 'src/structured_query/order.dart';
part 'src/structured_query/cursor.dart';

const _baseUrl = 'https://firestore.googleapis.com/v1';

class CloudFirestoreRest {
  static final instance = CloudFirestoreRest._();

  CloudFirestoreRest._();
}
