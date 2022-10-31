import 'package:flutter/material.dart';

class Imageviwer extends StatefulWidget {
  String nbj = '';

  Imageviwer(String nbj, {Key? key}) : super(key: key);

  @override
  State<Imageviwer> createState() => _ImageviewerState();
}

class _ImageviewerState extends State<Imageviwer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //child: Image.network(),
        );
  }
}
