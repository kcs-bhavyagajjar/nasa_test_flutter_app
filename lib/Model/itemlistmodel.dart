// To parse this JSON data, do
//
//     final imagemodel = imagemodelFromJson(jsonString);

import 'dart:convert';

class Imagelistmodel {
  List<String> imagemodelFromJson(String str) =>
      List<String>.from(json.decode(str).map((x) => x));

  String imagemodelToJson(List<String> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x)));
}
