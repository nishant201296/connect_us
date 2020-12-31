import 'package:flutter/material.dart';

Card buildChatTile(String chatTitle) {
  return Card(
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.red,
      ),
      title: Text(
        chatTitle,
      ),
    ),
  );
}
