import 'package:flutter/material.dart';

Widget backGroundGradient() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        Colors.lightBlue[400],
        Colors.blue[700],
      ], stops: [
        0.0,
        1.0,
      ], begin: FractionalOffset.topLeft, end: FractionalOffset.bottomRight, tileMode: TileMode.repeated),
    ),
  );
}
