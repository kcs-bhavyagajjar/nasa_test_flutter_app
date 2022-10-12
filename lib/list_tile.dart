import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  String title, fieldname;
  Color? tileColor;
  ContinuousRectangleBorder Roundedcorner;
  GestureTapCallback onpress;

  ListTileItem(
      {Key? key,
      required this.title,
      required this.tileColor,
      required this.Roundedcorner,
      required this.onpress,
      required this.fieldname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(fieldname),
      shape: Roundedcorner,
      tileColor: tileColor,
      title: Text(title),
      onTap: onpress,
    );
  }
}
