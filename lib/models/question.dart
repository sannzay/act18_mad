class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  // Helper function to decode HTML entities
  static String _decodeHtml(String htmlString) {
    return htmlString
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&shy;', '-')
        .replaceAll('&rdquo;', '"')
        .replaceAll('&ldquo;', '"')
        .replaceAll('&rsquo;', "'")
        .replaceAll('&lsquo;', "'");
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    // Decode options by combining incorrect answers with the correct
    // answer and shuffling them.
    List<String> options = List<String>.from(json['incorrect_answers'])
        .map((answer) => _decodeHtml(answer))
        .toList();
    String correctAnswer = _decodeHtml(json['correct_answer']);
    options.add(correctAnswer);
    options.shuffle();

    return Question(
      question: _decodeHtml(json['question']),
      options: options,
      correctAnswer: correctAnswer,
    );
  }
}

