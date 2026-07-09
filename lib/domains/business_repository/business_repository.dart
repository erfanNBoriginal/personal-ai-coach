import 'package:personal_ai_coach/data_providers/business_ws/business_ws.dart';
import 'package:personal_ai_coach/domains/business_repository/models/message.dart';

class BusinessRepository {
  static Message followUpQuestionPrompt = Message.user(content: '');

  Future<List<String>> createCredentials({
    required List<Message> messages,
  }) async {
    messages.insert(0, followUpQuestionPrompt);
    final res = await BusinessWs.client.post(
      url: BusinessWs.urls.createGoal,
      data: {
        "model": "llama-3.3-70b-versatile",
        "messages": [messages],
      },
    );
    return res.data;
  }
}
