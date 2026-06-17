import 'package:hive/hive.dart';

class AISettingsService {
  static Box get box =>
      Hive.box('settings');

  static Future<void> setMode(
    String mode,
  ) async {
    await box.put(
      'ai_mode',
      mode,
    );
  }

  static String getMode() {
    return box.get(
      'ai_mode',
      defaultValue: 'automatic',
    );
  }
}