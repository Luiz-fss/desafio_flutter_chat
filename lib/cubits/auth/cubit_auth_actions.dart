abstract class CubitAuthActions {

  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> register({
    required String email,
    required String password,
  });

  Future<void> logout();
}