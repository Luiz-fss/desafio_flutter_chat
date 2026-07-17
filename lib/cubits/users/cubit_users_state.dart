import 'package:equatable/equatable.dart';

import '../../models/user/user_model.dart';

class CubitUsersState extends Equatable {
  final bool isLoading;
  final List<UserModel>? users;
  final UserModel? loggedUser;
  final String? errorMessage;

  const CubitUsersState({
    this.isLoading = false,
    this.users,
    this.loggedUser,
    this.errorMessage,
  });

  static const _unset = Object();

  CubitUsersState copyWith({
    bool? isLoading,
    Object? users = _unset,
    Object? loggedUser = _unset,
    Object? errorMessage = _unset,
  }) {
    return CubitUsersState(
      isLoading: isLoading ?? this.isLoading,
      users: users == _unset
          ? this.users
          : users as List<UserModel>?,
      loggedUser: loggedUser == _unset
          ? this.loggedUser
          : loggedUser as UserModel?,
      errorMessage: errorMessage == _unset
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  CubitUsersState clearError() {
    return CubitUsersState(
      isLoading: isLoading,
      users: users,
      loggedUser: loggedUser,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    users,
    loggedUser,
    errorMessage,
  ];
}