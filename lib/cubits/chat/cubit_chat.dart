import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat/message_model.dart';
import '../../repositories/chat/i_chat_repository.dart';
import '../../utils/exceptions/app_exception.dart';

import 'cubit_chat_actions.dart';
import 'cubit_chat_state.dart';

class CubitChat extends Cubit<CubitChatState>
    implements CubitChatActions {

  final IChatRepository _chatRepository;

  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  CubitChat(this._chatRepository)
      : super(const CubitChatState());
  @override
  void watchMessages() {
    _messagesSubscription?.cancel();
    _messagesSubscription =
        _chatRepository.watchMessages().listen(
              (messages) {
            emit(
              state.copyWith(
                messages: messages,
                errorMessage: null,
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

  @override
  Future<void> sendMessage({
    required String text,
    required String senderId,
    required String senderName,
  }) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      );
      final message = MessageModel(
        id: '',
        senderId: senderId,
        senderName: senderName,
        text: text,
        createdAt: DateTime.now(),
      );
      await _chatRepository.sendMessage(
        message,
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

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}