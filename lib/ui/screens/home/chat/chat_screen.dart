import 'package:chat_realtime/ui/components/chat/message_card.dart';
import 'package:chat_realtime/ui/components/chat/message_input.dart';
import 'package:chat_realtime/ui/components/share/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/auth/auth_cubit.dart';
import '../../../../cubits/chat/cubit_chat.dart';
import '../../../../cubits/chat/cubit_chat_state.dart';
import '../../../../cubits/users/cubit_users.dart';


class ChatScreen extends StatefulWidget {

  const ChatScreen({
    super.key,
  });


  @override
  State<ChatScreen> createState() => _ChatScreenState();

}


class _ChatScreenState extends State<ChatScreen> {


  @override
  void initState() {

    super.initState();

    context.read<CubitChat>().watchMessages();

  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<CubitChat, CubitChatState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage!,
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF1F3FF),
              Color(0xFFE8ECFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CubitChat, CubitChatState>(
                builder: (context, state) {
                  if (state.messages == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.messages!.isEmpty) {
                    return const EmptyState(
                      message: "Nenhuma mensagem.",
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages!.length,
                    itemBuilder: (context, index) {
                      final message = state.messages![index];
                      return MessageCard(
                        message: message,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
                top: 8,
              ),
              child: MessageInput(
                onSend: (text) {
                  final loggedUser = context
                      .read<CubitUsers>()
                      .state
                      .loggedUser;
                  if (loggedUser == null) {
                    return;
                  }
                  context.read<CubitChat>().sendMessage(
                    text: text,
                    senderId: loggedUser.id,
                    senderName: loggedUser.name??"",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}