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

  static void _assertTimestampFormat(String timestamp) {
    //  TODO implement _assertBytesFormat
    throw UnimplementedError();
  }

  static Future<Document> get(
    String name, {
    DocumentMask mask,
    String transaction,
    String readTime,
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
      _assertTimestampFormat(readTime);
      queryParameters.add('readTime=$readTime');
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
