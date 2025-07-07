class AiService {
  final List<String> dartQuestions = [
    "What is Dart and where is it used?",
    "What are the main features of Dart?",
    "How does async-await work in Dart?",
    "What are Futures and Streams?",
    "Can you explain null safety in Dart?",
  ];

  final List<String> pythonQuestions = [
    "What is Python used for?",
    "What are Python's key data structures?",
    "Explain the difference between list and tuple.",
    "What is a Python decorator?",
    "What are Python generators?",
  ];

  int currentIndex = 0;
  String language = "dart";

  void start(String languag) {
    language = languag;
    currentIndex = 0;
  }

  String? selectLanguage() {
    final list = language == "Python" ? pythonQuestions : dartQuestions;
    if (currentIndex < list.length) {
      final question = list[currentIndex];
      currentIndex++;
      return question;
    }
    return null;
  }
}
