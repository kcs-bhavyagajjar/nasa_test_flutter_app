import 'package:flutter/material.dart';

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
}
