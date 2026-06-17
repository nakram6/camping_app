import 'package:flutter/material.dart';

import '../../services/settings/ai_settings_service.dart';

class AISettingsScreen
    extends StatefulWidget {
  const AISettingsScreen({
    super.key,
  });

  @override
  State<AISettingsScreen>
      createState() =>
          _AISettingsScreenState();
}

class _AISettingsScreenState
    extends State<
        AISettingsScreen> {
  String mode =
      AISettingsService.getMode();

  Future<void> saveMode(
    String value,
  ) async {
    await AISettingsService
        .setMode(value);

    setState(() {
      mode = value;
    });
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Settings',
        ),
      ),
      body: Column(
        children: [
          RadioListTile(
            title:
                const Text(
              'Automatic',
            ),
            value:
                'automatic',
            groupValue:
                mode,
            onChanged:
                (value) =>
                    saveMode(
              value!,
            ),
          ),

          RadioListTile(
            title:
                const Text(
              'OpenAI',
            ),
            value:
                'openai',
            groupValue:
                mode,
            onChanged:
                (value) =>
                    saveMode(
              value!,
            ),
          ),

          RadioListTile(
            title:
                const Text(
              'Gemma',
            ),
            value:
                'gemma',
            groupValue:
                mode,
            onChanged:
                (value) =>
                    saveMode(
              value!,
            ),
          ),
        ],
      ),
    );
  }
}