import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './widgets/create_document_request_card.dart';
import './widgets/get_request_card.dart';
import './widgets/list_request_card.dart';

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
  final _initialize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase REST Demo'),
      ),
      body: FutureBuilder(
        future: _initialize,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //  TODO handle errors
            print(snapshot.error);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: <Widget>[
                CreateDocumentRequestCard(),
                GetRequestCard(),
                ListRequestCard(),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
