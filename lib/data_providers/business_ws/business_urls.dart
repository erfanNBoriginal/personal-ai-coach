class BusinessServers {
  final develop = '';

  final stable = '';

  // String get current => T.Utils.isDebug ? develop : stable;
  String get current => develop;
}

class BusinessUrls {
  // final createGoal = 'https://api.groq.com/openai/v1/chat/completions';
  final createGoal = 'https://api.cerebras.ai/v1/chat/completions';
}
