part of cloud_firestore_rest;

class RestApi {
  static void _assertPathFormat(String path) {
    assert(path != null);
    final pathFormat = RegExp(
      r'projects'
      r'\/[\w-]+'
      r'\/databases'
      r'\/[\w-()]+'
      r'\/documents'
      r'\/[\w-\/]+',
    );

    assert(
        pathFormat.hasMatch(path),
        'Input name has wrong format. '
        'It should be projects/{project_id}/databases/{database_id}/documents/{document_path}, '
        'but got $path');
  }

  static void _assertBytesFormat(String bytes) {
    //  TODO implement _assertBytesFormat
    throw UnimplementedError();
  }

  /// Deletes a document
  /// HTTP request
  /// DELETE https://firestore.googleapis.com/v1/{name=projects/*/databases/*/documents/*/**}
  static Future<void> delete(
    String name, {
    Precondition currentDocument,
    Map<String, String> headers,
  }) async {
    _assertPathFormat(name);

    final url = StringBuffer(_baseUrl)..write('/')..write(name);

    if (currentDocument != null) {
      if (currentDocument.exists != null) {
        url.write('?currentDocument.exists=${currentDocument.exists}');
      } else if (currentDocument.updateTime != null) {
        url.write(
            '?currentDocument.updateTime=${currentDocument.updateTime.toUtc().toIso8601String()}');
      }
    }

    final res = await http.delete(url.toString(), headers: headers);
    final json = jsonDecode(res.body);

    if (json['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.get',
        code: json['error']['code'].toString(),
        message: json['error']['message'],
      );
    }
  }

  /// Gets a single document.
  /// HTTP request
  /// GET https://firestore.googleapis.com/v1/{name=projects/*/databases/*/documents/*/**}
  static Future<Document> get(
    String name, {
    DocumentMask mask,
    String transaction,
    DateTime readTime,
    Map<String, String> headers,
  }) async {
    assert(transaction == null || readTime == null,
        'You should use either transaction or readTime, not both');
    _assertPathFormat(name);

    final url = StringBuffer(_baseUrl)..write('/')..write(name);
    final queryParameters = <String>[];

    // Handling query parameters
    if (mask != null) {
      queryParameters.addAll(
          mask.fieldPaths.map((fieldPath) => 'mask.fieldPaths=$fieldPath'));
    }
    if (transaction != null) _assertBytesFormat(transaction);
    if (readTime != null) {
      queryParameters.add('readTime=${readTime.toUtc().toIso8601String()}');
    }

    // Appending query parameters to URL
    if (queryParameters.isNotEmpty) {
      url
        ..write('?')
        ..writeAll(queryParameters, '&');
    }

    final res = await http.get(url.toString(), headers: headers);
    final json = jsonDecode(res.body);

    if (json['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.get',
        code: json['error']['code'],
        message: json['error']['message'],
      );
    }

    return Document.fromJson(json);
  }

  /// Lists documents.
  /// HTTP Request
  /// GET https://firestore.googleapis.com/v1/{parent=projects/*/databases/*/documents/*/**}/{collectionId}
  static Future<ListDocuments> list(
    String parent,
    String collectionId, {
    int pageSize,
    String pageToken,
    String orderBy,
    DocumentMask mask,
    bool showMissing,
    String transaction,
    DateTime readTime,
    Map<String, String> headers,
  }) async {
    assert(transaction == null || readTime == null,
        'You should use either transaction or readTime, not both');
    final path = '$parent/$collectionId';
    _assertPathFormat(path);

    final url = StringBuffer(_baseUrl)..write('/')..write(path);

    // Handling query parameters
    final queryParameters = <String>[];

    if (pageSize != null) queryParameters.add('pageSize=$pageSize');
    if (pageToken != null) queryParameters.add('pageToken=$pageToken');
    if (orderBy != null) queryParameters.add('orderBy=$orderBy');
    if (mask != null) {
      queryParameters.addAll(
          mask.fieldPaths.map((fieldPath) => 'mask.fieldPaths=$fieldPath'));
    }
    if (showMissing != null) queryParameters.add('showMissing=$showMissing');
    if (transaction != null) _assertBytesFormat(transaction);
    if (readTime != null) {
      queryParameters.add('readTime=${readTime.toUtc().toIso8601String()}');
    }

    // Appending query parameters to URL
    if (queryParameters.isNotEmpty) {
      url
        ..write('?')
        ..writeAll(queryParameters, '&');
    }

    final res = await http.get(url.toString(), headers: headers);
    final json = jsonDecode(res.body);

    if (json['error'] != null) {
      throw FirebaseException(
        plugin: 'RestAPI.list',
        code: json['error']['code'],
        message: json['error']['message'],
      );
    }

    return ListDocuments.fromJson(json);
  }
}