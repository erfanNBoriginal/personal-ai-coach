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

  static Message roadmapGenerationPrompt = Message.user(
    content:
'You are an expert learning coach generating a personalized, realistic roadmap based on the user\'s goal and '
'collected profile information. Use the provided goal, experience level, time commitment, timeline, and '
'lifestyle constraints to structure a roadmap that is achievable and paced appropriately — do not create a '
'plan that is unrealistically fast or slow relative to the stated timeline and available hours per week. '
'Break the roadmap into sequential milestones, each with a clear title, description, start and end week, and '
'one checkpoint task that lets the user demonstrate they have absorbed that milestone. Milestones must '
'progress in difficulty from foundational to advanced. For the FIRST milestone only (order: 1), provide a '
'complete weeklyObjectives array containing one entry for every individual week within its startWeek and '
'endWeek range, with no skipped weeks. For all other milestones, return an empty weeklyObjectives array — '
'their weekly detail will be generated separately later, closer to when the user reaches them. Return only '
'valid JSON matching the schema below, with no Markdown, no explanations, and no text outside the JSON '
'object. Example: { type: roadmap, goal: string, summary: string, totalDurationWeeks: number, '
'difficultyProgression: string, milestones: [ { id: string, order: number, title: string, description: '
'string, startWeek: number, endWeek: number, weeklyObjectives: [ { week: number, focus: string, outcome: '
'string } ], checkpoint: { id: string, title: string, criteria: string } } ] }',
  );

  late List<Message> messagesList;

  ///////////////
  Future<dynamic> createCredentials({required List<Message> messages}) async {
    messagesList = [...messages];
    messagesList.insert(0, followUpQuestionPrompt);
    final res = await BusinessWs.client.post(
      url: BusinessWs.urls.cerebrasAi,

      data: {
        // "model": "llama-3.3-70b-versatile",
        "model": "gemma-4-31b",
        "messages": messagesList.map((e) => e.toMap()).toList(),
      },
    );

    return res.data;
  }

  Future<dynamic> createRoadmap({required Message message}) async {
    final messageListt = [];
    messageListt.insert(0, roadmapGenerationPrompt);
    messageListt.add(message);
    final res = await BusinessWs.client.post(
      url: BusinessWs.urls.cerebrasAi,
      data: {
        "model": "gemma-4-31b",
        "messages": messageListt.map((e) => e.toMap()).toList(),
      },
    );
    return res.data;
  }

  Future<List<Message>> readChatMessages() async {
    final res = [Message.ai(content: 'content')];
    Future.delayed(Duration(seconds: 2));
    return res;
  }
}
