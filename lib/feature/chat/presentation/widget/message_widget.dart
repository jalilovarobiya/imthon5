import 'package:flutter/material.dart';
import 'package:imthon5/feature/chat/data/model/message_model.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  const MessageWidget({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: EdgeInsets.all(12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isMe ? Colors.green : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.image != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Image.file(
                      message.image!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (message.text.isNotEmpty) Text(message.text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
