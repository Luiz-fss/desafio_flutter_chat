import 'package:chat_realtime/models/chat/message_model.dart';

abstract class IChatRepository {
  Future<void> sendMessage(MessageModel message);

  Stream<List<MessageModel>> watchMessages();
}