import 'dart:io';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imthon5/feature/chat/ai/ai_service.dart';
import 'package:imthon5/feature/chat/data/model/message_model.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

final speechProvider = Provider<SpeechService>((ref) {
  return SpeechService();
});

final chatProvider = StateNotifierProvider<ChatNotifier, List<MessageModel>>(
  (ref) => ChatNotifier(ref),
);

final serviceProvider = Provider<AiService>((ref) {
  return AiService();
});

class ChatNotifier extends StateNotifier<List<MessageModel>> {
  final Ref ref;
  File? img;

  ChatNotifier(this.ref) : super([]);

  void sendImage(File? image) {
    img = image;
    state = [...state];
  }

  void removeImg() {
    img = null;
    state = [...state];
  }

  Future<void> sendMessage(String txt, Function(String) speek) async {
    if (txt.trim().isEmpty && img == null) return;

    state = [
      ...state,
      MessageModel(text: txt, image: img, isUser: true),
      MessageModel(text: "...", isUser: false),
    ];

    String aiRespns = "xatolik";

    try {
      if (img != null) {
        final imageBytes = await img!.readAsBytes();
        final res = await Gemini.instance.textAndImage(
          text: txt,
          images: [imageBytes],
        );
        aiRespns = res?.output ?? "javob yo'q";
      } else {
        final res = await Gemini.instance.text(txt);
        aiRespns = res?.output ?? "";
        await speek(aiRespns);
      }

      state = [
        ...state.sublist(0, state.length - 1),
        MessageModel(text: aiRespns, isUser: false),
      ];

      img = null;
    } catch (e) {
      state = [
        ...state.sublist(0, state.length - 1),
        MessageModel(text: "Xatolik: $e", isUser: false),
      ];
    }
  }

  Future<void> sendMessag(String answer, String nextOne) async {
    state = [...state, MessageModel(text: answer, isUser: true)];
    state = [...state, MessageModel(text: nextOne, isUser: false)];
  }
}

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  Future<void> listen(Function(String) onResult) async {
    if (_isListening) return;
    final available = await _speech.initialize();

    if (available && !_isListening) {
      _isListening = true;
      _speech.listen(
        localeId: 'en-US',
        onResult: (result) {
          if (result.finalResult) {
            final text = result.recognizedWords;
            _isListening = false;
            onResult(text);
          }
        },
      );
    }
  }

  Future<void> stop() async {
    await _speech.stop();
    _isListening = false;
  }

  bool get isListening => _isListening;
}
