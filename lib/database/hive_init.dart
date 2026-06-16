import 'package:hive_flutter/hive_flutter.dart';

class HiveInit {
static Future<void> initialize() async {
await Hive.initFlutter();


await Hive.openBox('checklist');
await Hive.openBox('chat_history');
await Hive.openBox('settings');


}
}
