part of cloud_firestore_rest;

class RestApi {
  static void _assertPathFormat(String path) {
    final pathFormat = RegExp(
      r'projects'
      r'\/[^\/]+'
      r'\/databases'
      r'\/[^\/]+'
      r'\/documents'
      r'\/?[^\/]*',
    );

    assert(
        pathFormat.hasMatch(path),
        'Input name has wrong format. '
        'It should be projects/{project_id}/databases/{database_id}/documents/{document_path}, '
        'but got $path');
  }

  /// Applies a batch of write operations.
  ///
  /// The batchWrite method does not apply the write operations
  /// atomically and can apply them out of order. Method does not allow more
  /// than one write per document. Each write succeeds or fails independently.
  /// See the [BatchWriteResponse] for the success status of each write.
  ///
  /// If you require an atomically applied set of writes, use [commit]
  /// instead.
  static Future<BatchWriteResponse> batchWrite({
    String? projectId,
    String databaseId = '(default)',
    List<Write>? writes,
    Map<String, String>? labels,
    Map<String, String>? headers,
  }) async {
    if (projectId == null) projectId = Firebase.app().options.projectId;

    final path = 'projects/$projectId/databases/$databaseId/documents';
    _assertPathFormat(path);

    final uri = Uri.https(_baseUrl, '$_apiVersion/$path:batchWrite');
    final body = <String, dynamic>{'writes': writes, 'labels': labels};

    final res = await http.post(uri, headers: headers, body: jsonEncode(body));
    final json = jsonDecode(res.body);

    if (json['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.batchWrite',
        code: json['error']['code'].toString(),
        message: json['error']['message'],
      );
    }

    return BatchWriteResponse.fromJson(json);
  }

  /// Commits a transaction, while optionally updating documents.
  /// HTTP request
  /// POST https://firestore.googleapis.com/v1/{database=projects/*/databases/*}/documents:commit
  static Future<CommitResponse> commit({
    String? projectId,
    String databaseId = '(default)',
    List<Write>? writes,
    Uint64List? transaction,
    Map<String, String>? headers,
  }) async {
    if (projectId == null) projectId = Firebase.app().options.projectId;

    final path = 'projects/$projectId/databases/$databaseId/documents';
    _assertPathFormat(path);
    final uri = Uri.https(_baseUrl, '$_apiVersion/$path:commit');
    final body = <String, dynamic>{'writes': writes};

    if (transaction != null) {
      body['transaction'] = base64Encode(transaction);
    }

    final res = await http.post(uri, headers: headers, body: jsonEncode(body));
    final json = jsonDecode(res.body);

    if (json['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.commit',
        code: json['error']['code'].toString(),
        message: json['error']['message'],
      );
    }

    return CommitResponse.fromJson(json);
  }

  /// Creates a new document.
  /// HTTP request
  /// POST https://firestore.googleapis.com/v1/{parent=projects/*/databases/*/documents/**}/{collectionId}
  static Future<Document> createDocument(
    String collectionId, {
    String? projectId,
    String databaseId = '(default)',
    String? documentId,
    DocumentMask? mask,
    Document? body,
    Map<String, String>? headers,
  }) async {
    if (projectId == null) projectId = Firebase.app().options.projectId;

    final path =
        'projects/$projectId/databases/$databaseId/documents/$collectionId';
    _assertPathFormat(path);

    final uri = Uri.https(_baseUrl, '$_apiVersion/$path');

    final queryParameters = <String>[];

    if (documentId != null) queryParameters.add('documentId=$documentId');
    if (mask != null) {
      queryParameters.addAll(
          mask.fieldPaths.map((fieldPath) => 'mask.fieldPaths=$fieldPath'));
    }

    final res = await http.post(uri, headers: headers, body: jsonEncode(body));
    final json = jsonDecode(res.body);

    if (json['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.createDocument',
        code: json['error']['code'].toString(),
        message: json['error']['message'],
      );
    }

    return Document.fromJson(json);
  }

