import 'package:equatable/equatable.dart';

import '../../models/chat/message_model.dart';

class CubitChatState extends Equatable {
  final bool isLoading;
  final List<MessageModel> messages;
  final String? errorMessage;

  const CubitChatState({
    this.isLoading = false,
    this.messages = const [],
    this.errorMessage,
  });

  static const Object _unset = Object();

  CubitChatState copyWith({
    bool? isLoading,
    List<MessageModel>? messages,
    Object? errorMessage = _unset,
  }) {
    return CubitChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      errorMessage: errorMessage == _unset
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  CubitChatState clearError() {
    return CubitChatState(
      isLoading: isLoading,
      messages: messages,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    messages,
    errorMessage,
  ];
}