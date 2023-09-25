class Questions {
  final String questionText;
  final List<Answer> answerList;

  Questions(this.questionText, this.answerList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Questions> getquestions() {
  List<Questions> list = [];

  list.add(Questions("Who is The Owner Of Flutter", [
    Answer("Nokia", false),
    Answer("Samsung", false),
    Answer("Google", true),
    Answer("LG", false),
  ]));

  list.add(Questions("Ceo Of Apple", [
    Answer("Bill Gates", false),
    Answer("Steve Jobs", true),
    Answer("Sardha", false),
    Answer("Quied Azam", false),
  ]));

  list.add(Questions("Father Of Comp", [
    Answer("Alexander", false),
    Answer("Michel ", false),
    Answer("J", false),
    Answer("Charles Bagges", true),
  ]));

  list.add(Questions("Father Of Comp", [
    Answer("Alexander", false),
    Answer("Michel ", false),
    Answer("J", false),
    Answer("Charles Bagges", true),
  ]));

  return list;
}
