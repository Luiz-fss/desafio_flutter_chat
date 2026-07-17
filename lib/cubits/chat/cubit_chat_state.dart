import 'package:equatable/equatable.dart';

import '../../models/chat/message_model.dart';

class CubitChatState extends Equatable {
  final bool isLoading;
  final List<MessageModel>? messages;
  final String? errorMessage;

  const CubitChatState({
    this.isLoading = false,
    this.messages,
    this.errorMessage,
  });

  CubitChatState copyWith({
    bool? isLoading,
    List<MessageModel>? messages,
    String? errorMessage,
  }) {
    return CubitChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    messages,
    errorMessage,
  ];
}