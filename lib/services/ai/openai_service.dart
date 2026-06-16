import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'ai_service.dart';

class OpenAIService implements AIService {
@override
Future<String> ask(String question) async {
try {
final apiKey = dotenv.env['OPENAI_API_KEY'];


  if (apiKey == null || apiKey.isEmpty) {
    return "OpenAI API key not found.";
  }

  final response = await http.post(
    Uri.parse(
      'https://api.openai.com/v1/chat/completions',
    ),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "model": "gpt-4o-mini",
      "messages": [
        {
          "role": "system",
          "content":
              "You are an expert camping guide. Help users with camping trips, outdoor safety, weather preparation, camping gear, meal planning, hiking, navigation, first aid, and family camping."
        },
        {
          "role": "user",
          "content": question
        }
      ],
      "temperature": 0.7,
      "max_tokens": 500
    }),
  );

  if (response.statusCode != 200) {
    return "OpenAI Error: ${response.statusCode}";
  }

  final data = jsonDecode(response.body);

  return data["choices"][0]["message"]["content"]
      ?? "No response received.";
} catch (e) {
  return "Error: $e";
}


}
}
