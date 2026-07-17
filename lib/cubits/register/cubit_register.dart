import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user/user_model.dart';
import '../../repositories/authentication/i_auth_repository.dart';
import '../../repositories/users/i_user_repository.dart';
import '../../utils/exceptions/app_exception.dart';

import 'cubit_register_actions.dart';
import 'cubit_register_state.dart';

class CubitRegister extends Cubit<CubitRegisterState>
    implements CubitRegisterActions {

  final IAuthRepository _authRepository;
  final IUsersRepository _usersRepository;

  CubitRegister(
      this._authRepository,
      this._usersRepository,
      ) : super(const CubitRegisterState());
  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      );
      final user = await _authRepository.register(
        email: email,
        password: password,
      );
      if (user == null) {
        throw const AppException(
          'Erro ao criar usuário.',
        );
      }
      await _usersRepository.createUser(
        UserModel(
          id: user.id,
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

  String _handleError(Object error) {
    if (error is AppException) {
      return error.message;
    }
    return 'Ocorreu um erro inesperado.';
  }
}