import 'package:flutter/material.dart';

import '../../../models/chat/message_model.dart';

class MessageCard extends StatelessWidget {
  final MessageModel message;
  final String currentUserId;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MessageCard({
    super.key,
    required this.message,
    required this.currentUserId,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isMine = message.senderId == currentUserId;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isMine ? const Color(0xFF667EEA) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    message.senderName ?? 'Usuário',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: isMine ? Colors.white : const Color(0xFF667EEA),
                    ),
                  ),
                ),
                Text(
                  _formatTime(message.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: isMine ? Colors.white70 : Colors.grey.shade600,
                  ),
                ),
                if (isMine)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          onEdit?.call();
                          break;
                        case 'delete':
                          onDelete?.call();
                          break;
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8),
                              Text('Editar'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Excluir'),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              message.deleted ? 'Mensagem removida' : message.text ?? '',
              style: TextStyle(
                fontSize: 16,
                color: message.deleted
                    ? Colors.grey
                    : isMine
                    ? Colors.white
                    : Colors.black87,
                fontStyle: message.deleted
                    ? FontStyle.italic
                    : FontStyle.normal,
              ),
            ),
            if (message.editedAt != null && !message.deleted)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'editada',
                  style: TextStyle(
                    fontSize: 11,
                    color: isMine ? Colors.white70 : Colors.grey.shade500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime? date) {
    if (date == null) {
      return '';
    }
    return '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}
