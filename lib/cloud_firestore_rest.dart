library cloud_firestore_rest;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/core.dart';

part 'cloud_firestore_rest.g.dart';
part 'src/api/api.dart';
part 'src/api/batch_write_response.dart';
part 'src/api/document_mask.dart';
part 'src/api/document_transform.dart';
part 'src/api/field_transform.dart';
part 'src/api/list_documents_response.dart';
part 'src/api/precondition.dart';
part 'src/api/run_query_response.dart';
part 'src/api/status.dart';
part 'src/api/transaction_options.dart';
part 'src/api/write.dart';
part 'src/api/write_result.dart';
part 'src/collection_reference.dart';
part 'src/document.dart';
part 'src/document_reference.dart';
part 'src/document_snapshot.dart';
part 'src/firestore.dart';
part 'src/query.dart';
part 'src/query_snapshot.dart';
part 'src/set_options.dart';
part 'src/structured_query/collection_selector.dart';
part 'src/structured_query/cursor.dart';
part 'src/structured_query/direction.dart';
part 'src/structured_query/field_reference.dart';
part 'src/structured_query/filter.dart';
part 'src/structured_query/operator.dart';
part 'src/structured_query/order.dart';
part 'src/structured_query/projection.dart';
part 'src/structured_query/structured_query.dart';
part 'src/structured_query/value.dart';
part 'src/util.dart';
part 'src/write_batch.dart';
part 'types/geo_point.dart';

const _baseUrl = 'https://firestore.googleapis.com/v1';
