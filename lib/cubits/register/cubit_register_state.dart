import 'package:equatable/equatable.dart';

class CubitRegisterState extends Equatable {

  final bool isLoading;
  final String? errorMessage;


  const CubitRegisterState({
    this.isLoading = false,
    this.errorMessage,
  });


  CubitRegisterState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {

    return CubitRegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );

  }


  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
  ];

}