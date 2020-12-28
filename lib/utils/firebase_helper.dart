import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_us/utils/constants.dart';
import 'package:connect_us/utils/database_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;

void addAuthChangeListener() {
  firebaseAuth.authStateChanges().listen((user) async {
    String token = await user.getIdToken();
    DataBaseHandler.setValue(Constants.USER_TOKEN, token);
  });
}
