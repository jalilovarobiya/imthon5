import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imthon5/core/utils/tts_helper.dart';
import 'package:imthon5/feature/chat/controller/chat_controller.dart';
import 'package:imthon5/feature/chat/data/model/message_model.dart';
import 'package:imthon5/feature/chat/presentation/widget/chat_body.dart';

class GiminiScreen extends ConsumerStatefulWidget {
  const GiminiScreen({super.key});

  @override
  ConsumerState<GiminiScreen> createState() => _GiminiScreenState();
}

class _GiminiScreenState extends ConsumerState<GiminiScreen> {
  final controller = TextEditingController();
  final ttsHelper = TtsHelper();
  List<MessageModel> messages = [];
  bool isInterview = false;

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider);
    final chatNotifier = ref.read(chatProvider.notifier);
    final speechService = ref.read(speechProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Gimini App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            onSelected: (value) {
              final provider = ref.read(serviceProvider);
              final chatnotifier = ref.read(chatProvider.notifier);

              provider.start(value);
              final first = provider.selectLanguage();
              if (first != null) {
                setState(() {
                  isInterview = true;
                });
                chatnotifier.sendMessag("Let's begin!", first);
                ttsHelper.speak(first);
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(value: 'Dart', child: Text('Dart')),
                  const PopupMenuItem(value: 'Python', child: Text('Python')),
                ],
          ),
        ],
      ),
      body: ChatBody(messages: messages),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (chatNotifier.img != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(
                      chatNotifier.img!,
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      onPressed: () => chatNotifier.removeImg(),
                      icon: Icon(Icons.close, color: Colors.red, size: 50),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image, size: 30, color: Colors.white),
                  onPressed: () async {
                    final picker = ImagePicker();
                    final image = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 85,
                      maxHeight: 1024,
                      maxWidth: 1024,
                    );
                    if (image != null) {
                      chatNotifier.sendImage(File(image.path));
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: controller,

                    decoration: InputDecoration(
                      hoverColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      hintText: "Matn kiriting",
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(chatNotifier),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (speechService.isListening) {
                      await speechService.stop();
                    } else {
                      if (isInterview) {
                        await _forInterview();
                      } else {
                        await _forUsual();
                      }
                    }
                  },
                  icon: Icon(
                    Icons.keyboard_voice_outlined,
                    size: 35,
                    color: Colors.white,
                  ),
                ),

                IconButton(
                  onPressed: () => _sendMessage(chatNotifier),
                  icon: Icon(Icons.send, size: 35, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(ChatNotifier notifier) async {
    final text = controller.text;
    controller.clear();
    notifier.sendMessage(text, (msg) => ttsHelper.speak(msg));
  }

  Future<void> _forInterview() async {
    final speech = ref.read(speechProvider);
    final chatNotifier = ref.read(chatProvider.notifier);
    final interviewService = ref.read(serviceProvider);

    await speech.listen((recognizedText) {
      final nextQ = interviewService.selectLanguage();
      chatNotifier.sendMessag(
        recognizedText,
        nextQ ?? "Thank you! Interview is over.",
      );
      if (nextQ != null) {
        ttsHelper.speak(nextQ);
      } else {
        setState(() {
          isInterview = false;
        });
      }
    });
  }

  Future<void> _forUsual() async {
    final speech = ref.read(speechProvider);
    final chatNotifier = ref.read(chatProvider.notifier);

    await speech.listen((recognizedText) {
      controller.text = recognizedText;
      _sendMessage(chatNotifier);
    });
  }
}
