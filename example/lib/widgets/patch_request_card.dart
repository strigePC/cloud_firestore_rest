import 'package:cloud_firestore_rest/cloud_firestore_rest.dart';
import 'package:example/widgets/fields_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PatchRequestCard extends StatefulWidget {
  @override
  _PatchRequestCardState createState() => _PatchRequestCardState();
}

class _PatchRequestCardState extends State<PatchRequestCard> {
  var loading = true;
  var updating = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  String name = '';
  String title = '';
  String body = '';
  Document updatedDocument;

  @override
  void initState() {
    super.initState();
    final prefix = 'projects'
        '/${Firebase.app().options.projectId}'
        '/databases/(default)/documents';

    RestApi.get(
      '$prefix/todos/sRdEBPyod3jQsZsuT5Yb',
      mask: DocumentMask(['title', 'body']),
    ).then((document) {
      titleController.text = document.fields['title'].stringValue;
      bodyController.text = document.fields['body'].stringValue;

      setState(() {
        name = document.name;
        title = titleController.text;
        body = bodyController.text;
        loading = false;
      });
    });
  }

  Future<void> onUpdateTodo() async {
    final prefix = 'projects'
        '/${Firebase.app().options.projectId}'
        '/databases/(default)/documents';
    setState(() {
      updating = true;
    });

    try {
      title = titleController.text;
      body = bodyController.text;

      final result = await RestApi.patch(
        '$prefix/todos/sRdEBPyod3jQsZsuT5Yb',
        body: Document(fields: {
          'title': Value(stringValue: title.trim()),
          'body': Value(stringValue: body.trim()),
        }),
        updateMask: DocumentMask(['title', 'body']),
        mask: DocumentMask(['title', 'body']),
      );

      setState(() {
        updatedDocument = result;
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
        updating = false;
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
            Text('PATCH', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 8),
            if (!loading)
              _buildCard()
            else
              Center(child: CircularProgressIndicator()),
            if (!updating && updatedDocument != null)
              FieldsWidget(fields: updatedDocument.fields)
            else
              Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: Theme.of(context).textTheme.caption),
        SizedBox(height: 8),
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            icon: Icon(Icons.title),
            isDense: true,
            border: OutlineInputBorder(),
            hintText: 'Title',
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: bodyController,
          decoration: InputDecoration(
            icon: Icon(Icons.short_text),
            isDense: true,
            border: OutlineInputBorder(),
            hintText: 'Body',
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: RaisedButton(
            child: Text('Update Todo'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: updating || title.trim().isEmpty || body.trim().isEmpty
                ? null
                : onUpdateTodo,
          ),
        ),
      ],
    );
  }
}
