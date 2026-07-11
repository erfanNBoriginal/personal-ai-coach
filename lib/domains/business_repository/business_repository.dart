import 'dart:convert';

import 'package:personal_ai_coach/data_providers/business_ws/business_ws.dart';
import 'package:personal_ai_coach/domains/business_repository/models/followup_question.dart';
import 'package:personal_ai_coach/domains/business_repository/models/message.dart';

class BusinessRepository {
  static Message followUpQuestionPrompt = Message.user(
    content:
        'You are responsible for collecting the minimum information needed to generate a personalized roadmap. Ask exactly one question at a time. Return only valid JSON matching the schema below. Never return Markdown or explanations. When enough information has been collected, return completed. Example: { type: follow_up_question, completed: false, question: { id: experience, title: Programming Experience, description: This helps estimate your learning timeline., inputType: single_choice, options: [ { id: beginner, label: Im completely new }, { id: some, label: Ive built a few projects }, { id: professional, label: Im already a developer } ] } }',
  );
  final List<Message> messages = [];

  Future<dynamic> createCredentials({required Message message}) async {
    messages.add(message);
    messages.insert(0, followUpQuestionPrompt);
    final res = await BusinessWs.client.post(
      url: BusinessWs.urls.createGoal,
      data: {
        // "model": "llama-3.3-70b-versatile",
        "model": "gemma-4-31b",
        "messages": messages.map((e) => e.toMap(e)).toList(),
      },
    );

    final Map<String, dynamic> data = jsonDecode(
      res.data['message']['content'],
    );

    return res.data;
  }

  Future<List<Message>> readChatMessages() async {
    final res = [Message.ai(content: 'content')];
    Future.delayed(Duration(seconds: 2));
    return res;
  }
}
