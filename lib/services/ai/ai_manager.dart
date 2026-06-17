import 'ai_service.dart';
import 'openai_service.dart';
import 'gemma_service.dart';

import '../settings/ai_settings_service.dart';

class AIManager {
  static AIService get service {
    final mode =
        AISettingsService.getMode();

    switch (mode) {
      case 'gemma':
        return GemmaService();

      case 'openai':
        return OpenAIService();

      default:
        return OpenAIService();
    }
  }
}