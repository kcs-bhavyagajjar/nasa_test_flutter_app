import 'package:flutter/material.dart';
import 'package:test_app/edit_profile.dart';
import 'package:test_app/home.dart';
import 'package:test_app/privacypolicy.dart';
import 'package:test_app/profile.dart';
import 'package:test_app/sigup.dart';
import 'package:test_app/user_detail.dart';

import 'login.dart';

goToLoginScreen(BuildContext context) {
  pushedScreen(context, Login());
}

goToSignupScreen(BuildContext context) {
  pushedScreen(context, Signup());
}

// goToHomeScreen(BuildContext context,LoginModel loginModel) {
//    pushedScreen(context, Home(loginModel: loginModel));
// }

goToHomeScreen(BuildContext context) {
  pushedScreen(context, Home());
}

goToProfileScreen(BuildContext context) {
  pushedScreen(context, Profile());
}

goToEditProfileScreen(BuildContext context) {
  pushedScreen(context, Edit_Profile());
}

goToPrivacyScreen(BuildContext context) {
  pushedScreen(context, PrivacyPolicy());
}

goToUserDetailScreen(BuildContext context) {
  pushedScreen(context, UserDetail());
}

pushedScreen(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
