import '../../domain/entities/evaluation_question.dart';

class EvaluationAnswerModel {
  final int answerId;
  final String answerContent;
  final String answerDescription;
  final int mark;

  const EvaluationAnswerModel({
    required this.answerId,
    required this.answerContent,
    required this.answerDescription,
    required this.mark,
  });

  factory EvaluationAnswerModel.fromJson(Map<String, dynamic> json) {
    return EvaluationAnswerModel(
      answerId: json['answerId'] ?? 0,
      answerContent: json['answerContent'] ?? '',
      answerDescription: json['answerDescription'] ?? '',
      mark: json['mark'] ?? 0,
    );
  }

  EvaluationAnswer toEntity() {
    return EvaluationAnswer(
      answerId: answerId,
      answerContent: answerContent,
      answerDescription: answerDescription,
      mark: mark,
    );
  }
}

class EvaluationQuestionModel {
  final int questionId;
  final String questionContent;
  final String questionDescription;
  final int maxMark;
  final List<EvaluationAnswerModel> answers;

  const EvaluationQuestionModel({
    required this.questionId,
    required this.questionContent,
    required this.questionDescription,
    required this.maxMark,
    required this.answers,
  });

  factory EvaluationQuestionModel.fromJson(Map<String, dynamic> json) {
    final answersJson = (json['answers'] as List<dynamic>?) ?? [];

    return EvaluationQuestionModel(
      questionId: json['questionId'] ?? 0,
      questionContent: json['questionContent'] ?? '',
      questionDescription: json['questionDescription'] ?? '',
      maxMark: json['maxMark'] ?? 0,
      answers: answersJson
          .map((e) => EvaluationAnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  EvaluationQuestion toEntity() {
    return EvaluationQuestion(
      questionId: questionId,
      questionContent: questionContent,
      questionDescription: questionDescription,
      maxMark: maxMark,
      answers: answers.map((a) => a.toEntity()).toList(),
    );
  }
}
