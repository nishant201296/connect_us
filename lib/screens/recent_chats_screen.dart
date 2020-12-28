import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_us/components/background_gradient.dart';
import 'package:connect_us/models/chat_model.dart';
import 'package:connect_us/utils/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connect_us/models/user_model.dart';

class RecentChatsScreen extends StatefulWidget {
  @override
  _RecentChatsScreenState createState() => _RecentChatsScreenState();
}

class _RecentChatsScreenState extends State<RecentChatsScreen> {
  User currentUser;
  UserModel currentUserModel;
  @override
  void initState() {
    super.initState();
    currentUser = firebaseAuth.currentUser;
    getDocs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backGroundGradient(),
          StreamBuilder(
            stream: fireStore.collection("users").snapshots(),
            // builder: (context, snapshot) {
            //   if (snapshot.hasData) {
            //     for (QueryDocumentSnapshot doc in snapshot.data.docs) {
            //       if (doc.data()["userId"] == currentUser.uid) {
            //         currentUserModel = UserModel(currentUser.uid, []);
            //       }
            //     }
            //   }
            // },
          )
        ],
      ),
    );
  }

  void getDocs() async {
    QuerySnapshot allDocsSnapshot = await fireStore.collection("users").get();
    createDocForUserIfDoesntExist(allDocsSnapshot.docs);

    await for (QuerySnapshot snapshot in fireStore.collection("users").snapshots()) {
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        if (doc.data()["userId"] == currentUser.uid) {
          currentUserModel = UserModel(currentUser.uid, []);
        }
      }
    }
  }

  void createDocForUserIfDoesntExist(List<QueryDocumentSnapshot> allDocs) async {
    for (QueryDocumentSnapshot doc in allDocs) {
      if (doc.data()["userId"] == currentUser.uid) {
        return;
      }
    }
    await fireStore.collection("users").add(UserModel(currentUser.uid, []).toMap());
  }
}
