import 'package:cloud_firestore_rest/cloud_firestore_rest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './fields_widget.dart';

class ListRequestCard extends StatelessWidget {
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
            Text('LIST', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 8),
            FutureBuilder<ListDocuments>(
              future: RestApi.list(
                prefix,
                'todos',
                mask: DocumentMask(['title', 'body']),
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data.documents
                        .map((doc) => _buildDocumentEntry(doc, context))
                        .toList(),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Column _buildDocumentEntry(Document doc, BuildContext context) {
    return Column(
      children: [
        Text(doc.name, style: Theme.of(context).textTheme.caption),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FieldsWidget(fields: doc.fields),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () async {
                try {
                  await RestApi.delete(doc.name);
                } on FirebaseException catch (e) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(e.message),
                    ),
                  );
                }
              },
            )
          ],
        ),
        Divider(),
      ],
    );
  }
}
