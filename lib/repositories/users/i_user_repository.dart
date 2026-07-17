import '../../models/user/user_model.dart';


abstract class IUsersRepository {
  Future<void> createUser(UserModel user);
  Future<UserModel?> getUser(String id);
  Future<void> updatePresence({
    required String userId,
    required bool isOnline,
  });
  Stream<List<UserModel>> watchUsers();
  Stream<List<UserModel>> watchOnlineUsers();
}