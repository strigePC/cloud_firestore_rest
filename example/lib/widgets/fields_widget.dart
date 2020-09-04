import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore_rest/cloud_firestore_rest.dart';
import 'package:flutter/material.dart';

class FieldsWidget extends StatelessWidget {
  final Map<String, Value> fields;
  final Map<String, dynamic> data;

  const FieldsWidget({Key key, this.fields, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: fields != null ? _buildValues() : _buildData(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  List<TextSpan> _buildValues() {
    return fields.entries
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
        .toList();
  }

  List<TextSpan> _buildData() {
    return data.entries
        .map((field) => TextSpan(
              children: [
                TextSpan(
                  text: field.key + ': ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                _buildDataField(field.value),
                TextSpan(text: '\n'),
              ],
            ))
        .toList();
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

  InlineSpan _buildDataField(dynamic value) {
    InlineSpan widget;
    if (value is String) {
      widget = TextSpan(text: '"$value",');
    } else if (value is bool) {
      widget = TextSpan(text: '$value,');
    } else if (value is double) {
      widget = TextSpan(text: '${value.toStringAsFixed(2)},');
    } else if (value is int) {
      widget = TextSpan(text: '$value,');
    } else if (value is DateTime) {
      widget = TextSpan(text: value.toUtc().toIso8601String() + ',');
    } else if (value is Uint64List) {
      widget = TextSpan(text: base64Encode(value) + ',');
    } else if (value is List) {
      widget = TextSpan(
        children: [
          TextSpan(text: '[\n'),
          ...value
              .map((value) => _buildDataField(value))
              .expand((element) => [
                    TextSpan(text: '\t\t'),
                    element,
                    TextSpan(text: '\n'),
                  ])
              .toList(),
          TextSpan(text: '],'),
        ],
      );
    } else if (value is Map<String, dynamic>) {
      widget = TextSpan(children: [
        TextSpan(text: '{\n'),
        ...value.entries
            .map((field) => TextSpan(
                  children: [
                    TextSpan(
                      text: field.key + ': ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    _buildDataField(field.value),
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
      widget = TextSpan(text: value.toString());
    }
    return widget;
  }
}
