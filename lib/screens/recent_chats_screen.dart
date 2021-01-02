import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_us/components/background_gradient.dart';
import 'package:connect_us/components/chat_tile.dart';
import 'package:connect_us/components/no_chat_found.dart';
import 'package:connect_us/components/screen_wrapper.dart';
import 'package:connect_us/models/chat_model.dart';
import 'package:connect_us/routes_helper.dart';
import 'package:connect_us/screens/single_chat_screen.dart';
import 'package:connect_us/utils/firebase_helper.dart';
import 'package:connect_us/utils/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connect_us/models/user_model.dart';

class RecentChatsScreen extends StatefulWidget {
  @override
  _RecentChatsScreenState createState() => _RecentChatsScreenState();
}

class _RecentChatsScreenState extends State<RecentChatsScreen> {
  User currentUser;
  @override
  void initState() {
    super.initState();
    currentUser = firebaseAuth.currentUser;
    currentUserModel = UserModel(currentUser.uid, currentUser.email, []);
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Your Chats"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesHelper.NEW_CHAT);
        },
        child: Icon(Icons.add),
      ),
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: fireStore
              .collection("chats")
              .where("chatParties", arrayContains: currentUserModel.email)
              .snapshots(),
          builder: (context, snapshot) {
            List<Widget> chatTiles = [];
            List<ChatModel> chats = [];
            if (snapshot.hasData) {
              for (QueryDocumentSnapshot chatDoc in snapshot.data.docs) {
                Map<String, dynamic> chat = chatDoc.data();
                ChatModel chatModel = ChatModel.fromMap(chat);
                currentUserModel.chats.add(chatModel.chatId);
                chats.add(chatModel);
                chatTiles.add(buildChatTile(chatModel.chatTitle));
              }
            }
            return chatTiles.isEmpty
                ? Text(
                    "Once you create a chat with someone,\n it will appear here.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: chatTiles.length,
                    itemBuilder: (context, index) {
                      return FlatButton(
                          color: Colors.transparent,
                          onPressed: () {
                            String otherGuysEmail =
                                chats[index].chatParties.first == currentUserModel.email
                                    ? chats[index].chatParties.second
                                    : chats[index].chatParties.first;
                            fireStore
                                .collection("users")
                                .where("email", isEqualTo: otherGuysEmail)
                                .get()
                                .then((QuerySnapshot snap) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleChat(
                                    UserModel.fromMap(snap.docs.first.data()),
                                  ),
                                ),
                              );
                            });
                          },
                          child: chatTiles[index]);
                    },
                  );
          },
        ),
      ],
    );
  }

  void initUser() async {
    QuerySnapshot usersCollectionSnap = await fireStore
        .collection("users")
        .where(
          "userId",
          isEqualTo: currentUser.uid,
        )
        .get();

    // if user already found stop proceeding and populate current user.
    if (usersCollectionSnap.docs.length == 1) {
      currentUserModel = UserModel.fromMap(usersCollectionSnap.docs.first.data());
      return;
    }

    // if user not found create a new user doc
    await fireStore.collection("users").add(currentUserModel.toMap());
  }
}
