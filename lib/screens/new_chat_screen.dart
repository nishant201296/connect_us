import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_us/components/background_gradient.dart';
import 'package:connect_us/components/chat_tile.dart';
import 'package:connect_us/components/screen_wrapper.dart';
import 'package:connect_us/models/user_model.dart';
import 'package:connect_us/routes_helper.dart';
import 'package:connect_us/screens/recent_chats_screen.dart';
import 'package:connect_us/screens/single_chat_screen.dart';
import 'package:connect_us/utils/firebase_helper.dart';
import 'package:flutter/material.dart';

class NewChat extends StatefulWidget {
  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Select Contact"),
      ),
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: fireStore.collection("users").snapshots(),
          builder: (context, snapShot) {
            List<UserModel> users = [];
            if (snapShot.hasData) {
              List<QueryDocumentSnapshot> docSnap = snapShot.data.docs;
              docSnap.forEach(
                (element) {
                  UserModel user = UserModel.fromMap(element.data());
                  if (user.userId != currentUserModel.userId) users.add(user);
                },
              );
            }
            return users.isEmpty
                ? Text(
                    "No users found",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return FlatButton(
                        color: Colors.transparent,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleChat(users[index]),
                            ),
                          );
                        },
                        child: buildChatTile(
                          users[index].email,
                        ),
                      );
                    },
                  );
          },
        ),
      ],
    );
  }
}
