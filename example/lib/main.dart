import 'package:cloud_firestore_rest/cloud_firestore_rest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase REST Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Firebase REST Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _initialize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _initialize,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //  TODO handle errors
            print(snapshot.error);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder<Document>(
                    future: RestApi.get(
                      'projects/${Firebase.app().options.projectId}/databases/(default)/documents/todos/xAJJW2WUihZfqKtUxQQf',
                      mask: DocumentMask(['title', 'meta.author']),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text(
                          'Error occurred',
                          style: TextStyle(color: Colors.red),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        print(snapshot.data.toJson());
                        return Card(
                          child: Column(
                            children: [
                              Text(snapshot.data.fields['title']
                                  ?.toJson()
                                  ?.toString()),
                              Text(snapshot.data.fields['body']
                                  ?.toJson()
                                  .toString()),
                              Text(snapshot.data.fields['meta']
                                  ?.toJson()
                                  .toString()),
                            ],
                          ),
                        );
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
