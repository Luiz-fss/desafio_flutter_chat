import 'package:chat_realtime/ui/components/chat/message_card.dart';
import 'package:chat_realtime/ui/components/chat/message_input.dart';
import 'package:chat_realtime/ui/components/share/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/chat/cubit_chat.dart';
import '../../../../cubits/chat/cubit_chat_state.dart';
import '../../../../cubits/users/cubit_users.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF1F3FF), Color(0xFFE8ECFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CubitChat, CubitChatState>(
                builder: (context, state) {
                  if (state.messages!.isEmpty) {
                    return const EmptyState(message: "Nenhuma mensagem.");
                  }
                  final loggedUser = context
                      .read<CubitUsers>()
                      .state
                      .loggedUser;
                  if (loggedUser == null) {
                    return const EmptyState(message: "Usuário não encontrado.");
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages!.length,
                    itemBuilder: (context, index) {
                      final message = state.messages![index];
                      return MessageCard(
                        message: message,
                        currentUserId: loggedUser.id,
                        onEdit: () {
                          _showEditDialog(context, message.text ?? '', (
                            newText,
                          ) {
                            context.read<CubitChat>().editMessage(
                              messageId: message.id,
                              text: newText,
                            );
                          });
                        },
                        onDelete: () {
                          _showDeleteDialog(context, message.id);
                        },
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
                    senderName: loggedUser.name ?? "",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String currentText,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: currentText);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar mensagem'),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Digite a nova mensagem',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final text = controller.text.trim();
                if (text.isEmpty) {
                  return;
                }
                onSave(text);
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String messageId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir mensagem'),
          content: const Text('Deseja realmente excluir esta mensagem?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                context.read<CubitChat>().deleteMessage(messageId: messageId);
                Navigator.pop(context);
              },
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
