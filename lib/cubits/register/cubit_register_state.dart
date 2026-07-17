import 'package:equatable/equatable.dart';

class CubitRegisterState extends Equatable {
  final bool isLoading;
  final String? errorMessage;

  const CubitRegisterState({
    this.isLoading = false,
    this.errorMessage,
  });

  static const _unset = Object();

  CubitRegisterState copyWith({
    bool? isLoading,
    Object? errorMessage = _unset,
  }) {
    return CubitRegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage == _unset
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  CubitRegisterState clearError() {
    return CubitRegisterState(
      isLoading: isLoading,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
  ];
}