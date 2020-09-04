import 'package:cloud_firestore_rest/cloud_firestore_rest.dart';
import 'package:flutter/material.dart';

import './fields_widget.dart';

class GetDocumentsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('GET DOCUMENTS', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 8),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('todos').get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text(
                    snapshot.error.toString(),
                    style: TextStyle(color: Colors.red),
                  );
                }

                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data.docs
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

  Column _buildDocumentEntry(QueryDocumentSnapshot doc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(doc.id, style: Theme.of(context).textTheme.caption),
        SizedBox(height: 4),
        FieldsWidget(data: doc.data()),
        Divider(),
      ],
    );
  }
}
