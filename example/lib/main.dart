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
                  return _buildFields(snapshot.data.fields);
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

  Widget _buildFields(Map<String, Value> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: fields.entries
                .map((field) => TextSpan(
                      children: [
                        TextSpan(
                          text: field.key + ': ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        _buildField(field.value),
                        TextSpan(text: '\n'),
                      ],
                    ))
                .toList(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  InlineSpan _buildField(Value value) {
    InlineSpan widget;
    if (value.stringValue != null) {
      widget = TextSpan(text: value.stringValue + ',');
    } else if (value.booleanValue != null) {
      widget = TextSpan(text: '${value.booleanValue},');
    } else if (value.doubleValue != null) {
      widget = TextSpan(text: '${value.doubleValue},');
    } else if (value.integerValue != null) {
      widget = TextSpan(text: value.integerValue + ',');
    } else if (value.timestampValue != null) {
      widget = TextSpan(text: value.timestampValue + ',');
    } else if (value.bytesValue != null) {
      widget = TextSpan(text: value.bytesValue + ',');
    } else if (value.arrayValue != null) {
      widget = TextSpan(
        children: [
          TextSpan(text: '[\n'),
          ...value.arrayValue.values
              .map((value) => _buildField(value))
              .expand((element) => [
                    TextSpan(text: '\t\t'),
                    element,
                    TextSpan(text: '\n'),
                  ])
              .toList(),
          TextSpan(text: '],'),
        ],
      );
    } else if (value.mapValue != null) {
      widget = TextSpan(children: [
        TextSpan(text: '{\n'),
        ...value.mapValue.fields.entries
            .map((field) => TextSpan(
                  children: [
                    TextSpan(
                      text: field.key + ': ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    _buildField(field.value),
                  ],
                ))
            .expand((element) => [
                  TextSpan(text: '\t\t'),
                  element,
                  TextSpan(text: '\n'),
                ])
            .toList(),
        TextSpan(text: '},'),
      ]);
    } else {
      widget = TextSpan(text: value.toJson().toString());
    }
    return widget;
  }

  Widget _buildListRequestCard() {
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
                        .map((doc) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildFields(doc.fields),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () => RestApi.delete(doc.name),
                                )
                              ],
                            ))
                        .expand((element) => [element, Divider()])
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
}
