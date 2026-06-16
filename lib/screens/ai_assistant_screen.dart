import 'package:flutter/material.dart';
import '../services/openai_service.dart';

class AIAssistantScreen extends StatefulWidget {
const AIAssistantScreen({super.key});

@override
State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
final TextEditingController controller = TextEditingController();

final OpenAIService aiService = OpenAIService();

bool isLoading = false;

final List<Map<String, String>> messages = [];

Future<void> sendMessage() async {
if (controller.text.trim().isEmpty) return;


final question = controller.text;

setState(() {
  isLoading = true;

  messages.add({
    "role": "user",
    "content": question,
  });
});

controller.clear();

final response =
    await aiService.askCampingAI(question);

setState(() {
  messages.add({
    "role": "assistant",
    "content": response,
  });

  isLoading = false;
});


}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Camping AI Assistant"),
),
body: Column(
children: [
Expanded(
child: ListView.builder(
itemCount: messages.length,
itemBuilder: (context, index) {
final message = messages[index];


            final isUser =
                message["role"] == "user";

            return Align(
              alignment: isUser
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isUser
                      ? Colors.blue
                      : Colors.green,
                  borderRadius:
                      BorderRadius.circular(16),
                ),
                child: Text(
                  message["content"] ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),

      if (isLoading)
        const Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(),
        ),

      Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText:
                      "Ask about camping...",
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) =>
                    sendMessage(),
              ),
            ),

            const SizedBox(width: 10),

            IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    ],
  ),
);


}
}
