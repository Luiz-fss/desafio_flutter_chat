import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

import 'app_exception.dart';

class ExceptionHandler {
  const ExceptionHandler._();
  static AppException handle(Object error) {
    if (error is SocketException) {
      return const AppException(
        'Sem conexão com a internet.',
      );
    }
    if (error is FirebaseException) {
      return _handleFirebaseError(error);
    }
    return const AppException(
      'Ocorreu um erro inesperado.',
    );
  }
  static AppException _handleFirebaseError(
      FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return const AppException(
          'Você não possui permissão para realizar essa ação.',
        );
      case 'unavailable':
        return const AppException(
          'Serviço temporariamente indisponível.',
        );
      case 'network-request-failed':
        return const AppException(
          'Sem conexão com a internet.',
        );
      case 'not-found':
        return const AppException(
          'Registro não encontrado.',
        );
      default:
        return const AppException(
          'Erro ao comunicar com o servidor.',
        );
    }
  }
}