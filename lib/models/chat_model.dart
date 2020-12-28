import 'package:connect_us/models/user_model.dart';

class ChatModel {
  String _chatId;
  List<UserModel> _chatParties;

  ChatModel(this._chatId, this._chatParties);

  String getChatId() {
    return this._chatId;
  }

  Map<String, dynamic> toMap() {
    return {"chatId": this._chatId, "chatParties": this._chatParties, "chatMessages": []};
  }
}
