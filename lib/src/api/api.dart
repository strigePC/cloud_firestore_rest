part of cloud_firestore_rest;

class RestApi {
  static void _assertNameFormat(String name) {
    assert(name != null);
    final nameFormat = RegExp(
      r'projects'
      r'\/[\w-]+'
      r'\/databases'
      r'\/[\w-()]+'
      r'\/documents'
      r'\/[\w-\/]+',
    );

    assert(
        nameFormat.hasMatch(name),
        'Input name has wrong format. '
        'It should be projects/{project_id}/databases/{database_id}/documents/{document_path}, '
        'but got $name');
  }

  static void _assertBytesFormat(String bytes) {
    //  TODO implement _assertBytesFormat
    throw UnimplementedError();
  }

  /// Gets a single document.
  /// HTTP request
  /// GET https://firestore.googleapis.com/v1/{name=projects/*/databases/*/documents/*/**}
  ///
  /// The URL uses gRPC Transcoding syntax.
  static Future<Document> get(
    String name, {
    DocumentMask mask,
    String transaction,
    DateTime readTime,
    Map<String, String> headers,
  }) async {
    _assertNameFormat(name);

    final url = StringBuffer(_baseUrl)..write('/')..write(name);
    final queryParameters = <String>[];

    if (mask != null) {
      queryParameters.addAll(
          mask.fieldPaths.map((fieldPath) => 'mask.fieldPaths=$fieldPath'));
    }
    if (transaction != null) _assertBytesFormat(transaction);
    if (readTime != null) {
      queryParameters.add('readTime=${readTime.toUtc().toIso8601String()}');
    }

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
}
