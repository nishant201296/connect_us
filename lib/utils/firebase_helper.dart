import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_us/models/chat_model.dart';
import 'package:connect_us/models/message_model.dart';
import 'package:connect_us/models/user_model.dart';
import 'package:connect_us/utils/constants.dart';
import 'package:connect_us/utils/database_handler.dart';
import 'package:connect_us/utils/pair.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;
UserModel currentUserModel;

void addAuthChangeListener() {
  firebaseAuth.authStateChanges().listen((user) async {
    String token = await user.getIdToken();
    DataBaseHandler.setValue(Constants.USER_TOKEN, token);
  });
}

// TODO: add new chat and new message id on first position
void addChat(ChatModel chat, String otherGuysId) async {
  // adding a new chat document
  await fireStore.collection("chats").add(chat.toMap());

  // updating current user's document by adding new chat id
  _updateUserChats(chat.chatId, currentUserModel.userId);
  // updating other user's document by adding new chat id
  _updateUserChats(chat.chatId, otherGuysId);
}

void _updateUserChats(String chatId, String userId) async {
  QuerySnapshot usersSnap =
      await fireStore.collection("users").where("userId", isEqualTo: userId).get();
  List<String> updatedChats = usersSnap.docs.first.data()["chats"].cast<String>();
  updatedChats.add(chatId);
  fireStore.collection("users").doc(usersSnap.docs.first.id).update({"chats": updatedChats});
}

void addMessage(MessageModel message) async {
  // adding a new message document
  await fireStore.collection("chatMessages").add(message.toMap());

// update chat by adding the new message id
  QuerySnapshot chatSnap =
      await fireStore.collection("chats").where("chatId", isEqualTo: message.getChatId()).get();
  List<String> updatedMessages = chatSnap.docs.first.data()["chatMessages"].cast<String>();
  updatedMessages.add(message.getMessageId());
  fireStore
      .collection("chats")
      .doc(chatSnap.docs.first.id)
      .update({"chatMessages": updatedMessages});
}
