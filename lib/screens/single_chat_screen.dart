import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_us/components/message_bubble.dart';
import 'package:connect_us/models/chat_model.dart';
import 'package:connect_us/models/message_model.dart';
import 'package:connect_us/models/user_model.dart';
import 'package:connect_us/utils/firebase_helper.dart';
import 'package:connect_us/utils/id_generator.dart';
import 'package:connect_us/utils/pair.dart';
import 'package:flutter/material.dart';

class SingleChat extends StatefulWidget {
  final UserModel otherGuy;
  SingleChat(this.otherGuy);
  @override
  _SingleChatState createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  String chatWithHim;
  ChatModel thisChat;

  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatWithHim = _findChatWithHim();
    // if no chat found with this user create a new chatmodel
    if (chatWithHim == null) {
      chatWithHim = generateChatId([widget.otherGuy.userId, currentUserModel.userId]);
      this.thisChat = ChatModel(
          chatWithHim, Pair<String, String>(currentUserModel.email, widget.otherGuy.email), []);
      addChat(thisChat, widget.otherGuy.userId);
    } else {
      fireStore
          .collection("chats")
          .where("chatId", isEqualTo: chatWithHim)
          .get()
          .then((QuerySnapshot snap) {
        thisChat = ChatModel.fromMap(snap.docs.first.data());
      });
    }
  }

  List<MessageModel> messages = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: StreamBuilder<QuerySnapshot>(
        stream: fireStore
            .collection("chatMessages")
            .where("chatId", isEqualTo: chatWithHim)
            .orderBy("timeStamp", descending: false)
            .snapshots(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            );
          }
          List<QueryDocumentSnapshot> messagesSnap = snapShot.data.docs.reversed.toList();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messagesSnap.length,
                  itemBuilder: (context, index) {
                    MessageModel message = MessageModel.fromMap(messagesSnap[index].data());
                    return buildMessageBubble(
                        message, message.getSender() == currentUserModel.email);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: messageController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue, width: 4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(0.0,
                              duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
                          if (messageController.value.text.isNotEmpty)
                            addMessage(
                              MessageModel(
                                  generateMessageId(this.thisChat.chatId),
                                  this.thisChat.chatId,
                                  messageController.value.text,
                                  [widget.otherGuy.email],
                                  currentUserModel.email,
                                  DateTime.now().toUtc().toIso8601String()),
                            );
                          messageController.clear();
                        },
                        child: Icon(
                          Icons.send,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      )),
    );
  }

  String _findChatWithHim() {
    for (String hisChat in widget.otherGuy.chats) {
      if (currentUserModel.chats.contains(hisChat)) return hisChat;
    }
    return null;
  }
}
