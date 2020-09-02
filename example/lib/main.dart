import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './widgets/create_document_request_card.dart';
import './widgets/get_request_card.dart';
import './widgets/list_request_card.dart';
import './widgets/patch_request_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase REST Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase REST Demo'),
      ),
      body: Firebase.apps.isNotEmpty
          ? ListView(
              children: <Widget>[
                CreateDocumentRequestCard(),
                PatchRequestCard(),
                GetRequestCard(),
                ListRequestCard(),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
