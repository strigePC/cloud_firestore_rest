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
            return ListView(
              children: <Widget>[
                _buildGetRequestCard(),
                _buildListRequestCard(),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildGetRequestCard() {
    final prefix = 'projects'
        '/${Firebase.app().options.projectId}'
        '/databases/(default)/documents';

    return FutureBuilder<Document>(
      future: RestApi.get(
        '$prefix/todos/xAJJW2WUihZfqKtUxQQf',
        mask: DocumentMask(['title', 'meta.author']),
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
          return Card(
            child: Column(
              children: [
                Text('GET', style: Theme.of(context).textTheme.headline5),
                Text(snapshot.data.fields['title']?.toJson()?.toString()),
                Text(snapshot.data.fields['body']?.toJson().toString()),
                Text(snapshot.data.fields['meta']?.toJson().toString()),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildListRequestCard() {
    final prefix = 'projects'
        '/${Firebase.app().options.projectId}'
        '/databases/(default)/documents';

    return FutureBuilder<ListDocuments>(
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
          return Card(
            child: Column(
              children: [
                Text('LIST', style: Theme.of(context).textTheme.headline5),
                Column(
                  children: snapshot.data.documents
                      .map((doc) => Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(doc.fields['title']
                                          ?.toJson()
                                          ?.toString()),
                                      Text(doc.fields['body']
                                          ?.toJson()
                                          .toString()),
                                      Text(doc.fields['meta']
                                          ?.toJson()
                                          .toString()),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      RestApi.delete(doc.name);
                                    },
                                  )
                                ],
                              ),
                              Divider(),
                            ],
                          ))
                      .toList(),
                ),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
