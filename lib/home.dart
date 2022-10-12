import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/model.dart';
import 'package:test_app/Model/model_api.dart';
import 'package:test_app/api_repository.dart';
import 'package:test_app/cubit.dart';
import 'package:test_app/displayapi.dart';
import 'package:test_app/smtlogin.dart';

void main() {
  runApp(Home());
}

Future<User> createAlbum(String name, String job) async {
  final response = await http.post(
    Uri.parse('https://reqres.in/api/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'job': job,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Future<user>? _futureAlbum;
  LoginModel? loginModel;
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  late List data;
  List imagesUrl = [];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screen = [
    SmtLogin(),
  ];

  @override
  Widget build(BuildContext context) {
    //final deviceheight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LoginCubit(ApiRepository()),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: DisplayApi()),

      //   DefaultTabController(
      // length: 3,
      // child: Scaffold(
      //   appBar: AppBar(
      //     title: Text("home"),
      //     // bottom: TabBar(
      //     //   tabs: [
      //     //     Tab(icon: Icon(Icons.flight)),
      //     //     Tab(icon: Icon(Icons.directions_transit)),
      //     //     Tab(icon: Icon(Icons.directions_car)),
      //     //   ],
      //     // ),
      //   ),
      //   drawer: Drawer(
      //     child: ListView(
      //       children: [
      //         const UserAccountsDrawerHeader(
      //           currentAccountPicture: CircleAvatar(
      //             foregroundImage: AssetImage("images/smart-city.png"),
      //             backgroundColor: Colors.white,
      //           ),
      //           accountEmail: Text("support@gmail.com"),
      //           accountName: Text("Bhavya"),
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.home),
      //           title: Text("Home"),
      //           onTap: () {
      //             goToHomeScreen(context);
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.person),
      //           title: Text("Profile"),
      //           onTap: () {
      //             goToProfileScreen(context);
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.person),
      //           title: Text("Edit Profile"),
      //           onTap: () {
      //             goToEditProfileScreen(context);
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.privacy_tip),
      //           title: Text("Privacy Policy"),
      //           onTap: () {
      //             goToPrivacyScreen(context);
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.logout),
      //           title: Text("Log out"),
      //           onTap: () async {
      //             SharedPreferences preference =
      //                 await SharedPreferences.getInstance();
      //             preference.remove('user');
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => Login(),
      //               ),
      //             );
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.logout),
      //           title: Text("Date Picker"),
      //           onTap: () async {
      //             SharedPreferences preference =
      //                 await SharedPreferences.getInstance();
      //             preference.remove('user');
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => DatePicker(),
      //               ),
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      //   body: screen[_selectedIndex],
      //   // TabBarView(
      //   //   children: [
      //   //     DatePicker(),
      //   //     Edit_Profile(),
      //   //     PrivacyPolicy(),
      //   //   ],
      //   // ),
      //   bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: _selectedIndex,
      //     selectedItemColor: Colors.white,
      //     backgroundColor: Colors.blue,
      //     unselectedItemColor: Colors.white70,
      //     onTap: (index) => setState(() => _selectedIndex = index),
      //     items: [
      //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'date',),
      //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'profile'),
      //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'privacy policy'),
      //     ],
      //
      //   ),
      // ),
      // ),
    );
  }
}
