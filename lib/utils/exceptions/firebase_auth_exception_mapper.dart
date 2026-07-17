import 'package:firebase_auth/firebase_auth.dart';

import 'app_exception.dart';

class FirebaseAuthExceptionMapper {
  const FirebaseAuthExceptionMapper._();

  static AppException map(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-credential':
      case 'user-not-found':
      case 'wrong-password':
        return const AppException(
          'E-mail ou senha inválidos.',
        );

      case 'email-already-in-use':
        return const AppException(
          'Este e-mail já está cadastrado.',
        );

      case 'network-request-failed':
        return const AppException(
          'Sem conexão com a internet.',
        );

      case 'too-many-requests':
        return const AppException(
          'Muitas tentativas. Tente novamente em alguns minutos.',
        );

      default:
        return const AppException(
          'Ocorreu um erro inesperado.',
        );
    }
  }
}