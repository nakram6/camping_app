import 'ai_service.dart';
import 'openai_service.dart';
import 'gemma_service.dart';

class AIManager {
static AIService get service {
return OpenAIService();


// Future version:

// final online =
//     await NetworkService.hasInternet();

// if (online) {
//   return OpenAIService();
// }

// return GemmaService();


}
}
