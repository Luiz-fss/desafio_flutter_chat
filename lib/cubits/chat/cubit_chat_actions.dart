abstract class CubitChatActions {
  Future<void>sendMessage({
    required String text,
    required String senderId,
    required String senderName,
  });

  Future<void> editMessage({
    required String messageId,
    required String text,
  });

  Future<void> deleteMessage({
    required String messageId,
  });

  void watchMessages();
}