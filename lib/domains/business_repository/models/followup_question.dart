import 'dart:core';

class FollowupQuestion {
  final bool isCompleted;
  final String? id;
  final String? label;
  final String? description;
  final String? inputType;
  final List<Question> questions;

  FollowupQuestion({
    required this.isCompleted,
    this.id,
    this.label,
    this.description,
    this.inputType,
    required this.questions,
  });

  factory FollowupQuestion.fromMap(Map<String, dynamic> map) {
    final isCompleted = map['completed'] == true;
    final questionMap = map['question'] as Map<String, dynamic>?;

    if (isCompleted || questionMap == null) {
      return FollowupQuestion(isCompleted: isCompleted, questions: []);
    }

    return FollowupQuestion(
      isCompleted: isCompleted,
      id: questionMap['id'],
      label: questionMap['title'],
      description: questionMap['description'],
      inputType: questionMap['inputType'],
      questions: List.from(
        questionMap['options'],
      ).map((e) => Question.fromMap(e)).toList(),
    );
  }
}

class Question {
  final String id;
  final String label;
  Question({required this.id, required this.label});

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(id: map['id'], label: map['label']);
  }
}
