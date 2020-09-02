import 'package:cloud_firestore_rest/cloud_firestore_rest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './fields_widget.dart';

class GetRequestCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefix = 'projects'
        '/${Firebase.app().options.projectId}'
        '/databases/(default)/documents';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('GET', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 8),
            FutureBuilder<Document>(
              future: RestApi.get(
                '$prefix/todos/sRdEBPyod3jQsZsuT5Yb',
                mask: DocumentMask(['title', 'meta.author', 'bullets']),
                readTime: DateTime.now(),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text(
                    'Error occurred: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return FieldsWidget(fields: snapshot.data.fields);
                }
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
