import 'package:flutter/material.dart';
import 'package:test_app/Model/model_api.dart';

class UserDetail extends StatefulWidget {
  User? user;

  UserDetail({Key? key, this.user}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  Future<User>? _future;

  // Future<user>? _future;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name.toString());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
