import 'package:cloud_firestore_rest/cloud_firestore_rest.dart';
import 'package:flutter/material.dart';

class FieldsWidget extends StatelessWidget {
  final Map<String, Value> fields;

  const FieldsWidget({Key key, @required this.fields}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      widget = TextSpan(text: '"${value.stringValue}",');
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
}
