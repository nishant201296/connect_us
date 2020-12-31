import 'package:connect_us/utils/firebase_helper.dart';
import 'package:connect_us/utils/pair.dart';

class ChatModel {
  final String chatId;
  final Pair<String, String> chatParties;
  List<String> chatMessages;
  String chatTitle;

  ChatModel(this.chatId, this.chatParties, this.chatMessages) {
    chatParties.first == currentUserModel.email
        ? this.chatTitle = chatParties.second
        : this.chatTitle = chatParties.first;
  }

  Map<String, dynamic> toMap() => {
        "chatId": this.chatId,
        "chatParties": _getChatParties(),
        "chatMessages": this.chatMessages == null ? [] : [...this.chatMessages]
      };

  List<String> _getChatParties() {
    return [this.chatParties.first, this.chatParties.second];
  }

  static ChatModel fromMap(Map<String, dynamic> map) {
    String chatId = map["chatId"];
    List<String> chatPartiesString = map["chatParties"].cast<String>();
    Pair<String, String> pair =
        Pair<String, String>(chatPartiesString.first, chatPartiesString.last);
    List<String> messages = map["chatMessages"].cast<String>();
    return ChatModel(chatId, pair, messages);
  }
}
