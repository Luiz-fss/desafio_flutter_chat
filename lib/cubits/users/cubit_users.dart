import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user/user_model.dart';
import '../../repositories/users/i_user_repository.dart';
import '../../utils/exceptions/app_exception.dart';
import 'cubit_users_actions.dart';
import 'cubit_users_state.dart';

class CubitUsers extends Cubit<CubitUsersState>
    implements CubitUsersActions {

  final IUsersRepository _usersRepository;

  StreamSubscription<List<UserModel>>? _usersSubscription;

  CubitUsers(this._usersRepository)
      : super(const CubitUsersState());

  @override
  Future<void> createUser({
    required String name,
    required String email,
    required String userId,
  }) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      );
      await _usersRepository.createUser(
        UserModel(
          id: userId,
          name: name,
          email: email,
          isOnline: true,
          lastSeen: DateTime.now(),
        ),
      );
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: _handleError(e),
        ),
      );
    }
  }

  @override
  Future<void> loadLoggedUser(String userId) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      );
      final user = await _usersRepository.getUser(userId);
      emit(
        state.copyWith(
          loggedUser: user,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: _handleError(e),
        ),
      );
    }
  }

  @override
  Future<void> updatePresence({
    required String userId,
    required bool isOnline,
  }) async {
    try {
      await _usersRepository.updatePresence(
        userId: userId,
        isOnline: isOnline,
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: _handleError(e),
        ),
      );
    }
  }

  @override
  void watchOnlineUsers() {
    _startUsersListener(
      _usersRepository.watchOnlineUsers(),
    );
  }

  @override
  void watchUsers() {
    _startUsersListener(
      _usersRepository.watchUsers(),
    );
  }

  void _startUsersListener(
      Stream<List<UserModel>> stream,
      ) {
    _usersSubscription?.cancel();
    _usersSubscription = stream.listen(
          (users) {
        emit(
          state.copyWith(
            users: users,
          ),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            errorMessage: _handleError(error),
          ),
        );
      },
    );
  }

  String _handleError(Object error) {
    if (error is AppException) {
      return error.message;
    }
    return 'Ocorreu um erro inesperado.';
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }
}