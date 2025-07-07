import 'package:flutter_tts/flutter_tts.dart';

class TtsHelper {
  final FlutterTts _tts = FlutterTts();

  TtsHelper() {
    _initializeTts();
  }

  void _initializeTts() {
    _tts.setLanguage("en-US");
    _tts.setSpeechRate(0.5); // gapirish tezligi
    _tts.setPitch(1.0); //  balandligi
    _tts.setVolume(1.0); // maksimal ovoz
  }

  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
