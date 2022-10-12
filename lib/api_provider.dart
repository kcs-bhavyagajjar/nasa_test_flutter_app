// import 'dart:convert';
// import 'Model/imagemodel.dart';
// import 'package:dio/dio.dart';
//
// class ApiProvider {
//
//   final Dio _dio = Dio();
//   final String _url = 'https://images-api.nasa.gov/search?q=moon&page=1';
//
//
//   var counter = 0;
//
//   List<Item> itemlist = [];
//   Future<List<Item>> fetchApi() async {
//     try {
//       Response response = await _dio.get(_url);
//       if (response.statusCode == 200) {
//       itemlist = response.data["collection"]["Item"]
//             .map<Item>((json) => Item.fromJson(json))
//             .toList();
//
//         counter++;
//
//         return itemlist;
//
//         // If the server did return a 200 OK response,
//         // then parse the JSON.
//       } else {
//         // If the server did not return a 200 OK response,
//         // then throw an exception.
//         throw Exception('Failed to load album');
//       }
//
//     } catch (error, stacktrace) {
//       print("Exception occurred:."
//           " $error stackTrace: $stacktrace");
//       return Future.error('Could not load data');
//     }
//   }
// }
