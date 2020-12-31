class UserModel {
  final String userId;
  List<String> chats;
  final String email;

  UserModel(this.userId, this.email, this.chats);

  Map<String, dynamic> toMap() => {
        "userId": this.userId,
        "email": this.email,
        "chats": this.chats == null ? [] : [...chats],
      };

  static UserModel fromMap(Map<String, dynamic> map) {
    String userId = map["userId"];
    List<String> chats = map["chats"].cast<String>();
    String email = map["email"];
    return UserModel(userId, email, chats);
  }
}