  /// Deletes a document
  /// HTTP request
  /// DELETE https://firestore.googleapis.com/v1/{name=projects/*/databases/*/documents/*/**}
  static Future<void> delete(
    String documentPath, {
    String? projectId,
    String databaseId = '(default)',
    Precondition? currentDocument,
    Map<String, String>? headers,
  }) async {
    if (projectId == null) projectId = Firebase.app().options.projectId;

    final path =
        'projects/$projectId/databases/$databaseId/documents/$documentPath';
    _assertPathFormat(path);

    final queryParameters = <String, dynamic>{};

    if (currentDocument != null) {
      if (currentDocument.exists != null) {
        queryParameters['currentDocument.exists'] =
            currentDocument.exists.toString();
      } else if (currentDocument.updateTime != null) {
        queryParameters['currentDocument.updateTime'] =
            currentDocument.updateTime!.toUtc().toIso8601String();
      }
    }

    final uri = Uri.https(_baseUrl, '$_apiVersion/$path', queryParameters);
    final res = await http.delete(uri, headers: headers);
    final json = jsonDecode(res.body);

    if (json['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.delete',
        code: json['error']['code'].toString(),
        message: json['error']['message'],
      );
    }
  }

  /// Gets a single document.
  /// HTTP request
  /// GET https://firestore.googleapis.com/v1/{name=projects/*/databases/*/documents/*/**}
  static Future<Document> get(
    String documentPath, {
    String? projectId,
    String databaseId = '(default)',
    DocumentMask? mask,
    Uint64List? transaction,
    DateTime? readTime,
    Map<String, String>? headers,
  }) async {
    assert(transaction == null || readTime == null,
        'You should use either transaction or readTime, not both');
    if (projectId == null) projectId = Firebase.app().options.projectId;

    final path =
        'projects/$projectId/databases/$databaseId/documents/$documentPath';
    _assertPathFormat(path);

    final queryParameters = <String, dynamic>{};

    // Handling query parameters
    if (mask != null) queryParameters['mask.fieldPaths'] = mask.fieldPaths;

    if (transaction != null) {
      queryParameters['transaction'] = base64Encode(transaction);
    }
    if (readTime != null) {
      queryParameters['readTime'] = readTime.toUtc().toIso8601String();
    }

    final uri = Uri.https(_baseUrl, '$_apiVersion/$path', queryParameters);
    final res = await http.get(uri, headers: headers);
    final json = jsonDecode(res.body);

    if (json['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.get',
        code: json['error']['code'].toString(),
        message: json['error']['message'],
      );
    }

    return Document.fromJson(json);
  }

  /// Lists documents.
  /// HTTP Request
  /// GET https://firestore.googleapis.com/v1/{parent=projects/*/databases/*/documents/*/**}/{collectionId}
  static Future<ListDocumentsResponse> list(
    String collectionId, {
    String? projectId,
    String databaseId = '(default)',
    int? pageSize,
    String? pageToken,
    String? orderBy,
    DocumentMask? mask,
    bool? showMissing,
    Uint64List? transaction,
    DateTime? readTime,
    Map<String, String>? headers,
  }) async {
    assert(transaction == null || readTime == null,
        'You should use either transaction or readTime, not both');
    if (projectId == null) projectId = Firebase.app().options.projectId;

    final path =
        'projects/$projectId/databases/$databaseId/documents/$collectionId';
    _assertPathFormat(path);

    // Handling query parameters
    final queryParameters = <String, dynamic>{};

    if (pageSize != null) queryParameters['pageSize'] = pageSize;
    if (pageToken != null) queryParameters['pageToken'] = pageToken;
    if (orderBy != null) queryParameters['orderBy'] = orderBy;
    if (mask != null) queryParameters['mask.fieldPaths'] = mask.fieldPaths;
    if (showMissing != null) queryParameters['showMissing'] = showMissing;
    if (transaction != null) {
      queryParameters['transaction'] = base64Encode(transaction);
    }
    if (readTime != null) {
      queryParameters['readTime'] = readTime.toUtc().toIso8601String();
    }

    final uri = Uri.https(_baseUrl, '/$_apiVersion/$path', queryParameters);
    final res = await http.get(uri, headers: headers);
    final json = jsonDecode(res.body);

    if (json is List && json.isNotEmpty && json[0]['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.list',
        code: json[0]['error']['code'].toString(),
        message: json[0]['error']['message'],
      );
    }

    return ListDocumentsResponse.fromJson(json);
  }

