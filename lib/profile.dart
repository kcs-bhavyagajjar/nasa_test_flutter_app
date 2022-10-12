import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/Model/model.dart';
import 'package:test_app/list_tile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LoginModel? loginModel;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> getData = jsonDecode(preferences.getString('user')!);
    setState(
      () {
        loginModel = LoginModel.fromJson(getData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: Icon(Icons.arrow_back),
          ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 25, right: 15),
        child: ListView(
          children: [
            Text(
              "Your Profile",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "NotoSans"),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage("images/smart-city.png"),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: ListTileItem(
                fieldname: 'Firstname:',
                title: loginModel!.Firstname.toString(),
                tileColor: Colors.brown.shade50,
                Roundedcorner: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onpress: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ListTileItem(
                fieldname: 'MiddleName:',
                title: loginModel!.Middlename.toString(),
                tileColor: Colors.brown.shade50,
                Roundedcorner: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onpress: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ListTileItem(
                fieldname: 'LastName:',
                title: loginModel!.Lastname.toString(),
                tileColor: Colors.brown.shade50,
                Roundedcorner: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onpress: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ListTileItem(
                fieldname: 'Mobile:',
                title: loginModel!.mobile.toString(),
                tileColor: Colors.brown.shade50,
                Roundedcorner: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onpress: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ListTileItem(
                fieldname: 'Email:',
                title: loginModel!.email.toString(),
                tileColor: Colors.brown.shade50,
                Roundedcorner: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onpress: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ListTileItem(
                fieldname: 'Password:',
                title: loginModel!.pass.toString(),
                tileColor: Colors.brown.shade50,
                Roundedcorner: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onpress: () {},
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
