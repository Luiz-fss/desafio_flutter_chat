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

  static const _unset = Object();

  CubitAuthState copyWith({
    bool? isLoading,
    Object? user = _unset,
    bool? isInitialized,
    Object? errorMessage = _unset,
  }) {
    return CubitAuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user == _unset ? this.user : user as AuthUserModel?,
      isInitialized: isInitialized ?? this.isInitialized,
      errorMessage: errorMessage == _unset
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  CubitAuthState clearError() {
    return CubitAuthState(
      isLoading: isLoading,
      user: user,
      isInitialized: isInitialized,
      errorMessage: null,
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