  /// Updates or inserts a document.
  /// HTTP request
  /// PATCH https://firestore.googleapis.com/v1/{document.name=projects/*/databases/*/documents/*/**}
  static Future<Document> patch(
    String documentPath, {
    String? projectId,
    String databaseId = '(default)',
    DocumentMask? updateMask,
    DocumentMask? mask,
    Precondition? currentDocument,
    Document? body,
    Map<String, String>? headers,
  }) async {
    if (projectId == null) projectId = Firebase.app().options.projectId;

    final path =
        'projects/$projectId/databases/$databaseId/documents/$documentPath';
    _assertPathFormat(path);

    // Handling query parameters
    final queryParameters = <String, dynamic>{};

    if (updateMask != null) {
      queryParameters['updateMask.fieldPaths'] = updateMask.fieldPaths;
    }

    if (mask != null) queryParameters['mask.fieldPaths'] = mask.fieldPaths;

    if (currentDocument != null) {
      if (currentDocument.exists != null) {
        queryParameters['currentDocument.exists'] =
            currentDocument.exists.toString();
      } else if (currentDocument.updateTime != null) {
        queryParameters['currentDocument.updateTime'] =
            currentDocument.updateTime!.toUtc().toIso8601String();
      }
    }

    final uri = Uri.https(_baseUrl, '$_apiVersion/$path', queryParameters);
    final res = await http.patch(uri, headers: headers, body: jsonEncode(body));
    final json = jsonDecode(res.body);

    if (json['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.patch',
        code: json['error']['code'].toString(),
        message: json['error']['message'],
      );
    }

    return Document.fromJson(json);
  }

  /// Runs a query.
  /// HTTP request
  /// POST https://firestore.googleapis.com/v1/{parent=projects/*/databases/*/documents}:runQuery
  static Future<List<RunQueryResponse>> runQuery(
    String documentPath, {
    String? projectId,
    String databaseId = '(default)',
    StructuredQuery? structuredQuery,
    Uint64List? transaction,
    TransactionOptions? newTransaction,
    DateTime? readTime,
    Map<String, String>? headers,
  }) async {
    assert(
      ((transaction != null) ^ (newTransaction != null) ^ (readTime != null) ||
          (transaction == null && newTransaction == null && readTime == null)),
      'You can set only one of transaction, newTransaction and readTime',
    );
    if (projectId == null) projectId = Firebase.app().options.projectId;

    final path = StringBuffer('projects/$projectId'
        '/databases/$databaseId'
        '/documents');
    if (documentPath.isNotEmpty) path.write('/$documentPath');

    _assertPathFormat(path.toString());

    final body = <String, dynamic>{'structuredQuery': structuredQuery};
    if (transaction != null) {
      body['transaction'] = base64Encode(transaction);
    } else if (newTransaction != null) {
      body['newTransaction'] = newTransaction;
    } else if (readTime != null) {
      body['readTime'] = readTime.toUtc().toIso8601String();
    }

    final uri = Uri.https(_baseUrl, '$_apiVersion/$path:runQuery');
    final res = await http.post(uri, headers: headers, body: jsonEncode(body));
    final json = jsonDecode(res.body);

    if (json is List && json.isNotEmpty && json[0]['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.runQuery',
        code: json[0]['error']['code'].toString(),
        message: json[0]['error']['message'],
      );
    }

    return (json as List)
        .where((e) => e['document'] != null)
        .map((e) => RunQueryResponse.fromJson(e))
        .toList();
  }
}
