import 'dart:convert';

String generateChatId(List<String> userIds) {
  if (userIds == null || userIds.isEmpty) return "";
  String rawId = "";
  for (int i = 0; i < userIds.length - 1; i++) {
    rawId = rawId + (userIds[i] == null ? "" : userIds[i]) + ":";
  }
  rawId += userIds.last;
  return base64Encode(utf8.encode(rawId));
}

String generateMessageId(String chatId) {
  String rawId = "";
  rawId = chatId + ":" + DateTime.now().toUtc().millisecondsSinceEpoch.toString();
  return base64Encode(utf8.encode(rawId));
}
