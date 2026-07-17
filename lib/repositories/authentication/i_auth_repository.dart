
import '../../models/authentication/auth_user_model.dart';

abstract class IAuthRepository {
  Future<AuthUserModel?> register({
    required String email,
    required String password,
  });

  Future<AuthUserModel?> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Stream<AuthUserModel?> get authStateChanges;
}