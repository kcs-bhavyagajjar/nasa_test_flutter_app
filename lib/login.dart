import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/Model/model.dart';
import 'package:test_app/navigator.dart';

class Login extends StatefulWidget {
  LoginModel? loginModel;
  late SharedPreferences sharedPreferences;
  final emailController = TextEditingController();
  final passController = TextEditingController();

  Login({Key? key, this.loginModel}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginModel? loginModel;
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool iconPassword = true;

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
        print("Email ${loginModel!.email!}");

        //Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceheight = MediaQuery.of(context).size.height;
    //final devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
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
                    radius: 16,
                  ),
                ),
              ),
              Text(
                "Log In",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 20,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: emailcontroller,
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
                          if (emailcontroller.text != loginModel!.email) {
                            return 'Email Is not Registered';
                          }
                          // Return null if the entered email is valid
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLength: 8,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        obscureText: iconPassword,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters in length';
                          }
                          if (passcontroller.text != loginModel!.pass) {
                            return 'Password Is not Registered';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                        // onChanged: (value) => _password = value,
                        controller: passcontroller,
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
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(250, 50),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            goToHomeScreen(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Login Succesfully"),
                              ),
                            );
                          } else {
                            print("Error");
                          }
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(250, 50),
                            shape: StadiumBorder(),
                            primary: Colors.grey.shade700,
                          ),
                          onPressed: () {
                            goToSignupScreen(context);
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(fontSize: 20),
                          )),
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
