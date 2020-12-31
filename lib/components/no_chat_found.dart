import 'package:flutter/material.dart';

Widget noChatFound() {
  return Padding(
    padding: EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset("images/3.jpg"),
        ),
        Expanded(
          child: Text(
            "Once you create a chat with someone\n it will appear here.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
