import 'package:flutter_test/flutter_test.dart';
import 'package:imthon5/feature/chat/controller/chat_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('SpeechService toggles listening state', () async {
    final speech = SpeechService();

    expect(speech.isListening, false);

    await speech.listen((_) {});
    expect(speech.isListening, true);

    await speech.stop();
    expect(speech.isListening, false);
  });
}
