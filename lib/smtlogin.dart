import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/loginreqmodel.dart';
import 'package:test_app/Model/loginresponse.dart';

class SmtLogin extends StatefulWidget {
  const SmtLogin({Key? key}) : super(key: key);

  @override
  State<SmtLogin> createState() => _State();
}

class _State extends State<SmtLogin> {
  LoginRequestModel? loginReqModel;
  bool isLoading = false;

  Future onValidationAndApiCall(map) async {
    await doLogin(map);
  }

  Future<String> doLogin(Map map) async {
    try {
      var res = await http
          .post(
              Uri.parse(
                  'https://api-stage.smttown.com/api/MobileUserAPI/MemberLoginV2'),
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(map))
          .timeout(const Duration(minutes: 1));
      print(Uri.parse(
          'https://api-stage.smttown.com/api/MobileUserAPI/MemberLoginV2'));
      print(jsonEncode(map));
      if (mounted) {
        var data = json.decode(res.body);
        print(res.body);
        if (data["ApiStatusCode"] == 200) {
          Map<String, dynamic> json = jsonDecode(res.body);
          var loginResponse = LoginResponse.fromJson(json);
        } else {
          CommonMethod.ackAlert(context, data["ApiMessage"]);
        }
      }
    } on TimeoutException catch (_) {
      setState(() {
        isLoading = false;
      });
    }

    return "Success!";
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var username = new TextEditingController();
  var password = new TextEditingController();
  var mobileNumber = new TextEditingController();
  bool? _passwordVisible;
  final GlobalKey<FormState> _formKeyForgotPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   FlavorConfig.instance.values.appLogo,
                    //   scale: 3,
                    //   fit: BoxFit.cover,
                    // ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        ///Textfield UserName
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20.0, right: 20.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: CommonMethod.decorationOfContainer(),
                            child: TextFormField(
                              decoration: CommonMethod.decorationOfTextFiled(
                                  "Username"),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: username,
                            ),
                          ),
                        ),

                        ///Textfield Password
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 20.0, right: 20.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: CommonMethod.decorationOfContainer(),
                            child: TextFormField(
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF4e579b), width: 1.20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFFFFFFF), width: 1.20),
                                ),
                                hintText: "PASSWORD",
                                hintStyle: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                                isDense: true,
                                counterText: '',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              obscureText: !_passwordVisible!,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                              controller: password,
                            ),
                          ),
                        ),
                        //Login Button
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 20.0, right: 20.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: commonButtonGradient(),
                              child: TextButton(
                                child: Text(
                                  "SIGN_IN".toUpperCase(),
                                ),
                                onPressed: () async {
                                  //gotoPropertyList(context);
                                  onValidationAndApiCall(context);
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Decoration commonButtonGradient() {
  return BoxDecoration(
    color: Colors.red,
    //border: new Border.all(color: Colors.white, width: 2.0),
  );
}

class CommonMethod {
  static BoxDecoration decorationOfContainer() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color(0xFFDBE1F0), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.purple.withOpacity(0.4),
            blurRadius: 5.0,
            offset: Offset(0, 5))
      ],
    );
  }

  static InputDecoration decorationOfTextFiled(String hint) {
    return InputDecoration(
        //contentPadding: const EdgeInsets.all(8.0),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF4e579b), width: 1.20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFFFFFF), width: 1.20),
        ),
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.w400),
        counterText: "");
  }

  static ackAlert(BuildContext context, String str) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          contentText: str,
          actions: [
            InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                Navigator.of(context).pop();
              },
              child: Container(
                width: 100,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  "OK".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
