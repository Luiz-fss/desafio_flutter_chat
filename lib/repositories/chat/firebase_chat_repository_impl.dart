import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat/message_model.dart';
import '../../utils/exceptions/exception_handler.dart';
import 'i_chat_repository.dart';

class FirebaseChatRepositoryImpl implements IChatRepository {
  final FirebaseFirestore _firestore;

  FirebaseChatRepositoryImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _messages =>
      _firestore.collection('messages');

  @override
  Future<void> sendMessage(MessageModel message) async {
    try {
      await _messages.add(message.toMap());
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Stream<List<MessageModel>> watchMessages() {
    return _messages
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return MessageModel.fromMap(doc.id, doc.data());
          }).toList();
        })
        .handleError((error) {
          throw ExceptionHandler.handle(error);
        });
  }
}
