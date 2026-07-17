import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user/user_model.dart';
import '../../utils/exceptions/exception_handler.dart';
import 'i_user_repository.dart';

class FirebaseUsersRepositoryImpl implements IUsersRepository {
  final FirebaseFirestore _firestore;

  FirebaseUsersRepositoryImpl(this._firestore);

  @override
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<UserModel?> getUser(String id) async {
    try {
      final snapshot = await _firestore.collection('users').doc(id).get();
      if (!snapshot.exists) {
        return null;
      }
      final data = snapshot.data();
      if (data == null) {
        return null;
      }
      return UserModel.fromMap(snapshot.id, data);
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<void> updatePresence({
    required String userId,
    required bool isOnline,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isOnline': isOnline,
        'lastSeen': DateTime.now(),
      });
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Stream<List<UserModel>> watchUsers() {
    return _firestore
        .collection('users')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return UserModel.fromMap(doc.id, doc.data());
          }).toList();
        })
        .handleError((error) {
          throw ExceptionHandler.handle(error);
        });
  }

  @override
  Stream<List<UserModel>> watchOnlineUsers() {
    return _firestore
        .collection('users')
        .where('isOnline', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return UserModel.fromMap(doc.id, doc.data());
          }).toList();
        }).handleError((error) {
          throw ExceptionHandler.handle(error);
        });
  }
}
