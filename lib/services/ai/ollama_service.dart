import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ai_service.dart';

class OllamaService
    implements AIService {

  @override
  Future<String> ask(
    String question,
  ) async {

    try {
      final response =
          await http.post(
        Uri.parse(
          'http://localhost:11434/api/generate',
        ),
        headers: {
          'Content-Type':
              'application/json',
        },
        body: jsonEncode({
          "model": "gemma3n",
          "prompt": question,
          "stream": false,
        }),
      );

      if (response.statusCode != 200) {
        return "Ollama error";
      }

      final data =
          jsonDecode(response.body);

      return data["response"];
    } catch (e) {
      return "Offline AI error: $e";
    }
  }
}