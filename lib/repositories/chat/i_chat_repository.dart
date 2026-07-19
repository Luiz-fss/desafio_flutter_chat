import 'package:chat_realtime/models/chat/message_model.dart';

abstract class IChatRepository {
  Future<void> sendMessage(MessageModel message);

  Future<void> editMessage({
    required String messageId,
    required String text,
  });

  Future<void> deleteMessage({
    required String messageId,
  });

  Stream<List<MessageModel>> watchMessages();
}