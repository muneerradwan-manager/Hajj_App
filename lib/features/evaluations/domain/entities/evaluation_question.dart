class EvaluationAnswer {
  final int answerId;
  final String answerContent;
  final String answerDescription;
  final int mark;

  const EvaluationAnswer({
    required this.answerId,
    required this.answerContent,
    required this.answerDescription,
    required this.mark,
  });
}

class EvaluationQuestion {
  final int questionId;
  final String questionContent;
  final String questionDescription;
  final int maxMark;
  final List<EvaluationAnswer> answers;

  const EvaluationQuestion({
    required this.questionId,
    required this.questionContent,
    required this.questionDescription,
    required this.maxMark,
    required this.answers,
  });
}
