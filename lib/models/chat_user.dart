// add userID and chatID to ChatUser class
class ChatUser {
  String name;
  String messageText;
  String imageUrl;
  String time;
  String chatId;
  String? userId; //the user's own id
  List<String> otherUsers = []; //to hold the ids of other users

  ChatUser(
      {required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.chatId,
      required this.userId,
      required List<String> otherUsers});
}
