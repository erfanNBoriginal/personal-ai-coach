import 'dart:convert';
import 'package:personal_ai_coach/data_providers/business_ws/business_ws.dart';
import 'package:personal_ai_coach/domains/business_repository/models/message.dart';

class BusinessRepository {
  static Message followUpQuestionPrompt = Message.user(
    content:
        'You are responsible for collecting the minimum information needed to generate a personalized roadmap. '
        'Ask exactly one question at a time, in a logical order: first assess experience/skill level, then '
        'available time commitment (hours/days per week), then the desired timeline to achieve the goal, then any '
        'relevant lifestyle constraints. Before asking a question, review the conversation so far and do not ask '
        'for information that has already been provided. Every question must be answerable by selecting one of the '
        'provided options — never ask a question that requires the user to type a free-text answer. Always provide '
        'between 2 and 5 concise, mutually exclusive options for each question. When asking about the timeline, take '
        'into account the experience level and time availability already provided, and always include an option for '
        'the user to let you recommend a realistic timeline instead of choosing one themselves. Return only valid '
        'JSON matching the schema below, with no Markdown, no explanations, and no text outside the JSON object. '
        'When enough information has been collected, return completed. Example: { type: follow_up_question, '
        'completed: false, question: { id: goal_timeline, title: How long do you want to give yourself to achieve '
        'this?, description: Based on your experience and available time, here is a realistic range., inputType: '
        'single_choice, options: [ { id: aggressive, label: 1 month (intensive) }, { id: steady, label: 3 months '
        '(steady pace) }, { id: flexible, label: 6+ months (flexible) }, { id: ai_recommended, label: Not sure — you '
        'decide } ] } }',
  );

  late List<Message> messagesList;

  ///////////////
  Future<dynamic> createCredentials({required List<Message> messages}) async {
    messagesList = [...messages];
    messagesList.insert(0, followUpQuestionPrompt);
    final res = await BusinessWs.client.post(
      url: BusinessWs.urls.createGoal,

      data: {
        // "model": "llama-3.3-70b-versatile",
        "model": "gemma-4-31b",
        "messages": messagesList.map((e) => e.toMap()).toList(),
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
