import 'dart:core';

class FollowupQuestion {
  final bool isCompleted;
  final String id;
  final String label;
  final String description;
  final String inputType;
  final List<Question> questions;

  FollowupQuestion({
    required this.isCompleted,
    required this.id,
    required this.label,
    required this.description,
    required this.inputType,
    required this.questions,
  });

  factory FollowupQuestion.fromMap(Map<String, dynamic> map) {
    return FollowupQuestion(
      isCompleted: map['completed'],
      id: map['question']['id'],
      label: map['question']['title'],
      description: map['question']['description'],
      inputType: map['question']['inputType'],
      questions: List.from(map['question']['options'])
          .map((e) => Question.fromMap(e))
          .toList(),
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
