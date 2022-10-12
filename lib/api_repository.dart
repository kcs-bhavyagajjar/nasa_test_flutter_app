import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app/Model/imagemodel.dart';

class ApiRepository {
  List<Item> itemlist = [];
  final String _url = 'https://images-api.nasa.gov/search?q=moon&page=1';

  Future<List<Item>> getAll() async {
    final url = Uri.parse(_url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      itemlist = data["collection"]["Item"]
          .map<Item>((json) => Item.fromJson(json))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
