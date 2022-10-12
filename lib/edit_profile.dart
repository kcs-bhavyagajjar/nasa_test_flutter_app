import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/Model/model.dart';

class Edit_Profile extends StatefulWidget {
  LoginModel? loginModel;

  Edit_Profile({Key? key, this.loginModel}) : super(key: key);

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

enum SingingCharacter { Male, Female }

class _Edit_ProfileState extends State<Edit_Profile> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final confirmpass = TextEditingController();
  final firstname = TextEditingController();
  final middlename = TextEditingController();
  final lastname = TextEditingController();
  final mobile = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool iconPassword = true;
  bool? _checkBox = false;
  SingingCharacter? _character = SingingCharacter.Male;

  late SharedPreferences sharedPreferences;

  void setData() async {
    LoginModel user = LoginModel(
      email: email.text,
      pass: pass.text,
      Firstname: firstname.text,
      Middlename: middlename.text,
      Lastname: lastname.text,
      mobile: mobile.text,
    );
    print("$middlename");
    sharedPreferences = await SharedPreferences.getInstance();
    String data = jsonEncode(user);
    sharedPreferences.setString('user', data);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Profile Updated"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 70),
                height: deviceheight * 0.30,
                child: FittedBox(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/smart-city.png"),
                    radius: 10,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Edit Your Profile",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 20,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: firstname,
                        decoration: InputDecoration(
                          hintText: "First Name",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your First Name';
                          }
                          if (!RegExp(r'^[A-Za-z]+$').hasMatch(value)) {
                            return "Please Enter Valid First Name";
                          }
                          return null;
                        },
                        // onChanged: (value) => _userEmail = value,
                      ),
                      TextFormField(
                        maxLength: 20,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: middlename,
                        decoration: InputDecoration(
                          hintText: "Middle Name",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter your Middle name';
                          }
                          if (!RegExp(r'^[A-Za-z]+$').hasMatch(value)) {
                            return "Please Enter Valid Middle Name";
                          }
                          return null;
                        },
                        // onChanged: (value) => _userEmail = value,
                      ),
                      TextFormField(
                        maxLength: 20,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: lastname,
                        decoration: InputDecoration(
                          hintText: "Last Name",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your Last name';
                          }
                          if (!RegExp(r'^[A-Za-z]+$').hasMatch(value)) {
                            return "Please Enter Valid Last Name";
                          }
                          return null;
                        },
                        //onChanged: (value) => _userEmail = value,
                      ),
                      TextFormField(
                        maxLength: 10,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: mobile,
                        decoration: InputDecoration(
                          hintText: "Mobile",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your Mobile Number';
                          }
                          if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                              .hasMatch(value)) {
                            return "Enter 10 digit Mobile Number";
                          }
                          return null;
                        },
                        //onChanged: (value) => _userEmail = value,
                      ),
                      // Text("Select Gender",style: TextStyle(fontSize: 15),),
                      // ListTile(
                      //   title: const Text('Male'),
                      //   leading: Radio<SingingCharacter>(
                      //     value: SingingCharacter.Male,
                      //     groupValue: _character,
                      //     onChanged: (SingingCharacter? value) {
                      //       setState(
                      //             () {
                      //           _character = value;
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                      // ListTile(
                      //   title: const Text('Female'),
                      //   leading: Radio<SingingCharacter>(
                      //     value: SingingCharacter.Female,
                      //     groupValue: _character,
                      //     onChanged: (SingingCharacter? value) {
                      //       setState(
                      //             () {
                      //           _character = value;
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                      TextFormField(
                        maxLength: 20,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: email,
                        decoration: InputDecoration(
                          hintText: "Email",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter your Email address';
                          }
                          // Check if the entered email has the right format
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          // Return null if the entered email is valid
                          return null;
                        },
                      ),
                      TextFormField(
                        maxLength: 8,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        obscureText: iconPassword,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Password';
                          }
                          if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters in length';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                        // onChanged: (value) => _password = value,
                        controller: pass,
                        decoration: InputDecoration(
                          hintText: "Password",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              iconPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                iconPassword = !iconPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(300, 50),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setData();
                          } else {
                            print("Error");
                          }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
