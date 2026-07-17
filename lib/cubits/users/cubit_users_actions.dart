abstract class CubitUsersActions {
  Future<void> createUser({
    required String name,
    required String email,
    required String userId,
  });

  Future<void> updatePresence({
    required String userId,
    required bool isOnline,
  });
  Future<void> loadLoggedUser(String userId);

  void watchOnlineUsers();
  void watchUsers();
}