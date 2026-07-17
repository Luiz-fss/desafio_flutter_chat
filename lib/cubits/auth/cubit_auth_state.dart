import 'package:equatable/equatable.dart';

import '../../models/authentication/auth_user_model.dart';


class CubitAuthState extends Equatable {
  final bool isLoading;
  final AuthUserModel? user;
  final bool isInitialized;
  final String? errorMessage;

  const CubitAuthState({
    this.isLoading = false,
    this.user,
    this.isInitialized = false,
    this.errorMessage,
  });

  CubitAuthState copyWith({
    bool? isLoading,
    Object? user = _undefined,
    bool? isInitialized,
    Object? errorMessage = _undefined,
  }) {
    return CubitAuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user == _undefined
          ? this.user
          : user as AuthUserModel?,
      isInitialized: isInitialized ?? this.isInitialized,
      errorMessage: errorMessage == _undefined
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    user,
    isInitialized,
    errorMessage,
  ];
}

const _undefined = Object();