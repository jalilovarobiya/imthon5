import 'dart:io';

class MessageModel {
  final String text;
  final File? image;
  final bool isUser;

  MessageModel({required this.text, this.image, required this.isUser});
}
