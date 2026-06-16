import 'package:hive/hive.dart';

class StorageService {
static Box get checklistBox =>
Hive.box('checklist');

static Box get chatBox =>
Hive.box('chat_history');

static Box get settingsBox =>
Hive.box('settings');

static Future<void> saveMessages(
List<Map<String, String>> messages) async {
await chatBox.put(
'messages',
messages
.map((e) => Map<String, String>.from(e))
.toList(),
);
}

static List<Map<String, String>>
loadMessages() {
final data =
chatBox.get('messages');


if (data == null) {
  return [];
}

return List<Map<String, String>>.from(
  (data as List).map(
    (item) => Map<String, String>.from(item),
  ),
);


}
}
