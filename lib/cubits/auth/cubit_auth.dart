import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/authentication/i_auth_repository.dart';
import '../../utils/exceptions/app_exception.dart';
import 'cubit_auth_actions.dart';
import 'cubit_auth_state.dart';

class CubitAuth extends Cubit<CubitAuthState> implements CubitAuthActions {
  final IAuthRepository _authRepository;
  StreamSubscription? _authSubscription;
  CubitAuth(this._authRepository) : super(const CubitAuthState()) {
    _listenAuthChanges();
  }

  void _listenAuthChanges() {
    _authSubscription = _authRepository.authStateChanges.listen(
      (user) {
        print("AUTH CHANGE: $user");
        emit(
          state.clearError().copyWith(
            user: user,
            isInitialized: true,
            isLoading: false,
          ),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            isInitialized: true,
            isLoading: false,
            errorMessage: _handleError(error),
          ),
        );
      },
    );
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      emit(state.clearError().copyWith(isLoading: true));
      await _authRepository.login(email: email, password: password);
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: _handleError(e)));
    }
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      emit(state.clearError().copyWith(isLoading: true));
      await _authRepository.register(email: email, password: password);
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: _handleError(e)));
    }
  }

  @override
  Future<void> logout() async {
    try {
      emit(state.clearError().copyWith(isLoading: true));
      await _authRepository.logout();
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: _handleError(e)));
    }
  }

  void clearError() {
    emit(state.clearError());
  }

  String _handleError(Object error) {
    if (error is AppException) {
      return error.message;
    }
    return 'Ocorreu um erro inesperado.';
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
