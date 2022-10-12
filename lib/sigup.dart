import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/Model/model.dart';
import 'package:test_app/login.dart';

class Signup extends StatefulWidget {
  LoginModel? loginModel;

  Signup({Key? key, this.loginModel}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

enum SingingCharacter { Male, Female }

class _SignupState extends State<Signup> {
  LoginModel? loginModel;
  final email = TextEditingController();
  final pass = TextEditingController();
  final confirmpass = TextEditingController();
  final firstname = TextEditingController();
  final middlename = TextEditingController();
  final lastname = TextEditingController();
  final mobile = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool iconPassword = true;
  bool iconPassword2 = true;
  bool? _music = false;
  bool? _cricket = false;
  bool? _football = false;
  bool? _Tv = false;
  late SharedPreferences sharedPreferences;
  String _groupValue = '';
  String _singlevalue = '';

  void setData() async {
    LoginModel user = LoginModel(
      email: email.text,
      pass: pass.text,
      Firstname: firstname.text,
      Middlename: middlename.text,
      Lastname: lastname.text,
      mobile: mobile.text,
      Groupvalue: _groupValue,
      Singlevalue: _singlevalue,
    );
    sharedPreferences = await SharedPreferences.getInstance();
    String data = jsonEncode(user);
    sharedPreferences.setString('user', data);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Sign up Succesfully"),
      ),
    );
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  checkBox(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  Radio(String radio) {
    setState(() {
      _singlevalue = radio;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceheight = MediaQuery.of(context).size.height;
    final devicewidth = MediaQuery.of(context).size.width;
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
                "Sign Up",
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
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              maxLength: 20,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              controller: firstname,
                              decoration: InputDecoration(
                                hintText: "First Name",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                errorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.red),
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
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: TextFormField(
                              maxLength: 20,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              controller: middlename,
                              decoration: InputDecoration(
                                hintText: "Middle Name",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                errorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.red),
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
                              }, // onChanged: (value) => _userEmail = value,
                            ),
                          ),
                        ],
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
                          errorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
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
                          errorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
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
                      Text(
                        "Select Gender",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: RadioListTile(
                      //         title: const Text('Male'),
                      //         value: SingingCharacter.Male,
                      //         groupValue: _singlevalue,
                      //         onChanged: (String? value) {
                      //           setState(
                      //             () {
                      //               _character = value;
                      //             },
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: RadioListTile(
                      //         title: const Text('Female'),
                      //         value: SingingCharacter.Female,
                      //         groupValue: _singlevalue,
                      //         onChanged: () {
                      //           setState(
                      //             () {
                      //               _singlevalue = value;
                      //             },
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Divider(
                        height: 20,
                        thickness: 2,
                      ),
                      Text(
                        "Select Your Habits",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text("Music"),
                              value: _music,
                              onChanged: (val) {
                                setState(
                                  () {
                                    _music = val;
                                  },
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text("Cricket"),
                              value: _cricket,
                              onChanged: (val) {
                                setState(
                                  () {
                                    _cricket = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text("Football"),
                              value: _football,
                              onChanged: (val) {
                                setState(
                                  () {
                                    _football = val;
                                  },
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text("Tv"),
                              value: _Tv,
                              onChanged: (val) {
                                setState(
                                  () {
                                    _Tv = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
                          errorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
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
                          errorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
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
                      TextFormField(
                        maxLength: 8,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Confirm Password';
                          }
                          if (pass.text != confirmpass.text) {
                            return 'Not Matching to Password';
                          }
                          return null;
                        },
                        // onChanged: (value) => _password = value,
                        controller: confirmpass,
                        obscureText: iconPassword2,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          errorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              iconPassword2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                iconPassword2 = !iconPassword2;
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
                          "Sign up",
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
