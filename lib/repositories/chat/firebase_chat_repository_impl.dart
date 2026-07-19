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
      final doc = _messages.doc();

      final messageWithId = message.copyWith(
        id: doc.id,
      );

      await doc.set(messageWithId.toMap());
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<void> editMessage({
    required String messageId,
    required String text,
  }) async {
    try {
      await _messages.doc(messageId).update({
        'text': text,
        'editedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<void> deleteMessage({
    required String messageId,
  }) async {
    try {
      await _messages.doc(messageId).update({
        'deleted': true,
      });
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
        return MessageModel.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    })
        .handleError((error) {
      throw ExceptionHandler.handle(error);
    });
  }
}