import 'package:firebase_auth/firebase_auth.dart';

import '../../models/authentication/auth_user_model.dart';
import '../../utils/exceptions/exception_handler.dart';
import '../../utils/exceptions/firebase_auth_exception_mapper.dart';
import 'i_auth_repository.dart';

class FirebaseAuthRepositoryImpl implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepositoryImpl(this._firebaseAuth);

  @override
  Stream<AuthUserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(
          (user) {
        if (user == null) {
          return null;
        }

        return AuthUserModel.fromFirebaseUser(user);
      },
    );
  }

  @override
  Future<AuthUserModel?> register({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user == null
          ? null
          : AuthUserModel.fromFirebaseUser(result.user!);

    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionMapper.map(e);

    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }


  @override
  Future<AuthUserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user == null
          ? null
          : AuthUserModel.fromFirebaseUser(result.user!);

    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionMapper.map(e);

    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }


  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();

    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionMapper.map(e);

    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }
}