// To parse this JSON data, do
//
//     final listmodel = listmodelFromJson(jsonString);

import 'dart:convert';

List<String> listmodelFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String listmodelToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
