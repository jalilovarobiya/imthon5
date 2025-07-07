import 'package:flutter/material.dart';
import 'package:imthon5/feature/chat/data/model/message_model.dart';
import 'package:imthon5/feature/chat/presentation/widget/message_widget.dart';

class ChatBody extends StatelessWidget {
  final List<MessageModel> messages;

  const ChatBody({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (contex, index) {
          final data = messages[index];
          return MessageWidget(message: data, isMe: data.isUser);
        },
      ),
    );
  }
}
