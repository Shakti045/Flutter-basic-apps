class Question {
  final String questiontext;
  final List<String> answers;
  const Question(this.questiontext, this.answers);

    List<String> get shuffledanswers {
    List<String> copiedanswers = List.of(answers);
    copiedanswers.shuffle();
    return copiedanswers;
  }

}
