class MessageModel {
  final String _messageId;
  final String _chatId;
  final String _message;
  final String _sender;
  final String _timeStamp;
  final List<String> _recipients;

  MessageModel(this._messageId, this._chatId, this._message, this._recipients, this._sender,
      this._timeStamp);

  String getMessageId() => this._messageId;
  String getChatId() => this._chatId;
  String getMessage() => this._message;
  String getSender() => this._sender;
  String getTimeStamp() => this._timeStamp;
  List<String> getRecipients() => this._recipients == null ? [] : [...this._recipients];

  Map<String, dynamic> toMap() {
    return {
      "messageId": this._messageId,
      "chatId": this._chatId,
      "message": this._message,
      "sender": this._sender,
      "timeStamp": this._timeStamp,
      "recipients": this._recipients == null ? [] : [...this._recipients]
    };
  }

  static MessageModel fromMap(Map<String, dynamic> map) {
    String messageId = map["messageId"];
    String chatId = map["chatId"];
    String message = map["message"];
    String sender = map["sender"];
    String timeStamp = map["timeStamp"];
    List<String> recipients = map["recipients"].cast<String>();
    return MessageModel(messageId, chatId, message, recipients, sender, timeStamp);
  }
}
