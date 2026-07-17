import 'package:flutter/material.dart';


class MessageInput extends StatefulWidget {

  final Function(String text) onSend;


  const MessageInput({
    super.key,
    required this.onSend,
  });


  @override
  State<MessageInput> createState() => _MessageInputState();

}


class _MessageInputState extends State<MessageInput> {

  final _controller = TextEditingController();


  @override
  void dispose() {

    _controller.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _send(),
                decoration: const InputDecoration(
                  hintText: "Digite uma mensagem...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 22,
              backgroundColor: Color(0xFF667EEA),
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: _send,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }
    widget.onSend(text);
    _controller.clear();
  }
}