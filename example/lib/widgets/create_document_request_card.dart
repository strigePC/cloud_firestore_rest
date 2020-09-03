import 'package:cloud_firestore_rest/cloud_firestore_rest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './fields_widget.dart';

class CreateDocumentRequestCard extends StatefulWidget {
  @override
  _CreateDocumentRequestCardState createState() =>
      _CreateDocumentRequestCardState();
}

class _CreateDocumentRequestCardState extends State<CreateDocumentRequestCard> {
  String title = '';
  String body = '';
  var loading = false;
  Document last;

  Future<void> onCreateTodo() async {
    setState(() {
      loading = true;
    });

    try {
      final result = await RestApi.createDocument(
        'todos',
        body: Document(fields: {
          'title': Value(stringValue: title.trim()),
          'body': Value(stringValue: body.trim()),
        }),
      );

      setState(() {
        last = result;
        title = '';
        body = '';
      });
    } on FirebaseException catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.message),
        ),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CREATE DOCUMENT',
                style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.title),
                isDense: true,
                border: OutlineInputBorder(),
                hintText: 'Title',
              ),
              onChanged: (title) => setState(() {
                this.title = title;
              }),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.short_text),
                isDense: true,
                border: OutlineInputBorder(),
                hintText: 'Body',
              ),
              onChanged: (body) => setState(() {
                this.body = body;
              }),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                child: Text('Create Todo'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed:
                    loading || title.trim().isEmpty || body.trim().isEmpty
                        ? null
                        : onCreateTodo,
              ),
            ),
            if (last != null && !loading) FieldsWidget(fields: last.fields),
            if (loading)
              Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
