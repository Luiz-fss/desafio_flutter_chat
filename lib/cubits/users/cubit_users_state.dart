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

  CubitUsersState copyWith({
    bool? isLoading,
    List<UserModel>? users,
    UserModel? loggedUser,
    String? errorMessage,
  }) {
    return CubitUsersState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      loggedUser: loggedUser ?? this.loggedUser,
      errorMessage: errorMessage ?? this.errorMessage,
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