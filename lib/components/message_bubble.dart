import 'package:connect_us/models/message_model.dart';
import 'package:flutter/material.dart';

Container buildMessageBubble(MessageModel message, bool isMe) {
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.end,
      children: [
        Text(message.getMessage()),
      ],
    ),
  );
}
