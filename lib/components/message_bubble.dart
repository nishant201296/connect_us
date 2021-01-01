import 'package:connect_us/models/message_model.dart';
import 'package:flutter/material.dart';

Widget buildMessageBubble(MessageModel message, bool isMe) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.end,
    children: [
      Container(
        margin: isMe ? EdgeInsets.only(left: 50) : EdgeInsets.only(right: 50),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Material(
            elevation: 10.0,
            color: isMe ? Colors.lightBlue : Colors.grey,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: isMe ? Radius.circular(20) : Radius.zero,
              topRight: isMe ? Radius.zero : Radius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                message.getMessage(),
                style: TextStyle(color: isMe ? Colors.white : Colors.black, fontSize: 15),
              ),
            ),
          ),
        ),
      )
    ],
  );
}
