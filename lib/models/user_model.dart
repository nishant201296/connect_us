import 'chat_model.dart';

class UserModel {
  final String _userId;
  List<ChatModel> _chats = [];

  UserModel(this._userId, this._chats);

  String getUserId() {
    return this._userId;
  }

  ChatModel getChat(String chatId) {
    this._chats.forEach((element) {
      if (element.getChatId() == chatId) {
        return element;
      }
    });
    return null;
  }

  void addChat(ChatModel chat) {
    this._chats.add(chat);
  }

  Map<String, dynamic> toMap() {
    return {"userId": this._userId, "chats": this._chats};
  }
}
