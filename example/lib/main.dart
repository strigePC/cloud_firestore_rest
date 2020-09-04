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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Firebase REST Demo'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.http), text: 'REST API'),
              Tab(icon: Icon(Icons.cloud_circle), text: 'Cloud Firestore')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Firebase.apps.isNotEmpty
                ? ListView(
                    children: <Widget>[
                      CreateDocumentRequestCard(),
                      PatchRequestCard(),
                      GetRequestCard(),
                      ListRequestCard(),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
            Firebase.apps.isNotEmpty
                ? ListView(
                    children: <Widget>[
                      Text('Hello'),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
