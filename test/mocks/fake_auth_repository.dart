import 'package:chat_realtime/models/authentication/auth_user_model.dart';
import 'package:chat_realtime/repositories/authentication/i_auth_repository.dart';


class FakeAuthRepository implements IAuthRepository {

  bool shouldFailLogin = false;

  AuthUserModel? currentUser;


  @override
  Stream<AuthUserModel?> get authStateChanges {
    return Stream.value(currentUser);
  }


  @override
  Future<AuthUserModel?> login({
    required String email,
    required String password,
  }) async {

    if (shouldFailLogin) {
      throw Exception('Erro ao realizar login');
    }

    currentUser = AuthUserModel(
      id: '1',
      email: email,
    );

    return currentUser;
  }


  @override
  Future<AuthUserModel?> register({
    required String email,
    required String password,
  }) async {

    currentUser = AuthUserModel(
      id: '1',
      email: email,
    );

    return currentUser;
  }


  @override
  Future<void> logout() async {
    currentUser = null;
  }

}