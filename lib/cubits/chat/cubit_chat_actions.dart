abstract class CubitChatActions {
  Future<void> sendMessage({
    required String text,
    required String senderId,
    required String senderName,
  });

  void watchMessages();
}